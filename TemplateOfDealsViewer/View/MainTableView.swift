//
//  MainView.swift
//  TemplateOfDealsViewer
//
//  Created by Gleb on 08.03.2024.
//

import UIKit
import SnapKit

class MainTableView: UIView {
    
    //MARK: - Properties
    
    var tableView = UITableView()
    
    let filterPanel: CustomSegmentedControl = {
        let obj = CustomSegmentedControl()
        obj.isEnabled = true
        obj.tintColor = .white
        obj.layer.backgroundColor = UIColor.white.cgColor
        return obj
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    private func setup() {
        
        addSubview(tableView)
        addSubview(filterPanel)
        
        filterPanel.insertSegment(withTitle: "Date", at: 0, animated: true)
        filterPanel.insertSegment(withTitle: "Instrument", at: 1, animated: true)
        filterPanel.insertSegment(withTitle: "Price", at: 2, animated: true)
        filterPanel.insertSegment(withTitle: "Amount", at: 3, animated: true)
        filterPanel.insertSegment(withTitle: "Side", at: 4, animated: true)
        filterPanel.backgroundColor = .black

        
        filterPanel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(filterPanel.snp.bottom)
        }
    }
 
}
