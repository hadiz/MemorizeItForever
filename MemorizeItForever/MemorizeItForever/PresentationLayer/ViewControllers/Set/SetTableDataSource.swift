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
    var setManager: SetManagerProtocol?
    
    required init(setManager: SetManagerProtocol?) {
        self.setManager = setManager
         print("init SetTableDataSource")
    }
  
    deinit {
        print("DEINIT SetTableDataSource")
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let set = setModels?[(indexPath as NSIndexPath).row]{
            handleTap?(set)
        }
        else{
            // TODO Notify an error
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let setManager = setManager else {
            fatalError("setManager is not initialiazed")
        }
        if editingStyle == UITableViewCellEditingStyle.delete {
            let set = setModels![(indexPath as NSIndexPath).row]
            if setManager.delete(set){
                setModels?.remove(at: (indexPath as NSIndexPath).row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
            else{
                tableView.setEditing(false, animated: true)
            }
        }
    }
  
    func setModels(_ models: [MemorizeItModelProtocol]) {
        setModels = models.flatMap{$0 as? SetModel}
    }
    
}
