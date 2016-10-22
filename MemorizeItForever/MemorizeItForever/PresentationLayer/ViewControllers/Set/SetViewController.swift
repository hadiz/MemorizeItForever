//
//  SetViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 6/5/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

class SetViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: MemorizeItTableDataSourceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(SetViewController.fetchData), notificationNameEnum: NotificationEnum.setViewControllerReload, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initializeViewController(){
        title = "Set List"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SetViewController.addAction))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(SetViewController.editAction))
        
        let weakSelf = self
        
        dataSource = SetTableDataSource(handleTap: {[weak weakSelf] (memorizeItModel) in
            if let weakSelf = weakSelf{
                weakSelf.didSelectSet(memorizeItModel)
            }
            })
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        fetchData()
    }
    
    private func didSelectSet(_ model: MemorizeItModelProtocol?){
        presentSetItemViewController(EntityMode.edit, setModel: model as? SetModel)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func editAction(){
        tableView.setEditing(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(SetViewController.doneAction))
    }
    
    func doneAction(){
        tableView.setEditing(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(SetViewController.editAction))
    }
    
    func addAction(_ sender: AnyObject){
        presentSetItemViewController(EntityMode.save)
    }
    
    func fetchData(){
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let manager  = SetManager()
            let sets = manager.get().flatMap{$0 as MemorizeItModelProtocol}
            self.dataSource?.setModels(sets)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    private func presentSetItemViewController(_ entityMode: EntityMode, setModel: SetModel? = nil){
        let setItemViewController = SetItemViewController()
        setItemViewController.entityMode = entityMode
        setItemViewController.setModel  = setModel
        let nav1 = UINavigationController()
        nav1.viewControllers = [setItemViewController]
        nav1.modalPresentationStyle = .popover
        setItemViewController.preferredContentSize = CGSize(width: self.view.frame.width , height: 200)
        
        let popoverPresentationController = nav1.popoverPresentationController
        popoverPresentationController?.sourceView = self.tableView
        popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        popoverPresentationController?.delegate = setItemViewController
        
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        
        present(nav1, animated: true, completion: nil)
    }
}
