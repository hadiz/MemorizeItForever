//
//  ChangeSetViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class ChangeSetViewController: VFLBasedViewController, UIPopoverPresentationControllerDelegate {
    
    var tableView: UITableView!
    var dataSource: SetTableDataSourceProtocol?
    
    var setManager: SetManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
        
        print("init ChangeSetViewController")
    }
    
    deinit {
        print("DEINIT ChangeSetViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    private func initializeViewController(){
        title = "Change Set"
    }
    
    override func defineControls(){
        tableView = MITableView()
       
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
    }
    
    override func addControls(){
        self.view.addSubview(tableView)
    }
    
    override func applyAutoLayout(){
        var constraintList: [NSLayoutConstraint] = []

        viewDic["tableView"] = tableView
        
        let hTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [], metrics: nil, views: viewDic)
        
        let vTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[tableView]-[bottomLayoutGuide]", options: [], metrics: nil, views: viewDic)
        
        constraintList += hTableViewCnst
        constraintList += vTableViewCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
    private func didSelectSet(_ model: MemorizeItModelProtocol?){
        guard let setManager = setManager else {
            fatalError("setManager is not initialiazed")
        }

        var setId: UUID?
        if let setDic = UserDefaults.standard.object(forKey: Settings.defaultSet.rawValue) as? Dictionary<String, Any>,
            let setModel = SetModel(dictionary: setDic) {
            setId = setModel.setId
        }
        let setModel = model as! SetModel
        if setId != setModel.setId{
           setManager.changeSet(setModel)
        }
    }
    
    private func fetchData(){
        guard let setManager = setManager else {
            fatalError("setManager is not initialiazed")
        }
        guard let dataSource = dataSource else {
            fatalError("dataSource is not initialiazed")
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let sets = setManager.get().flatMap{$0 as MemorizeItModelProtocol}
            dataSource.setModels(sets)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}
