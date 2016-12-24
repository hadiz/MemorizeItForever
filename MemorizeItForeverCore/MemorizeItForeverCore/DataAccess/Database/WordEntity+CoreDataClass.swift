//
//  WordEntity+CoreDataClass.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData
import BaseLocalDataAccess

class WordEntity: NSManagedObject, EntityProtocol {
    
    public static var entityName: String{
        return Entities.wordEntity.rawValue
    }
    
    public static var idField: String{
        return Fields.Id.rawValue
    }
    
    public func toModel() throws -> ModelProtocol {
        guard let id = self.id, let setId = self.set?.id , let setName = self.set?.name else{
            throw ModelError.failCreateModel(Models.wordModel.rawValue)
        }
        
        var word = WordModel()
        word.status = self.status
        word.order = self.order
        word.wordId = UUID(uuidString: id)
        word.setId = UUID(uuidString: setId)
        word.meaning = self.meaning
        word.phrase = self.phrase
        word.setName = setName
        return word
    }
    
    public enum Fields: String {
        case Id = "id"
        case Meaning = "meaning"
        case Order = "order"
        case Phrase = "phrase"
        case Status = "status"
        case Set = "set"
    }
}
