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
    
    public init(wordDataAccess: WordDataAccessProtocol){
        self.wordDataAccess = wordDataAccess
    }
    
    public func saveWord(_ phrase: String, meaninig: String, setId: UUID) throws{
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
    public func editWord(_ wordModel: WordModel, phrase: String, meaninig: String){
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
    
    public func deleteWord(_ wordModel: WordModel){
        do{
            try wordDataAccess.delete(wordModel)
        }
        catch{
            
        }
    }
}
