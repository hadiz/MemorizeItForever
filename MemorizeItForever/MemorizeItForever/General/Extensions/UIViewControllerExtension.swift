//
//  UIViewControllerExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/30/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentingPopover(_ viewController: UIViewController, sourceView: UIView, popoverArrowDirection: UIPopoverArrowDirection, contentSize: CGSize){
        let nav1 = UINavigationController()
        nav1.viewControllers = [viewController]
        nav1.modalPresentationStyle = .popover
        viewController.preferredContentSize = contentSize
        
        let popoverPresentationController = nav1.popoverPresentationController
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sourceView.frame.size.width, height: sourceView.frame.size.height)
        if let viewController = viewController as? UIPopoverPresentationControllerDelegate{
            popoverPresentationController?.delegate = viewController
        }
        popoverPresentationController?.permittedArrowDirections = popoverArrowDirection
        
        present(nav1, animated: true, completion: nil)
        
    }
    
    func addTaskDoneView() -> UIView{
        let taskDoneView = UIView()
        taskDoneView.translatesAutoresizingMaskIntoConstraints = false
        taskDoneView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.9)
        taskDoneView.layer.cornerRadius = 10.0
        taskDoneView.clipsToBounds = true
        taskDoneView.tag = SubViewsEnum.taskDoneView.rawValue
        
        let hooray = MILabel()
        hooray.text = "Hooray!"
        hooray.font =  hooray.font.withSize(35)
        hooray.textColor = UIColor.darkGray
        hooray.textAlignment = .center
        
        let taskDone = MILabel()
        taskDone.text = "The task is done"
        taskDone.font =  hooray.font.withSize(35)
        taskDone.numberOfLines = 0
        taskDone.lineBreakMode = .byCharWrapping
        taskDone.textColor = UIColor.darkGray
        taskDone.textAlignment = .center
        
        taskDoneView.addSubview(hooray)
        taskDoneView.addSubview(taskDone)
        self.view.addSubview(taskDoneView)
        
        var constraintList: [NSLayoutConstraint] = []
        
        constraintList.append(hooray.leadingAnchor.constraint(equalTo: taskDoneView.leadingAnchor, constant: 8))
        constraintList.append(hooray.trailingAnchor.constraint(equalTo: taskDoneView.trailingAnchor, constant: -8))
        constraintList.append(hooray.bottomAnchor.constraint(equalTo: taskDone.topAnchor, constant: -24))
        
        constraintList.append(taskDone.leadingAnchor.constraint(equalTo: taskDoneView.leadingAnchor, constant: 8))
        constraintList.append(taskDone.trailingAnchor.constraint(equalTo: taskDoneView.trailingAnchor, constant: -8))
        constraintList.append(taskDone.centerYAnchor.constraint(equalTo: taskDoneView.centerYAnchor))

        
        NSLayoutConstraint.activate(constraintList)
        
        return taskDoneView
    }
    
    func removeTaskDoneView(){
        for view in self.view.subviews{
            if view.tag == SubViewsEnum.taskDoneView.rawValue{
                view.removeFromSuperview()
                break
            }
        }
    }
}
