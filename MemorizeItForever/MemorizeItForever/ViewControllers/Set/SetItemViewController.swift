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
    
    var entityMode: EntityMode?
    var setModel: SetModel?
    var setService: SetServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setName.placeholder = NSLocalizedString("Name", comment: "Name title")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(SetItemViewController.saveAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SetItemViewController.cancelAction))
        
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if entityMode == .save{
//            self.title = NSLocalizedString("New Set", comment: "New set title")
//        }
//        else{
//            self.title = NSLocalizedString("Edit Set", comment: "Edit set title")
//        }
        
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
    @IBOutlet weak var setName: MITextField!
}
