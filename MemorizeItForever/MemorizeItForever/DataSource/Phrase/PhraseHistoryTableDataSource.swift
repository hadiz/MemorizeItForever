//
//  PhraseHistoryTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class PhraseHistoryTableDataSource: NSObject, PhraseTableDataSourceProtocol {
    private var modelList: [WordHistoryModel] = []
    
    var handleTap: TypealiasHelper.handleTapClosure?
    
    required init(wordService: WordServiceProtocol?) {
    }
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        guard models.count > 0 else {
            return
        }
        self.modelList = models as! [WordHistoryModel]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return NSLocalizedString("Phrase Specifications", comment: "Phrase Specifications")
        }
        else if section == 1{
            return NSLocalizedString("Phrase Failure History", comment: "Phrase Failure History")
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if modelList.count == 0{
            return 0
        }
        if section == 0{
            return 3
        }
        else if section == 1{
            return 6
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(.phraseHistoryTableCellIdentifier, forIndexPath: indexPath)
        if indexPath.section == 0{
            if let word = modelList[0].word{
                if indexPath.row == 0{
                    cell.textLabel?.text = NSLocalizedString("Set:", comment: "Set:")
                    cell.detailTextLabel?.text = word.setName
                }
                    
                else if indexPath.row == 1{
                    cell.textLabel?.text = NSLocalizedString("Phrase:", comment: "Phrase:")
                    cell.detailTextLabel?.text = word.phrase
                }
                else if indexPath.row == 2{
                    cell.textLabel?.text = NSLocalizedString("Status:", comment: "Status:")
                    cell.detailTextLabel?.text = WordStatus(rawValue: word.status!)?.getString()
                }
            }
        }
        else if indexPath.section == 1{
            let columnLocalized = NSLocalizedString("Column", comment: "Column")
            cell.textLabel?.text = "\(columnLocalized) \(indexPath.row):"
            let historyList = modelList.filter {$0.columnNo == Int16(indexPath.row)}
            var count: Int32 = 0
            if historyList.count > 0{
                count = historyList[0].failureCount!
            }
            cell.detailTextLabel?.text = "\(count)"
        }
        setColor(cell: cell, index: indexPath)
        
        return cell
    }
    
    private func setColor(cell: UITableViewCell, index: IndexPath){
        if index.row % 2 != 0 {
            cell.backgroundColor = UIColor.lightGray
        }
    }
}
