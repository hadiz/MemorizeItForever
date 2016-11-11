//
//  SetViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 6/5/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class SetViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: MemorizeItTableDataSourceProtocol?
    var setManager: SetManagerProtocol?
    
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
        guard let setManager = setManager else {
            fatalError("setManager is not initialiazed")
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let sets = setManager.get().flatMap{$0 as MemorizeItModelProtocol}
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
        
        let size = CGSize(width: self.view.frame.width , height: 200)
        self.presentingPopover(setItemViewController, sourceView: self.tableView, popoverArrowDirection: .any, contentSize: size)
    }
}
