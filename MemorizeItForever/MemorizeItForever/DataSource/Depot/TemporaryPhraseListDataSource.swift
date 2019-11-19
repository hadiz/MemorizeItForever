//
//  TemporaryPhraseListDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/2/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import  MemorizeItForeverCore

final class TemporaryPhraseListDataSource: NSObject, DepotTableDataSourceProtocol{
    
    // MARK: Private variables
    private var temporaryPhraseModelList = [TemporaryPhraseModel]()
    
    // MARK: MemorizeItTableDataSourceProtocol
    var rowActionHandler: MITypealiasHelper.RowActionClosure?
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        guard let models = models as? [TemporaryPhraseModel] else {
            return
        }
        temporaryPhraseModelList = models
    }
    
    // MARK: UITableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temporaryPhraseModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(.temporaryListTableIdentifier, forIndexPath: indexPath)
        
        let tmp = temporaryPhraseModelList[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = tmp.phrase
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        return [deleteAction(tableView), editAction(), addAction(tableView)] 
    }
    
    // MARK: Private Methods
    private func editAction() -> UITableViewRowAction {
        let editTitle = NSLocalizedString("Edit", comment: "Edit")
        let edit = UITableViewRowAction(style: .default, title: editTitle) {[weak self] (action, index) in
            if let strongSelf = self{
                strongSelf.editTempPhrase(indexPath: index)
            }
        }
        if #available(iOS 11.0, *) {
            edit.backgroundColor = UIColor(named: "editTableRow")
        } else {
            edit.backgroundColor = UIColor.yellow
        }
        return edit
    }
    
    private func deleteAction(_ tableView: UITableView) -> UITableViewRowAction {
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete")
        let delete = UITableViewRowAction(style: .default, title: deleteTitle) {[weak self] (action, index) in
            if let strongSelf = self{
                strongSelf.deleteTempPhrase(indexPath: index, tableView: tableView)
            }
        }
        if #available(iOS 11.0, *) {
            delete.backgroundColor = UIColor(named: "deleteTableRow")
        } else {
            delete.backgroundColor = UIColor.red
        }
        return delete
    }
    
    private func addAction(_ tableView: UITableView) -> UITableViewRowAction {
        let addTitle = NSLocalizedString("Add", comment: "Add")
        let add = UITableViewRowAction(style: .default, title: addTitle) {[weak self] (action, index) in
            if let strongSelf = self{
                strongSelf.addTempPhrase(indexPath: index, tableView: tableView)
            }
        }
        if #available(iOS 11.0, *) {
            add.backgroundColor = UIColor(named: "addTableRow")
        } else {
            add.backgroundColor = UIColor.green
        }
        return add
    }
    
    private func deleteTempPhrase(indexPath: IndexPath, tableView: UITableView){
        let model = temporaryPhraseModelList.remove(at: (indexPath as NSIndexPath).row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        rowActionHandler?(model, .delete)
    }
    
    private func editTempPhrase(indexPath: IndexPath){
        let model = temporaryPhraseModelList.remove(at: (indexPath as NSIndexPath).row)
        rowActionHandler?(model, .edit)
    }
    
    private func addTempPhrase(indexPath: IndexPath, tableView: UITableView){
        let model = temporaryPhraseModelList.remove(at: (indexPath as NSIndexPath).row)
        rowActionHandler?(model, .add)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
}
