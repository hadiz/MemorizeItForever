//
//  MemorizeItViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/11/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

final class MemorizeItViewController: UIViewController {
    
    var viewControllerFactory: ViewControllerFactoryProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setTapped(_ sender: AnyObject){
        let storyboard : UIStoryboard = UIStoryboard(name: "SetManagement",bundle: nil)
        let setViewController: SetViewController = storyboard.instantiateViewController(withIdentifier: "SetViewController") as! SetViewController
        let contentSize = CGSize(width: self.view.frame.width  / 2, height: 250)
        self.presentingPopover(setViewController, sourceView: sender as! UIView, popoverArrowDirection: .any, contentSize: contentSize)
    }
    
    private func reviewPhraseTapped(_ sender: AnyObject){
        let reviewPhraseViewController = viewControllerFactory.reviewPhraseViewControllerFactory()
        let contentSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 20)
        self.presentingPopover(reviewPhraseViewController, sourceView: sender as! UIView, popoverArrowDirection: UIPopoverArrowDirection(rawValue: 0), contentSize: contentSize)
    }
    
    private func changeSetTapped(_ sender: AnyObject){
        let changeSetViewController = viewControllerFactory.changeSetViewControllerFactory()
        let contentSize = CGSize(width: self.view.frame.width  / 2, height: 250)
        self.presentingPopover(changeSetViewController, sourceView: sender as! UIView, popoverArrowDirection: .any, contentSize: contentSize)
    }
    
    private func addPhraseTapped(_ sender: AnyObject){
        let addPhraseViewController = viewControllerFactory.addPhraseViewControllerFactory()
        let contentSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 20)
        self.presentingPopover(addPhraseViewController, sourceView: sender as! UIView, popoverArrowDirection: UIPopoverArrowDirection(rawValue: 0), contentSize: contentSize)
    }
    
    private func takeATestTapped(_ sender: AnyObject){
       let takeTestViewController = viewControllerFactory.takeTestViewControllerFactory()
        let contentSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 20)
        self.presentingPopover(takeTestViewController, sourceView: sender as! UIView, popoverArrowDirection: UIPopoverArrowDirection(rawValue: 0), contentSize: contentSize)
    }
    
    private func phraseManagementTapped(_ sender: AnyObject){
        let phraseViewController = viewControllerFactory.phraseViewControllerFactory()
        let contentSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 20)
        self.presentingPopover(phraseViewController, sourceView: sender as! UIView, popoverArrowDirection: UIPopoverArrowDirection(rawValue: 0), contentSize: contentSize)
    }
    
    @IBAction func setAction(_ sender: AnyObject) {
        setTapped(sender)
    }
    @IBAction func reviewPhraseAction(_ sender: AnyObject) {
        reviewPhraseTapped(sender)
    }
    @IBAction func changeSetAction(_ sender: AnyObject) {
        changeSetTapped(sender)
    }
    
    @IBAction func addPhraseAction(_ sender: AnyObject) {
        addPhraseTapped(sender)
    }
    @IBAction func takeATestAction(_ sender: AnyObject) {
        takeATestTapped(sender)
    }
    @IBAction func phraseManagementAction(_ sender: AnyObject) {
        phraseManagementTapped(sender)
    }
    
}
