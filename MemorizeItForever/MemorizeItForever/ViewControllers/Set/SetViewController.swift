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
    var dataSource: SetTableDataSourceProtocol?
    var setManager: SetManagerProtocol?
    var setItemViewController: SetItemViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
        print("init SetViewController")
    }
    
    deinit {
        print("DEINIT SetViewController")
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(SetViewController.closeBarButtonTapHandler))
        
        guard let dataSource = dataSource else {
            fatalError("dataSource is not initialiazed")
        }
        
        let weakSelf = self
        dataSource.handleTap = {[weak weakSelf] (memorizeItModel) in
            if let weakSelf = weakSelf{
                weakSelf.didSelectSet(memorizeItModel)
            }
        }
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        fetchData()
    }
    
    func didSelectSet(_ model: MemorizeItModelProtocol?){
        presentSetItemViewController(EntityMode.edit, setModel: model as? SetModel)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func closeBarButtonTapHandler(){
        self.dismiss(animated: true, completion: nil)
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
        guard let setItemViewController = setItemViewController else {
            fatalError("setItemViewController is not initialized")
        }
        setItemViewController.entityMode = entityMode
        setItemViewController.setModel  = setModel
        
        let size = CGSize(width: self.view.frame.width , height: 200)
        self.presentingPopover(setItemViewController, sourceView: self.tableView, popoverArrowDirection: .any, contentSize: size)
        
    }
}
