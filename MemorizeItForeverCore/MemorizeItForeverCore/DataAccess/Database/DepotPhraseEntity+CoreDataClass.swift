//
//  DepotPhraseEntity+CoreDataClass.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/12/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//
//

import Foundation
import CoreData
import BaseLocalDataAccess

@objc(DepotPhraseEntity)
public class DepotPhraseEntity: NSManagedObject {
    public static var entityName: String{
        return Entities.depotPhraseEntity.rawValue
    }
    
    public static var idField: String{
        return Fields.Id.rawValue
    }
    
    public func toModel() throws -> ModelProtocol {
        guard let id = self.id else{
            throw ModelError.failCreateModel(Models.depotPhraseModel.rawValue)
        }
        var depotPhraseModel = DepotPhraseModel()
        depotPhraseModel.id = UUID(uuidString: id)
        depotPhraseModel.phrase = self.phrase
        return depotPhraseModel
    }
    
    public enum Fields: String {
        case Id = "id"
        case Phrase = "phrase"
    }

}
