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
    var setService: SetServiceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print("init SetItemViewController")
    }
    
    deinit {
        print("DEINIT SetItemViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if entityMode == .save{
            self.title = "New Set"
        }
        else{
            self.title = "Edit Set"
        }
        
        DispatchQueue.main.async(execute: {
            if let setModel = self.setModel, self.entityMode == .edit{
                self.setName.text = setModel.name
            }
            else{
                self.setName.text = ""
            }
        })
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
        guard let setService = setService else {
            fatalError("setService is not initialiazed")
        }
        setService.save(setName.text!)
    }
    
    func edit(){
        guard let setService = setService else {
            fatalError("setService is not initialiazed")
        }
        setService.edit(setModel!, setName: setName.text!)
    }
}
