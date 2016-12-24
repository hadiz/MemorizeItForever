//
//  WordInProgressEntity+CoreDataClass.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData
import BaseLocalDataAccess

class WordInProgressEntity: NSManagedObject, EntityProtocol {

    public static var entityName: String{
        return Entities.wordInProgressEntity.rawValue
    }
    public static var idField: String{
        return Fields.Id.rawValue
    }
    
    public func toModel() throws -> ModelProtocol {
        do{
            var wordInProgressModel = WordInProgressModel()
            wordInProgressModel.word = try self.word?.toModel() as? WordModel
            wordInProgressModel.column = self.column
            wordInProgressModel.date = self.date as Date?
            if let wordInProgressId = self.id{
                wordInProgressModel.wordInProgressId = UUID(uuidString: wordInProgressId)
            }
            return wordInProgressModel
        }
        catch{
            throw ModelError.failCreateModel(Models.wordInProgressModel.rawValue)
        }
    }
    
    public enum Fields: String {
        case Id = "id"
        case Column = "column"
        case Date = "date"
        case Word = "word"
    }

    
}
