//
//  WordManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

final public class WordManager: WordManagerProtocol {
    private var wordDataAccess: WordDataAccessProtocol
    private var wordHistoryDataAccess: WordHistoryDataAccessProtocol?
    
    public init(wordDataAccess: WordDataAccessProtocol, wordHistoryDataAccess: WordHistoryDataAccessProtocol? = nil){
        self.wordDataAccess = wordDataAccess
        self.wordHistoryDataAccess = wordHistoryDataAccess
    }
    
    public func save(_ phrase: String, meaninig: String, setId: UUID) throws{
        do{
            var word = WordModel()
            word.phrase = phrase
            word.meaning = meaninig
            word.setId = setId
            try wordDataAccess.save(word)
        }
        catch{
            throw error
        }
    }
    public func edit(_ wordModel: WordModel, phrase: String, meaninig: String){
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
    
    public func delete(_ wordModel: WordModel) -> Bool{
        do{
            try wordDataAccess.delete(wordModel)
        }
        catch{
            return false
        }
        return true
    }
    
    public func fetchWords(phrase: String, status: WordStatus, fetchLimit: Int, fetchOffset: Int) -> [WordModel] {
        do{
            if phrase.trim().isEmpty{
                return try wordDataAccess.fetchWords(status: status, fetchLimit: fetchLimit, fetchOffset: fetchOffset)
            }
            else{
                return try wordDataAccess.fetchWords(phrase: phrase, status: status, fetchLimit: fetchLimit, fetchOffset: fetchOffset)
            }
        }
        catch{
            return []
        }
    }
    
    public func fetchWordHistoryByWord(wordModel: WordModel) -> [WordHistoryModel] {
        guard let wordHistoryDataAccess = wordHistoryDataAccess else {
            fatalError("wordHistoryDataAccess is not initialized")
        }
        var wordHistoryModel = WordHistoryModel()
        wordHistoryModel.word = wordModel
        do{
            return try wordHistoryDataAccess.fetchByWordId(wordHistoryModel)
        }
        catch{
            
        }
        return []
    }
}
