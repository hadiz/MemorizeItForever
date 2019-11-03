//
//  PhraseTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/3/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class PhraseTableDataSource: NSObject, PhraseTableDataSourceProtocol {
    
    private var models: [WordModel] = []
    private var wordService: WordServiceProtocol?
    
    var handleTap: TypealiasHelper.handleTapClosure?
    
    required init(wordService: WordServiceProtocol?) {
        self.wordService = wordService
    }
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        guard let models = models as? [WordModel] else {
            return
        }
        self.models = models
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(.phraseTableCellIdentifier, forIndexPath: indexPath)
        let word = models[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = word.phrase
        cell.textLabel?.backgroundColor = UIColor.clear
        
        cell.detailTextLabel?.text = word.setName
        cell.detailTextLabel?.backgroundColor = UIColor.clear
        
        setColor(cell: cell, word: word)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let handleTap = handleTap else {
            return
        }
        
        let word = models[(indexPath as NSIndexPath).row]
        handleTap(word)
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
                weakSelf.editPhrase(indexPath: index)
            }
        }
        if #available(iOS 11.0, *) {
            edit.backgroundColor = UIColor(named: "editTableRow")
        } else {
            edit.backgroundColor = #colorLiteral(red: 1, green: 0.5774730687, blue: 0.1422811775, alpha: 1)
        }
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") {[weak weakSelf] (action, index) in
            if let weakSelf = weakSelf{
                weakSelf.deletePhrase(indexPath: index, tableView: tableView)
            }
        }
        if #available(iOS 11.0, *) {
            delete.backgroundColor = UIColor(named: "deleteTableRow")
        } else {
            delete.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        
        return [delete, edit]
        
    }
    
    private func deletePhrase(indexPath: IndexPath, tableView: UITableView){
        guard let wordService = wordService else {
            fatalError("wordService is not initialiazed")
        }
        
        let word = models[(indexPath as NSIndexPath).row]
        if wordService.delete(word){
            models.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    private func editPhrase(indexPath: IndexPath){
        let phrase = models[(indexPath as NSIndexPath).row]
        handleTap?(phrase)
    }
    
    private func setColor(cell: UITableViewCell, word: WordModel){
        guard let status = word.status else {
            return
        }
        if #available(iOS 11.0, *) {
            switch status {
            case WordStatus.notStarted.rawValue:
                cell.backgroundColor = UIColor(named: "wordStatusNotStarted")
            case WordStatus.inProgress.rawValue:
                    cell.backgroundColor = UIColor(named: "wordStatusInProgress")
            case WordStatus.done.rawValue:
                cell.backgroundColor = UIColor(named: "wordStatusDone")
            default:
                cell.backgroundColor = UIColor(named: "wordStatusNotStarted")
            }
        }
        else
        {
            switch status {
            case WordStatus.notStarted.rawValue:
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case WordStatus.inProgress.rawValue:
                cell.backgroundColor = #colorLiteral(red: 0.9993608594, green: 0.1497559547, blue: 0, alpha: 1).withAlphaComponent(0.5)
            case WordStatus.done.rawValue:
                cell.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1).withAlphaComponent(0.5)
            default:
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
}
