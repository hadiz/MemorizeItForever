//
//  ChangeSetTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class ChangeSetTableDataSource: NSObject, SetTableDataSourceProtocol {
    var setModels: [SetModel]?
    var handleTap: TypealiasHelper.handleTapClosure?
    var setId: UUID?
    
    required init(setManager: SetManagerProtocol? = nil) {
        // TODO: Should initilialize every time that view is opened, otherwise set userdefaults in another way
        if let setModel = UserDefaults.standard.getDefaultSetModel() {
            setId = setModel.setId
        }
        
        print("init ChangeSetTableDataSource")
    }
    
    deinit {
        print("DEINIT ChangeSetTableDataSource")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sets = setModels else{
            return 0
        }
        return sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifierEnum: .setTableCellIdentifier)
        
        let set = setModels?[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = set?.name
        cell.selectionStyle = .none
        if setId == set?.setId{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clearCells(tableView: tableView)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if let set = setModels?[(indexPath as NSIndexPath).row]{
            handleTap?(set)
        }
        else{
            // TODO Notify an error
        }
    }
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        setModels = models.flatMap{$0 as? SetModel}
    }
    
    private func clearCells(tableView: UITableView){
        guard let sets = setModels else{
            return
        }
        for i in 0..<sets.count{
            let indexPath = IndexPath(item: i, section: 0)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
        }
    }
}

