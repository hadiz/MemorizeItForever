//
//  SetItemViewCoordinator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/10/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class SetItemViewCoordinator: UIViewCoordinatorDelegate{
    
    weak var viewController: SetItemViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController as? SetItemViewController
}
    
    func defineControls() {
        guard let viewController = viewController else { return }
        
        viewController.setName = MITextField()
        viewController.setName.placeholder = "Name"
    }
    
    func addControls() {
        guard let viewController = viewController else { return }
        
        viewController.view.addSubview(viewController.setName)
    }
    
    func applyAutoLayout() {
        guard let viewController = viewController else { return }
        
        var constraintList: [NSLayoutConstraint] = []
        
        var viewDict = viewController.getViewDict()
        
        viewDict["setName"] = viewController.setName
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let hSetNameCnst = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[setName]-|",
            options: [],
            metrics: nil,
            views: viewDict)
        
        let vSetNameCnst = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[topLayoutGuide]-50-[setName]",
            options: [],
            metrics: nil,
            views: viewDict)
        
        
        allConstraints += hSetNameCnst
        allConstraints += vSetNameCnst
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
