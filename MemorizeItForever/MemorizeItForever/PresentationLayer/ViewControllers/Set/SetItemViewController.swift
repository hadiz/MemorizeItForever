//
//  SetItemViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 9/2/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class SetItemViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var setName: UITextField!
    
    var entityMode: EntityMode?
    var setModel: SetModel?
    var setManager: SetManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if entityMode == .save{
            self.title = "New Set"
        }
        else{
            self.title = "Edit Set"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(SetItemViewController.saveAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SetItemViewController.cancelAction))
        
        self.view.backgroundColor = UIColor.white
        
        setName = MITextField()
        setName.placeholder = "Name"
        
        self.view.addSubview(setName)
        
        let views: Dictionary<String, AnyObject> = ["setName": setName,
                     "topLayoutGuide": topLayoutGuide]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let hSetNameCnst = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[setName]-|",
            options: [],
            metrics: nil,
            views: views)
        
        let vSetNameCnst = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[topLayoutGuide]-50-[setName]",
            options: [],
            metrics: nil,
            views: views)
        
        
        allConstraints += hSetNameCnst
        allConstraints += vSetNameCnst
        
        NSLayoutConstraint.activate(allConstraints)
        
        if let setModel = setModel , entityMode == .edit{
            DispatchQueue.main.async(execute: {
                self.setName.text = setModel.name
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func saveAction(){
        if entityMode == .save{
            save()
        }
        else{
            edit()
        }
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(.setViewControllerReload, object: nil)
    }
    
    func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func save(){
        guard let setManager = setManager else {
            fatalError("setManager is not initialiazed")
        }
        setManager.save(setName.text!)
    }
    
    func edit(){
        guard let setManager = setManager else {
            fatalError("setManager is not initialiazed")
        }
        setManager.edit(setModel!, setName: setName.text!)
    }
}
