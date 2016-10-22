//
//  WordManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
private func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

private func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class WordManager {
    
    private var _dataAccess: WordDataAccess?
    private var wordDataAccess: WordDataAccess{
        guard let dataAccess = _dataAccess else{
            _dataAccess = WordDataAccess()
            return _dataAccess!
        }
        return dataAccess
    }
    
    private var _wodInProgressDataAccess: WordInProgressDataAccess?
    private var wordInProgressDataAccess: WordInProgressDataAccess{
        guard let inProgressDataAccess = _wodInProgressDataAccess else{
            _wodInProgressDataAccess = WordInProgressDataAccess()
            return _wodInProgressDataAccess!
        }
        return inProgressDataAccess
    }
    
    private var _wodHistoryDataAccess: WordHistoryDataAccess?
    private var wordHistoryDataAccess: WordHistoryDataAccess{
        guard let historyDataAccess = _wodHistoryDataAccess else{
            _wodHistoryDataAccess = WordHistoryDataAccess()
            return _wodHistoryDataAccess!
        }
        return historyDataAccess
    }
    
    init(){
        _dataAccess = nil
        _wodInProgressDataAccess = nil
        _wodHistoryDataAccess = nil
    }
    
    init(dataAccess: WordDataAccess, wordInProgressDataAccess: WordInProgressDataAccess?, wodHistoryDataAccess: WordHistoryDataAccess?){
        _dataAccess = dataAccess
        _wodInProgressDataAccess = wordInProgressDataAccess
        _wodHistoryDataAccess = wodHistoryDataAccess
    }
    
    func saveWord(_ phrase: String, meaninig: String, setId: UUID){
        do{
            var word = WordModel()
            word.phrase = phrase
            word.meaning = meaninig
            word.setId = setId
            try wordDataAccess.save(word)
        }
        catch{
            
        }
    }
    func editWord(_ wordModel: WordModel, phrase: String, meaninig: String){
        do{
            var word = WordModel()
            word.phrase = phrase
            word.meaning = meaninig
            word.status = wordModel.status
            word.order = wordModel.order
            word.setId = wordModel.setId
            word.wordId = wordModel.wordId
            try wordDataAccess.edit(word)
        }
        catch{
            
        }
    }
    
    func deleteWord(_ wordModel: WordModel){
        do{
            try wordDataAccess.delete(wordModel)
        }
        catch{
            
        }
    }
    
    func putWordInPreColumn(_ wordModel: WordModel) throws{
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = MemorizeColumns.pre.rawValue
        inProgressModel.date = Date().addDay(MemorizeColumns.pre.days) 
        inProgressModel.word = wordModel
        do {
            try wordInProgressDataAccess.save(inProgressModel)
        }
        catch{
            throw error
        }
    }
    
    func answerCorrectly(_ wordInProgressModel: WordInProgressModel){
        if wordInProgressModel.column == MemorizeColumns.fifth.rawValue{
            do{
                try endOfProgress(wordInProgressModel)
            }
            catch{
                
            }
        }
        else{
            do{
                try progressWord(wordInProgressModel)
            }
            catch{
                
            }
        }
    }
    
    func answerWrongly(_ wordInProgressModel: WordInProgressModel){
        do{
            try registerInWordHistory(wordInProgressModel)
            try rePutWordInPreColumn(wordInProgressModel)
        }
        catch{
            
        }
    }
    
    func fetchNewWordsToPutInPreColumn() throws{
        guard let count = UserDefaults.standard.object(forKey: Settings.newWordsCount.rawValue) as? Int else{
            throw WordManagementFlowError.newWordsCount("Can not specify new words count")
        }
        do{
            if try allowPutWordsInPreColumn(){
                let words = try wordDataAccess.fetchWithNotStartedStatus(fetchLimit: count)
                for word in words{
                    try putWordInPreColumn(word)
                    try changeWordStatus(word, wordStatus: .inProgress)
                }
            }
        }
        catch{
            throw error
        }
    }
    
    func fetchWordsForReview() throws -> [WordModel]{
        do{
            var wordInProgress = WordInProgressModel()
            wordInProgress.date = Date().addDay(1)
            wordInProgress.column = MemorizeColumns.pre.rawValue
            let wordInProgressList = try wordInProgressDataAccess.fetchByDateAndColumn(wordInProgress)
            var words: [WordModel] = []
            for inProgress in wordInProgressList{
                if let word = inProgress.word{
                    words.append(word)
                }
            }
            return words
        }
        catch{
            throw error
        }
    }
    
    func fetchWordsToExamin() throws -> [WordInProgressModel]{
        // it should fetch words for today and all words that belongs to past
        do{
            var wordInProgress = WordInProgressModel()
            wordInProgress.date = Date()
            var wordInProgressList = try wordInProgressDataAccess.fetchByDateAndOlder(wordInProgress)
            wordInProgressList.sort{$0.column > $1.column}
            return wordInProgressList
        }
        catch{
            throw error
        }
    }
    
    private func allowPutWordsInPreColumn() throws -> Bool{
        do{
            let word = try wordDataAccess.fetchLast(.inProgress)
            if word == nil {
                return true
            }
            else{
                var wordHistoryModel = WordHistoryModel()
                wordHistoryModel.word = word
                
                if try wordHistoryDataAccess.countByWordId(wordHistoryModel) > 0{
                    return true
                }
                var wordInProgressModel = WordInProgressModel()
                wordInProgressModel.word = word
                if let wordInProgress = try wordInProgressDataAccess.fetchByWordId(wordInProgressModel){
                    return wordInProgress.column != MemorizeColumns.pre.rawValue
                }
                else{
                    throw WordManagementFlowError.wordInProgressIsNull("Thwre id no word assigned to WordInProgress")
                }
            }
        }
        catch{
            throw error
        }
    }
    
    private func rePutWordInPreColumn(_ wordInProgressModel: WordInProgressModel) throws{
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = MemorizeColumns.pre.rawValue
        inProgressModel.date = Date().addDay(MemorizeColumns.pre.days)
        inProgressModel.word = wordInProgressModel.word
        inProgressModel.wordInProgressId = wordInProgressModel.wordInProgressId
        do {
            try wordInProgressDataAccess.edit(inProgressModel)
        }
        catch{
            throw error
        }
    }
    
    private func registerInWordHistory(_ wordInProgressModel: WordInProgressModel) throws{
        var wordHistory = WordHistoryModel()
        wordHistory.columnNo = wordInProgressModel.column
        wordHistory.word = wordInProgressModel.word
        do{
            try wordHistoryDataAccess.saveOrUpdate(wordHistory)
        }
        catch{
            throw error
        }
    }
    
    private func endOfProgress(_ wordInProgressModel: WordInProgressModel) throws{
        guard let word = wordInProgressModel.word else{
            throw WordManagementFlowError.wordModelIsNull("in moveFromProgress")
        }
        do{
            try changeWordStatus(word, wordStatus: .done)
            try deleteWordInProgress(wordInProgressModel)
        }
        catch let error as NSError {
            throw error
        }
    }
    
    private func deleteWordInProgress(_ wordInProgressModel: WordInProgressModel) throws{
        do{
            try wordInProgressDataAccess.delete(wordInProgressModel)
        }
        catch let error as NSError{
            throw error
        }
    }
    
    private func changeWordStatus(_ wordModel: WordModel, wordStatus: WordStatus) throws{
        do{
            var word = WordModel()
            word.phrase = wordModel.phrase
            word.meaning = wordModel.meaning
            word.status = wordStatus.rawValue
            word.order = wordModel.order
            word.setId = wordModel.setId
            word.wordId = wordModel.wordId
            try wordDataAccess.edit(word)
        }
        catch let error as NSError{
            throw error
        }
    }
    
    private func progressWord(_ wordInProgressModel: WordInProgressModel) throws{
        if let column = wordInProgressModel.column{
            let nextStep = findNextStep(column)
            var newWordInProgressModel = WordInProgressModel()
            newWordInProgressModel.column = nextStep.rawValue
            newWordInProgressModel.date = Date().addDay(nextStep.days)
            newWordInProgressModel.word = wordInProgressModel.word
            newWordInProgressModel.wordInProgressId = wordInProgressModel.wordInProgressId
            do{
                try wordInProgressDataAccess.edit(newWordInProgressModel)
            }
            catch let error as NSError{
                throw WordManagementFlowError.progressWord(error.localizedDescription)
            }
        }
        else{
            throw WordManagementFlowError.progressWord("column property is null")
        }
    }
    
    private func findNextStep(_ memorizeColumns: Int16) -> MemorizeColumns{
        switch memorizeColumns {
        case MemorizeColumns.pre.rawValue:
            return MemorizeColumns.first
        case MemorizeColumns.first.rawValue:
            return MemorizeColumns.second
        case MemorizeColumns.second.rawValue:
            return MemorizeColumns.third
        case MemorizeColumns.third.rawValue:
            return MemorizeColumns.fourth
        case MemorizeColumns.fourth.rawValue:
            return MemorizeColumns.fifth
        default:
            return MemorizeColumns.pre
        }
    }
    
}
