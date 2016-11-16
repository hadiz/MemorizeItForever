//
//  WordManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

final class WordManager: WordManagerProtocol {
    
    private var wordDataAccess: WordDataAccessProtocol
    
    init(wordDataAccess: WordDataAccessProtocol){
        self.wordDataAccess = wordDataAccess
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
}
