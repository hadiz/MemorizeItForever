//
//  SetTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/25/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import MemorizeItForeverCore


final class SetTableDataSource: NSObject, SetTableDataSourceProtocol {
    var setModels: [SetModel]?
    var handleTap: TypealiasHelper.handleTapClosure?
    var setService: SetServiceProtocol?
    
    required init(setService: SetServiceProtocol?) {
        self.setService = setService
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sets = setModels else{
            return 0
        }
        return sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(.setTableCellIdentifier, forIndexPath: indexPath)
        
        let set = setModels?[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = set?.name
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let weakSelf = self
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") {[weak weakSelf] (action, index) in
            if let weakSelf = weakSelf{
                weakSelf.editSet(indexPath: index)
            }
        }
        edit.backgroundColor = #colorLiteral(red: 1, green: 0.5774730687, blue: 0.1422811775, alpha: 1)
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") {[weak weakSelf] (action, index) in
            if let weakSelf = weakSelf{
                weakSelf.deleteSet(indexPath: index, tableView: tableView)
            }
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [delete, edit]
    }
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        setModels = models.flatMap{$0 as? SetModel}
    }
    
    private func deleteSet(indexPath: IndexPath, tableView: UITableView){
        guard let setService = setService else {
            fatalError("setService is not initialiazed")
        }
        let set = setModels![(indexPath as NSIndexPath).row]
        if setService.delete(set){
            setModels?.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        else{
            tableView.setEditing(false, animated: true)
        }
    }
    
    private func editSet(indexPath: IndexPath){
        if let set = setModels?[(indexPath as NSIndexPath).row]{
            handleTap?(set)
        }
        else{
            // TODO Notify an error
        }
    }
}
