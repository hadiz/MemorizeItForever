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
}
