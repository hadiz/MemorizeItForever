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
    var setModels: [SetModel] = []
    var handleTap: TypealiasHelper.handleTapClosure?
    var setId: UUID?
    
    required init(setService: SetServiceProtocol? = nil) {
        if let setModel = UserDefaults.standard.getDefaultSetModel() {
            setId = setModel.setId
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(.changeSetTableCellIdentifier, forIndexPath: indexPath)
        
        let set = setModels[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = set.name
        cell.selectionStyle = .none
        if setId == set.setId{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clearCells(tableView: tableView)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
         let set = setModels[(indexPath as NSIndexPath).row]
            handleTap?(set)
    }
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        setModels = models.flatMap{$0 as? SetModel}
    }
    
    private func clearCells(tableView: UITableView){
        for i in 0..<setModels.count{
            let indexPath = IndexPath(item: i, section: 0)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
        }
    }
}

