import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    enum CurrentSorting {
        case down
        case up
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
        mainView.filterPanel.selectedSegmentIndex = 0
        
        fetchData()
    }
    
    //MARK: - Actions
    
    private func fetchData() {
        server.subscribeToDeals { deals in
            self.model.append(contentsOf: deals)
            self.sortModel()
            self.mainView.tableView.reloadData()
        }
    }
    
    private func sortModel() {
        
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
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        
        toggleSortingOrder()
        sortModel()
        mainView.tableView.reloadData()
    }
    
    @objc private func segmentTapped(_ sender: UISegmentedControl) {
        
        toggleSortingOrder()
        sortModel()
        mainView.tableView.reloadData()
    }
    
    private func toggleSortingOrder() {
        
        currentSorting = (currentSorting == .down) ? .up : .down
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

