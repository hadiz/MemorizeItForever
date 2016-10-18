//
//  SetEntity+CoreDataClass.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import CoreData
import BaseLocalDataAccess


class SetEntity: NSManagedObject, EntityProtocol {
    
    static var entityName: String{
        return Entities.setEntity.rawValue
    }
    
    static var idField: String{
        return Fields.Id.rawValue
    }
    
    func toModel() throws -> ModelProtocol {
        guard let id = self.id else{
            throw ModelError.failCreateModel(Models.setModel.rawValue)
        }
        var setModel = SetModel()
        setModel.setId = UUID(uuidString: id)
        setModel.name = self.name
        return setModel
    }
    
    enum Fields: String {
        case Id = "id"
        case Name = "name"
    }

}
