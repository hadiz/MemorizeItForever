//
//  ChangeSetViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

class ChangeSetViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    private var tableView: UITableView!
    private var dataSource: MemorizeItTableDataSourceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    private func initializeViewController(){
        title = "Change Set"
        defineControls()
        addControls()
        applyAutoLayout()
        fetchData()
    }
    
    private func defineControls(){
        tableView = MITableView()
        let weakSelf = self
        
        dataSource = ChangeSetTableDataSource(handleTap: {[weak weakSelf] (memorizeItModel) in
            if let weakSelf = weakSelf{
                weakSelf.didSelectSet(memorizeItModel)
            }
            })
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    private func addControls(){
        self.view.addSubview(tableView)
    }
    
    private func applyAutoLayout(){
        var viewDic: Dictionary<String,Any> = [:]
        var constraintList: [NSLayoutConstraint] = []
        
        viewDic["topLayoutGuide"] = topLayoutGuide
        viewDic["bottomLayoutGuide"] = bottomLayoutGuide
        viewDic["tableView"] = tableView
        
        let hTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [], metrics: nil, views: viewDic)
        
        let vTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[tableView]-[bottomLayoutGuide]", options: [], metrics: nil, views: viewDic)
        
        constraintList += hTableViewCnst
        constraintList += vTableViewCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
    private func didSelectSet(_ model: MemorizeItModelProtocol?){
        var setId: UUID?
        if let setDic = UserDefaults.standard.object(forKey: Settings.defaultSet.rawValue) as? Dictionary<String, Any>,
            let setModel = SetModel(dictionary: setDic) {
            setId = setModel.setId
        }
        let setModel = model as! SetModel
        if setId != setModel.setId{
            UserDefaults.standard.set(setModel.toDic(), forKey: Settings.defaultSet.rawValue)
            NotificationCenter.default.post(.setChanged, object: nil)
        }
    }
    
    private func fetchData(){
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let manager  = SetManager()
            let sets = manager.get().flatMap{$0 as MemorizeItModelProtocol}
            self.dataSource?.setModels(sets)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}
