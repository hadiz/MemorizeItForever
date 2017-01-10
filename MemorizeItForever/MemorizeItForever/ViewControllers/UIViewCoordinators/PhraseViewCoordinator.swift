//
//  PhraseViewCoordinator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/10/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class PhraseViewCoordinator: UIViewCoordinatorDelegate{
    
    weak var viewController: PhraseViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController as? PhraseViewController
    }
    
    func defineControls() {
        guard let viewController = viewController else { return }
        
        viewController.tableView = MITableView()
        viewController.tableView.dataSource = viewController.dataSource
        viewController.tableView.delegate = viewController.dataSource
        viewController.tableView.registerClass(SubtitleUITableViewCell.self, forCellReuseIdentifierEnum: .phraseTableCellIdentifier)
        
        
        viewController.searchController = UISearchController(searchResultsController: nil)
        viewController.searchController.searchResultsUpdater = viewController
        viewController.searchController.dimsBackgroundDuringPresentation = false
        viewController.searchController.searchBar.scopeButtonTitles = getScopeTitles()
        viewController.searchController.searchBar.delegate = viewController
        viewController.tableView.tableHeaderView = viewController.searchController.searchBar
    }
    
    func addControls() {
        guard let viewController = viewController else { return }
        
        viewController.view.addSubview(viewController.tableView)
    }
    
    func applyAutoLayout() {
        guard let viewController = viewController else { return }
        
        var constraintList: [NSLayoutConstraint] = []
        var viewDict = viewController.getViewDict()
        
        viewDict["tableView"] = viewController.tableView
        
        let hTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [], metrics: nil, views: viewDict)
        
        let vTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[tableView]-[bottomLayoutGuide]", options: [], metrics: nil, views: viewDict)
        
        constraintList += hTableViewCnst
        constraintList += vTableViewCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    private func getScopeTitles() -> [String]{
        guard let viewController = viewController else { return []}
        
        var list: [String] = []
        
        for item in viewController.wordStatusList{
            list.append(item.getString())
        }
        return list
    }
    
}
