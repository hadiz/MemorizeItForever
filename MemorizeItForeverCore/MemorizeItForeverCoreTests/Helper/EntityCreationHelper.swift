//
//  EntityCreationHelper.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import CoreData
@testable import MemorizeItForeverCore

class EntityCreationHelper{
    func SaveSetEntity(_ managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: SetEntity?){
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.setEntity.rawValue, into: managedObjectContextShared) as? SetEntity{
            entity.id = UUID().uuidString
            entity.name = "set1"
            do{
                try managedObjectContextShared.save()
                result = true
                return (result, entity)
            }
            catch{
                result = false
                return (result, entity)
            }
        }
        return (result, nil)
    }
    
    func saveWordEntity(_ managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: WordEntity?){
        var result = false
        if let setEntity = SaveSetEntity(managedObjectContextShared).entity{
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordEntity", into: managedObjectContextShared) as? WordEntity{
                entity.id = UUID().uuidString
                entity.meaning = "book"
                entity.order = 1
                entity.phrase = "livre"
                entity.set = setEntity
                do{
                    try managedObjectContextShared.save()
                    result = true
                    return (result, entity)
                }
                catch {
                    result = false
                    return (result, nil)
                }
            }
        }
        return (result, nil)
    }
    
    func saveWordInProgressEntity(_ managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: WordInProgressEntity?){
        var result = false
        if let wordEntity = saveWordEntity(managedObjectContextShared).entity{
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordInProgressEntity", into: managedObjectContextShared) as? WordInProgressEntity{
                entity.column = 1
                entity.date = Date()
                entity.id = UUID().uuidString
                entity.word = wordEntity
                do{
                    try managedObjectContextShared.save()
                    result = true
                    return (result, entity)
                }
                catch {
                    result = false
                    return (result, nil)
                }
            }
        }
        return (result, nil)
    }
    
    func saveWordHistoryEntity(_ managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: WordHistoryEntity?){
        var result = false
        if let wordEntity = saveWordEntity(managedObjectContextShared).entity{
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordHistoryEntity", into: managedObjectContextShared) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.failureCount = 4
                entity.id = UUID().uuidString
                entity.word = wordEntity
                do{
                    try managedObjectContextShared.save()
                    result = true
                    return (result, entity)
                }
                catch {
                    result = false
                    return (result, nil)
                }
            }
        }
        return (result, nil)
    }
    
    func saveDepotPhraseEntity(_ managedObjectContextShared: NSManagedObjectContext) -> (succcessful: Bool, entity: DepotPhraseEntity?){
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.depotPhraseEntity.rawValue, into: managedObjectContextShared) as? DepotPhraseEntity{
            entity.id = UUID().uuidString
            entity.phrase = "book"
            do{
                try managedObjectContextShared.save()
                result = true
                return (result, entity)
            }
            catch{
                result = false
                return (result, entity)
            }
        }
        return (result, nil)
    }
}
