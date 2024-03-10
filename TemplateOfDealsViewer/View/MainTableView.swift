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
    
    let sortingButton: UIButton = {
        let obj = UIButton()
        
        obj.layer.backgroundColor = UIColor.gray.cgColor
        obj.layer.cornerRadius = 10
        obj.setImage(UIImage(named: "arrowDown"), for: .normal)
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
        addSubview(sortingButton)
        
       
        
        filterPanel.insertSegment(withTitle: "Date", at: 0, animated: true)
        filterPanel.insertSegment(withTitle: "Instrument", at: 1, animated: true)
        filterPanel.insertSegment(withTitle: "Price", at: 2, animated: true)
        filterPanel.insertSegment(withTitle: "Amount", at: 3, animated: true)
        filterPanel.insertSegment(withTitle: "Side", at: 4, animated: true)
        filterPanel.backgroundColor = .black

        
        filterPanel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(50)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
        }
        
        sortingButton.snp.makeConstraints { make in
            make.leading.equalTo(filterPanel.snp.trailing)
            make.top.equalToSuperview().offset(100)
            make.trailing.equalToSuperview()
            make.size.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(filterPanel.snp.bottom)
        }
    }
 
}
