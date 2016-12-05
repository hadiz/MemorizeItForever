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
    private var wordManager: WordManagerProtocol?
    
    var handleTap: TypealiasHelper.handleTapClosure?
    
    required init(wordManager: WordManagerProtocol?) {
        self.wordManager = wordManager
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
        cell.detailTextLabel?.text = word.meaning
        
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
        guard let wordManager = wordManager else {
            fatalError("wordManager is not initialiazed")
        }
        if editingStyle == UITableViewCellEditingStyle.delete {
            let word = models[(indexPath as NSIndexPath).row]
            if wordManager.delete(word){
                models.remove(at: (indexPath as NSIndexPath).row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
    private func setColor(cell: UITableViewCell, word: WordModel){
        guard let status = word.status else {
            return
        }
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
