//
//  WordInProgressDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//
import Foundation
import BaseLocalDataAccess

class WordInProgressDataAccess: BaseDataAccess<WordInProgressEntity> {
    func fetchAll() throws -> [WordInProgressModel]{
        do{
            return try fetchModels(predicate: nil, sort: nil)
        }
        catch let error as NSError{
            throw DataAccessError.failFetchData(error.localizedDescription)
        }
    }
    
    func save(_ wordInProgressModel: WordInProgressModel) throws{
        guard let wordId = wordInProgressModel.word?.wordId else{
            throw EntityCRUDError.failSaveEntity(getEntityName())
        }
        do{
            let wordInProgressEntity = try dataAccess.createNewInstance()
            wordInProgressEntity.id = generateId()
            if let column = wordInProgressModel.column{
                wordInProgressEntity.column = column
            }
            wordInProgressEntity.date = wordInProgressModel.date?.getDate()
            wordInProgressEntity.word = fetchWordEntity(wordId)
            try dataAccess.saveEntity(wordInProgressEntity)
        }
        catch EntityCRUDError.failNewEntity(let entityName){
            throw EntityCRUDError.failNewEntity(entityName)
        }
        catch let error as NSError{
            throw EntityCRUDError.failSaveEntity(error.localizedDescription)
        }
    }
    
    func edit(_ wordInProgressModel: WordInProgressModel) throws{
        do{
            guard let id = wordInProgressModel.wordInProgressId else{
                throw EntityCRUDError.failSaveEntity(getEntityName())
            }
            
            if let wordInProgressEntity = try fetchEntity(withId: id){
                if let column = wordInProgressModel.column{
                    wordInProgressEntity.column = column
                }
                wordInProgressEntity.date = wordInProgressModel.date?.getDate()
                try dataAccess.saveEntity(wordInProgressEntity)
            }
            else{
                throw DataAccessError.failFetchData("There is no WordInProgressEntity entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.failEditData(error.localizedDescription)
        }
    }
    
    func delete(_ wordInProgressModel: WordInProgressModel) throws{
        do{
            guard let id = wordInProgressModel.wordInProgressId else{
                throw EntityCRUDError.failDeleteEntity(getEntityName())
            }
            
            if let wordInProgressEntity = try fetchEntity(withId: id){
                try dataAccess.deleteEntity(wordInProgressEntity)
            }
            else{
                throw DataAccessError.failFetchData("There is no WordInProgressEntity entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.failDeleteData(error.localizedDescription)
        }
    }

    func fetchByWordId(_ wordInProgressModel: WordInProgressModel) throws -> WordInProgressModel?{
        guard let wordId = wordInProgressModel.word?.wordId, let word = fetchWordEntity(wordId as UUID) else{
            throw EntityCRUDError.failFetchEntity(getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordInProgressEntity.Fields.Word.rawValue, operatorName: .equal, value: word)
        
        do{
            let words: [WordInProgressModel] = try fetchModels(predicate: predicateObject, sort: nil)
            if words.count == 1{
               return words[0]
            }
            else{
                return nil
            }
        }
        catch{
            throw error
        }
    }
    
    func fetchByDateAndColumn(_ wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel]{
        guard let date = wordInProgressModel.date?.getDate(), let column = wordInProgressModel.column else{
            throw EntityCRUDError.failFetchEntity(getEntityName())
        }
        
        let predicateObject1 = PredicateObject(fieldName: WordInProgressEntity.Fields.Column.rawValue, operatorName: .equal, value: Int(column))
        let predicateObject2 = PredicateObject(fieldName: WordInProgressEntity.Fields.Date.rawValue, operatorName: .equal, value: date)
        
        var predicateCompound = PredicateCompoundObject(compoundOperator: CompoundOperatorEnum.and)
        predicateCompound.appendPredicate(predicateObject1)
        predicateCompound.appendPredicate(predicateObject2)
        
        do{
            let wordInProgress: [WordInProgressModel] = try fetchModels(predicate: predicateCompound, sort: nil)
            return wordInProgress
        }
        catch{
            throw error
        }
    }
    
    func fetchByDateAndOlder(_ wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel]{
        guard let date = wordInProgressModel.date?.getDate() else{
            throw EntityCRUDError.failFetchEntity(getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordInProgressEntity.Fields.Date.rawValue, operatorName: .lessEqualThan, value: date as NSObject)
        
        do{
            let wordInProgress: [WordInProgressModel] = try fetchModels(predicate: predicateObject, sort: nil)
            return wordInProgress
        }
        catch{
            throw error
        }
    }
    
    private func fetchWordEntity(_ wordId: UUID) -> WordEntity?{
        do{
            return try WordDataAccess(context: context).fetchEntity(withId: wordId)
        }
        catch{
            return nil
        }
    }
}
