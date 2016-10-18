//
//  MemorizeItViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/11/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

class MemorizeItViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTapped(_ sender: AnyObject){
        let storyboard : UIStoryboard = UIStoryboard(name: "SetManagement",bundle: nil)
        let setViewController: SetViewController = storyboard.instantiateViewController(withIdentifier: "SetViewController") as! SetViewController
        
        let nav1 = UINavigationController()
        nav1.viewControllers = [setViewController]
        nav1.modalPresentationStyle = .popover
        setViewController.preferredContentSize = CGSize(width: self.view.frame.width  / 2, height: 250)
        
        let popoverPresentationController = nav1.popoverPresentationController
        popoverPresentationController?.sourceView = sender as? UIView
        popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.size.width, height: sender.frame.size.height)
        popoverPresentationController?.delegate = setViewController
        
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        
        present(nav1, animated: true, completion: nil)
        
    }
    
    @IBAction func setAction(_ sender: AnyObject) {
        setTapped(sender)
    }

}
