//
//  DepotDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/17/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import  MemorizeItForeverCore

final class DepotDataSource: NSObject, DepotTableDataSourceProtocol {
 
    // MARK: Private variables
    private var depotPhraseModelList = [DepotPhraseModel]()
    private var service: DepotPhraseServiceProtocol!
    
    public init(service: DepotPhraseServiceProtocol) {
        self.service = service
    }
    // MARK: MemorizeItTableDataSourceProtocol
    var rowActionHandler: MITypealiasHelper.RowActionClosure?
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        guard let models = models as? [DepotPhraseModel] else {
            return
        }
        depotPhraseModelList = models
    }
    
    // MARK: UITableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depotPhraseModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(.depotTableCellIdentifier, forIndexPath: indexPath) as! DepotTableViewCell
        
        let model = depotPhraseModelList[(indexPath as NSIndexPath).row]
        
        cell.phrase.text = model.phrase
        cell.add.uuidTag =  model.id
        cell.add.addTarget(self, action: #selector(Self.add), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        return [deleteAction(tableView), addAction(tableView)]
    }
    
    private func deleteAction(_ tableView: UITableView) -> UITableViewRowAction {
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete")
        let delete = UITableViewRowAction(style: .default, title: deleteTitle) {[weak self] (action, index) in
            if let strongSelf = self{
                strongSelf.deleteDepotPhrase(indexPath: index, tableView: tableView)
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
                strongSelf.addDepotPhrase(indexPath: index, tableView: tableView)
            }
        }
        if #available(iOS 11.0, *) {
            add.backgroundColor = UIColor(named: "addTableRow")
        } else {
            add.backgroundColor = UIColor.green
        }
        return add
    }
    
    private func deleteDepotPhrase(indexPath: IndexPath, tableView: UITableView){
        let model = depotPhraseModelList.remove(at: (indexPath as NSIndexPath).row)
        if service.delete(model) {
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            rowActionHandler?(model, .delete)
        }
    }
    
    private func addDepotPhrase(indexPath: IndexPath, tableView: UITableView){
        let model = depotPhraseModelList[indexPath.row]
        rowActionHandler?(model, .add)
    }
    
    @objc
    private func add(sender: CustomButton){
        if let model = depotPhraseModelList.first(where: { $0.id == sender.uuidTag }) {
            rowActionHandler?(model, .add)
        }
    }
}
