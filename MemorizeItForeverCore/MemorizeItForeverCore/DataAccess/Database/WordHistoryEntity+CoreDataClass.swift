//
//  WordHistoryEntity+CoreDataClass.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData
import BaseLocalDataAccess

class WordHistoryEntity: NSManagedObject, EntityProtocol{
    
    public static var entityName: String{
        return Entities.wordHistoryEntity.rawValue
    }
    public static var idField: String{
        return Fields.Id.rawValue
    }
    
    public func toModel() throws -> ModelProtocol {
        do{
            var wordHistoryModel = WordHistoryModel()
            wordHistoryModel.word = try self.word?.toModel() as? WordModel
            wordHistoryModel.columnNo = self.columnNo
            wordHistoryModel.failureCount = self.failureCount
            if let wordHistoryId = self.id{
                wordHistoryModel.wordHistoryId = UUID( uuidString: wordHistoryId)
            }
            return wordHistoryModel
        }
        catch{
            throw ModelError.failCreateModel(Models.wordHistoryModel.rawValue)
        }
    }
    
    public enum Fields: String {
        case Id = "id"
        case ColumnNo = "columnNo"
        case FailureCount = "failureCount"
        case Word = "word"
    }
    
    
}
