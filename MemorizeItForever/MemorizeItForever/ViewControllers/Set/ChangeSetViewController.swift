//
//  ChangeSetViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class ChangeSetViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var dataSource: SetTableDataSourceProtocol!
    var setService: SetServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
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
        title = NSLocalizedString("Change Set", comment: "Change Set")
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifierEnum: .changeSetTableCellIdentifier)
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        let weakSelf = self
        dataSource.handleTap = {[weak weakSelf] (memorizeItModel) in
            if let weakSelf = weakSelf{
                weakSelf.didSelectSet(memorizeItModel)
            }
        }
    }
   
    private func didSelectSet(_ model: MemorizeItModelProtocol?){
       
        var setId: UUID?
        if let setDic = UserDefaults.standard.object(forKey: Settings.defaultSet.rawValue) as? Dictionary<String, Any>,
            let setModel = SetModel(dictionary: setDic) {
            setId = setModel.setId
        }
        let setModel = model as! SetModel
        if setId != setModel.setId{
           setService.changeSet(setModel)
        }
    }
    
    private func fetchData(){
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let sets = self.setService.get().flatMap{$0 as MemorizeItModelProtocol}
            self.dataSource.setModels(sets)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    @IBOutlet weak var tableView: UITableView!
}
