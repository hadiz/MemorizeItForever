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
    var dataSource: SetTableDataSourceProtocol!
    var setService: SetServiceProtocol!
    
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
//        title = NSLocalizedString("Set List", comment: "Set list title")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SetViewController.addAction))
        
        let close = NSLocalizedString("Close", comment: "Close bar button title")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: close, style: .plain, target: self, action: #selector(SetViewController.closeBarButtonTapHandler))
        
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
    
    @objc func closeBarButtonTapHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addAction(_ sender: AnyObject){
        presentSetItemViewController(EntityMode.save)
    }
    
    @objc
    func fetchData(){
    
        let rawSets = self.setService.get()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let sets = rawSets.compactMap{$0 as MemorizeItModelProtocol}
            self.dataSource?.setModels(sets)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    private func presentSetItemViewController(_ entityMode: EntityMode, setModel: SetModel? = nil){
        let storyboard : UIStoryboard = UIStoryboard(name: "SetManagement",bundle: nil)
        let setItemViewController = storyboard.instantiateViewController(withIdentifier: "SetItemViewController") as! SetItemViewController
        setItemViewController.entityMode = entityMode
        setItemViewController.setModel  = setModel
        
        let size = CGSize(width: self.view.frame.width , height: 200)
        self.presentingPopover(setItemViewController, sourceView: self.tableView, popoverArrowDirection: .any, contentSize: size)
        
    }
}
