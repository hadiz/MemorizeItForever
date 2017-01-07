//
//  PhraseHistoryViewCoordinator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/8/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class PhraseHistoryViewCoordinator: UIViewCoordinatorDelegate {
    
    weak var viewController: PhraseHistoryViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController as? PhraseHistoryViewController
    }
    
    func defineControls() {
        guard let viewController = viewController else { return }
        
        viewController.tableView = MITableView()
        viewController.tableView.dataSource = viewController.dataSource
        viewController.tableView.delegate = viewController.dataSource
        viewController.tableView.registerClass(Value1UITableViewCell.self, forCellReuseIdentifierEnum: .phraseHistoryTableCellIdentifier)
        viewController.automaticallyAdjustsScrollViewInsets = false
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
}
