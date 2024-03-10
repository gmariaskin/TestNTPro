import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    enum CurrentSorting {
        case up
        case down
    }
    
    private let mainView = MainTableView()
    private let server = Server()
    private var model: [Deal] = []
    private var currentSorting: CurrentSorting = .down
    
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = "Deals"
        
        mainView.tableView.register(UINib(nibName: DealCell.reuseIidentifier, bundle: nil), forCellReuseIdentifier: DealCell.reuseIidentifier)
        mainView.tableView.register(UINib(nibName: HeaderCell.reuseIidentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderCell.reuseIidentifier)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.filterPanel.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        mainView.filterPanel.addTarget(self, action: #selector(segmentTapped), for: .touchDown)
        
        server.subscribeToDeals { deals in
            self.model.append(contentsOf: deals)
            self.mainView.tableView.reloadData()
        }
        
        self.model.sort(by: {$0.dateModifier < $1.dateModifier})
        self.mainView.tableView.reloadData()
        
    }
    
    //MARK: - Actions
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {

        segmentTapped(sender)
    }
    
    @objc private func segmentTapped(_ sender: UISegmentedControl) {
        
        switch currentSorting {
        case .up:
            switch sender.selectedSegmentIndex {
            case 0:
                model.sort(by: {$0.dateModifier < $1.dateModifier})
            case 1:
                model.sort(by: {$0.instrumentName < $1.instrumentName})
            case 2:
                model.sort(by: {$0.price < $1.price})
            case 3:
                model.sort(by: {$0.amount < $1.amount})
            case 4:
                model.sort(by: {$0.side < $1.side})
            default:
                break
            }
            mainView.tableView.reloadData()
            currentSorting = .down
        case .down:
            switch sender.selectedSegmentIndex {
            case 0:
                model.sort(by: {$0.dateModifier > $1.dateModifier})
            case 1:
                model.sort(by: {$0.instrumentName > $1.instrumentName})
            case 2:
                model.sort(by: {$0.price > $1.price})
            case 3:
                model.sort(by: {$0.amount > $1.amount})

            case 4:
                model.sort(by: {$0.side > $1.side})
            default:
                break
            }
            mainView.tableView.reloadData()
            currentSorting = .up
        default: break
        }
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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

