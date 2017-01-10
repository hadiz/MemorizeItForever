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
    var setService: SetServiceProtocol!
    var coordinatorDelegate: UIViewCoordinatorDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinatorDelegate.applyViews()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(SetItemViewController.saveAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SetItemViewController.cancelAction))
        
        self.view.backgroundColor = UIColor.white
        
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
        setService.save(setName.text!)
    }
    
    func edit(){
        
        setService.edit(setModel!, setName: setName.text!)
    }
}
