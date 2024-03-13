import UIKit

class DealListViewController: UIViewController {
    
    //MARK: - Properties
    
    enum CurrentSorting {
        case down
        case up
        
        func getImage() -> UIImage {
            switch self {
            case .down:
                return UIImage(named: "arrowDown")!
            case .up:
                return UIImage(named: "arrowUp")!
            }
        }
    }
    
    private let mainView = ListTableView()
    private let server = Server()
    private var model: [Deal] = []
    private var currentSorting: CurrentSorting = .down
    
    // Sorting UI elements are diabled when data is fetching
    
    private var isFetchingData: Bool = false {
        didSet {
            mainView.filterPanel.isEnabled = !isFetchingData
            mainView.sortingButton.isEnabled = !isFetchingData
        }
    }
    
    //MARK: - Lifecycle
    
    init() {
        isFetchingData = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Deals"
        
        setup()
        fetchData()
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate

extension DealListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DealCell.reuseIidentifier, for: indexPath) as! DealCell
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.reuseIidentifier) as! HeaderCell
        return cell
    }
}

//MARK: - Private extension



private extension DealListViewController {
    
    func setup() {
        
        mainView.tableView.register(UINib(nibName: DealCell.reuseIidentifier, bundle: nil), forCellReuseIdentifier: DealCell.reuseIidentifier)
        mainView.tableView.register(UINib(nibName: HeaderCell.reuseIidentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderCell.reuseIidentifier)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.filterPanel.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        mainView.filterPanel.addTarget(self, action: #selector(segmentTapped), for: .touchDown)
        mainView.filterPanel.selectedSegmentIndex = 0
        
        mainView.sortingButton.addTarget(self, action: #selector(sortingButtonTapped), for: .touchUpInside)
    }
    
    func fetchData() {
        
       self.isFetchingData = true
        server.subscribeToDeals { deals in
       
            self.model.append(contentsOf: deals)
            self.sortModel()
            self.mainView.tableView.reloadData()
            self.isFetchingData = false
        }
    }
    
    func sortModel() {
        
        // Checking if data for sorting exists
        
        guard model.count >= 2 else {
            print ("Model array contains less than 2 elements")
            return
        }
            switch (mainView.filterPanel.selectedSegmentIndex, currentSorting) {
            case (0, .up):
                model.sort(by: {$0.dateModifier < $1.dateModifier})
            case (0, .down):
                model.sort(by: {$0.dateModifier > $1.dateModifier})
            case (1, .up):
                model.sort(by: {$0.instrumentName < $1.instrumentName})
            case (1, .down):
                model.sort(by: {$0.instrumentName > $1.instrumentName})
            case (2, .up):
                model.sort(by: {$0.price < $1.price})
            case (2, .down):
                model.sort(by: {$0.price > $1.price})
            case (3, .up):
                model.sort(by: {$0.amount < $1.amount})
            case (3, .down):
                model.sort(by: {$0.amount > $1.amount})
            case (4, .up):
                model.sort(by: {$0.side < $1.side})
            case (4, .down):
                model.sort(by: {$0.side > $1.side})
            default:
                break
            }
        
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        
        guard !isFetchingData else {
                  return
              }
        changeSortingDirection()
    }
    
    @objc func segmentTapped(_ sender: UISegmentedControl) {
        
        guard !isFetchingData else {
                  return
              }
        changeSortingDirection()
    }
    
    @objc func sortingButtonTapped() {
        
        guard !isFetchingData else {
                  return
              }
        changeSortingDirection()
    }
    
    func changeSortingDirection() {
        
        toggleSortingOrder()
        sortModel()
        mainView.tableView.reloadData()
    }
    
    func toggleSortingOrder() {
        
        currentSorting = (currentSorting == .down) ? .up : .down
  
        mainView.sortingButton.setImage(currentSorting.getImage(), for: .normal)
    }
    
}


