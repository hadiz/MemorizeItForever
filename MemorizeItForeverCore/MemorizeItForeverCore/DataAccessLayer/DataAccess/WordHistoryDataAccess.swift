//
//  WordHistoryDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/3/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation
import BaseLocalDataAccess

class WordHistoryDataAccess: BaseDataAccess<WordHistoryEntity>, WordHistoryDataAccessProtocol {
    
    var wordDataAccess: GenericDataAccess<WordEntity>!
    
    init(genericDataAccess: GenericDataAccess<WordHistoryEntity>, wordDataAccess: GenericDataAccess<WordEntity>) {
        super.init(genericDataAccess: genericDataAccess)
        self.wordDataAccess = wordDataAccess
    }
    
    func saveOrUpdate(_ wordHistoryModel: WordHistoryModel) throws{
        guard let wordId = wordHistoryModel.word?.wordId else{
            throw EntityCRUDError.failSaveEntity(genericDataAccess.getEntityName())
        }
        do{
            var wordHistoryEntity = try fetchByWordIdAndColumnNo(wordHistoryModel)
            if wordHistoryEntity == nil{
                wordHistoryEntity = try genericDataAccess.createNewInstance()
                wordHistoryEntity?.id = genericDataAccess.generateId()
                if let columnNo = wordHistoryModel.columnNo{
                    wordHistoryEntity?.columnNo = columnNo
                }
                wordHistoryEntity?.failureCount = 1
                wordHistoryEntity?.word = fetchWordEntity(wordId as UUID)
            }
            else{
                wordHistoryEntity!.failureCount = wordHistoryEntity!.failureCount + 1
            }
            try genericDataAccess.saveEntity(wordHistoryEntity!)
        }
        catch EntityCRUDError.failNewEntity(let entityName){
            throw EntityCRUDError.failNewEntity(entityName)
        }
        catch let error as NSError{
            throw EntityCRUDError.failSaveEntity(error.localizedDescription)
        }
    }
    
    func fetchByWordId(_ wordHistoryModel: WordHistoryModel) throws ->  [WordHistoryModel]{
        guard let wordId = wordHistoryModel.word?.wordId, let word = fetchWordEntity(wordId as UUID) else{
            throw EntityCRUDError.failFetchEntity(genericDataAccess.getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordHistoryEntity.Fields.Word.rawValue, operatorName: .equal, value: word)
        
        let sort = SortObject(fieldName: WordHistoryEntity.Fields.ColumnNo.rawValue, direction: .ascending)
        
        do{
            return try genericDataAccess.fetchModels(predicate: predicateObject, sort: sort)
        }
        catch{
            throw error
        }
    }
    
    func countByWordId(_ wordHistoryModel: WordHistoryModel) throws -> Int{
        guard let wordId = wordHistoryModel.word?.wordId, let word = fetchWordEntity(wordId as UUID) else{
            throw EntityCRUDError.failFetchEntity(genericDataAccess.getEntityName())
        }
        
        let predicateObject = PredicateObject(fieldName: WordHistoryEntity.Fields.Word.rawValue, operatorName: .equal, value: word)
        
        
        do{
            return try genericDataAccess.fetchEntityCount(predicate: predicateObject)
        }
        catch{
            throw error
        }
    }
    
   private func fetchByWordIdAndColumnNo(_ wordHistoryModel: WordHistoryModel) throws ->  WordHistoryEntity?{
        guard let columnNo = wordHistoryModel.columnNo, let wordId = wordHistoryModel.word?.wordId else{
            throw EntityCRUDError.failFetchEntity(genericDataAccess.getEntityName())
        }
        
        guard let word = fetchWordEntity(wordId as UUID) else{
            throw EntityCRUDError.failFetchEntity(genericDataAccess.getEntityName())
        }

        let predicateObject1 = PredicateObject(fieldName: WordHistoryEntity.Fields.ColumnNo.rawValue, operatorName: .equal, value: Int(columnNo))
        let predicateObject2 = PredicateObject(fieldName:  WordHistoryEntity.Fields.Word.rawValue, operatorName: .equal, value: word)
        var predicateCompoundObject = PredicateCompoundObject(compoundOperator: .and)
        predicateCompoundObject.appendPredicate(predicateObject1)
        predicateCompoundObject.appendPredicate(predicateObject2)
    
        do{
            let items = try genericDataAccess.fetchEntities(predicate: predicateCompoundObject, sort: nil)
            let count = items.count
            if count > 1{
                throw EntityCRUDError.failFetchEntity("More than one recoed is retrieved")
            }
            else if count == 1{
                return items[0]
            }
            else{
                return nil
            }
        }
        catch{
            throw error
        }
    }
    
    private func fetchWordEntity(_ wordId: UUID) -> WordEntity?{
        guard let wordDataAccess = wordDataAccess else {
            fatalError("wordDataAccess is not initialized")
        }
        do{
            return try wordDataAccess.fetchEntity(withId: wordId)
        }
        catch{
            return nil
        }
    }
}
