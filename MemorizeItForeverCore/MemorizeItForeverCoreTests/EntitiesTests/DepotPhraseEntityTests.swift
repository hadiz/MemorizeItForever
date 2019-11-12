//
//  DepotPhraseEntityTests.swift
//  MemorizeItForeverCoreTests
//
//  Created by Hadi Zamani on 11/10/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import CoreData
@testable import MemorizeItForeverCore

class DepotPhraseEntityTests: XCTestCase {
    
    var managedObjectContext: NSManagedObjectContext!

    fileprivate func saveDepotPhraseEntity() -> (succcessful: Bool, entity: DepotPhraseEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.saveDepotPhraseEntity(managedObjectContext)
    }
    
    override func setUp() {
        managedObjectContext = InMemoryManagedObjectContext().setUpInMemoryManagedObjectContext()
    }

    override func tearDown() {
        managedObjectContext = nil
    }

    func testCreateANewObjectOfDepotPhraseEntity() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "DepotPhraseEntity", into: managedObjectContext)
        XCTAssertNotNil(entity, "should be able to define a new DepotPhrase entity")
    }
    
    func testSaveANewDepotPhraseEntity() {
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.depotPhraseEntity.rawValue, into: managedObjectContext) as? DepotPhraseEntity{
            entity.id = "1"
            entity.phrase = "book"
            do{
                try managedObjectContext.save()
                result = true
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "A new DepotPhrase entity should be saved")
    }
    
    func testCouldNotSaveANewDepotPhraseWithoutIdProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.depotPhraseEntity.rawValue, into: managedObjectContext) as? DepotPhraseEntity{
            entity.phrase = "book"
            do{
                try managedObjectContext.save()
                result = true
            }
            catch{
                result = false
            }
        }
        
        XCTAssertFalse(result, "If id wasn't set, save method should throw an error")
    }
    
    func testCouldNotSaveANewDepotPhraseWithoutPhraseProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.depotPhraseEntity.rawValue, into: managedObjectContext) as? DepotPhraseEntity{
            entity.id = "1"
            do{
                try managedObjectContext.save()
                result = true
            }
            catch{
                result = false
            }
        }
        
        XCTAssertFalse(result, "If phrase wasn't set, save method should throw an error")
    }
    
    func testCanFetchDepotPhraseEntity() {
        var result = false
        
        if saveDepotPhraseEntity().succcessful{
            let fetchRequest = NSFetchRequest<DepotPhraseEntity>(entityName: Entities.depotPhraseEntity.rawValue)
            
            do{
                let depotPhraseEntities = try managedObjectContext.fetch(fetchRequest)
                    if depotPhraseEntities.count > 0{
                        XCTAssertEqual(depotPhraseEntities[0].phrase, "book", "Should be able to fetch depotPhrase entity")
                        result = true
                    }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to fetch depotPhrase entity")
    }

    func testCanEditDepotPhraseEntity() {
        var result = false
        
        if saveDepotPhraseEntity().succcessful{
            let fetchRequest = NSFetchRequest<DepotPhraseEntity>(entityName: Entities.depotPhraseEntity.rawValue)
            
            do{
                 let depotPhraseEntities = try managedObjectContext.fetch(fetchRequest)
                    if depotPhraseEntities.count > 0{
                        let depotPhraseEntity = depotPhraseEntities[0]
                        depotPhraseEntity.phrase = "Edited DepotPhrase Entity"
                        do{
                            try managedObjectContext.save()
                        }
                        catch{
                            result = false
                        }
                    }
            }
            catch{
                result = false
            }
        }
        
        let fetchRequest = NSFetchRequest<DepotPhraseEntity>(entityName: Entities.depotPhraseEntity.rawValue)
        
        do{
            let depotPhraseEntities = try managedObjectContext.fetch(fetchRequest)
                if depotPhraseEntities.count > 0{
                    XCTAssertEqual(depotPhraseEntities[0].phrase, "Edited DepotPhrase Entity", "Should be able to edit depotPhrase entity")
                    result = true
                    
                }
        }
        catch{
            result = false
        }
        
        XCTAssertTrue(result, "Should be able to edit depotPhrase entity")
    }
    
    func testCanDeletedDepotPhraseEntity() {
        var result = false
        
        if saveDepotPhraseEntity().succcessful{
            let fetchRequest = NSFetchRequest<DepotPhraseEntity>(entityName: Entities.depotPhraseEntity.rawValue)
            
            do{
                 let depotPhraseEntities = try managedObjectContext.fetch(fetchRequest)
                    if depotPhraseEntities.count > 0{
                        let depotPhraseEntity = depotPhraseEntities[0]
                        managedObjectContext.delete(depotPhraseEntity)
                        do{
                            try managedObjectContext.save()
                            let depotPhraseEntities2 = try managedObjectContext.fetch(fetchRequest)
                                XCTAssertEqual(depotPhraseEntities2.count, 0, "Should be able to delete depotPhrase entity")
                                result = depotPhraseEntities2.count == 0
                        }
                        catch{
                            result = false
                        }
                    }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to delete depotPhrase entity")
    }
    
    func testDepotPhraseEntityReturnCorrectName(){
           XCTAssertEqual(DepotPhraseEntity.entityName, "DepotPhraseEntity", "SetEntity should retuen correct entity name")
       }
       
       func testDepotPhraseEntityReturnCorrectIdField(){
           XCTAssertEqual(DepotPhraseEntity.idField, "id", "DepotPhraseEntity should retuen correct id field name")
       }
    
    func testToModelWorksFine(){
        let depotPhraseEntity = saveDepotPhraseEntity().entity
        do{
            let depotPhraseModel: DepotPhraseModel? = try depotPhraseEntity?.toModel() as? DepotPhraseModel
            XCTAssertEqual(depotPhraseEntity?.phrase, depotPhraseModel?.phrase, "Phrase should provide in toModel")
            XCTAssertEqual(depotPhraseEntity?.id, depotPhraseModel?.id?.uuidString, "Id should provide in toModel")
        }
        catch{
            XCTFail("ToModel should work fine")
        }
    }
}
