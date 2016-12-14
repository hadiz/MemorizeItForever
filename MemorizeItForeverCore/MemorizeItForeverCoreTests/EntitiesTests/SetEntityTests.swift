//
//  SetEntityTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import CoreData
@testable import MemorizeItForeverCore

class SetEntityTests: XCTestCase {
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        managedObjectContext = InMemoryManagedObjectContext().setUpInMemoryManagedObjectContext()
    }
    
    override func tearDown() {
        managedObjectContext = nil
        
        super.tearDown()
    }
    
    func testCreateANewObjectOfSetEntity() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.setEntity.rawValue, into: managedObjectContext)
        XCTAssertNotNil(entity, "Should be able to define a new set entity")
    }
    
    func testSaveANewSetEntity() {
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.setEntity.rawValue, into: managedObjectContext) as? SetEntity{
            entity.id = "1"
            entity.name = "set1"
            do{
                try managedObjectContext.save()
                result = true
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "A new Set entity should be saved")
    }
    
    func testCouldNotSaveANewSetWithoutIdProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.setEntity.rawValue, into: managedObjectContext) as? SetEntity{
            entity.name = "set1"
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
    func testCouldNotSaveANewSetWithoutNameProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: Entities.setEntity.rawValue, into: managedObjectContext) as? SetEntity{
            entity.id = "1"
            do{
                try managedObjectContext.save()
                result = true
            }
            catch{
                result = false
            }
        }
        XCTAssertFalse(result, "If name wasn't set, save method should throw an error")
    }
    
    func testCanFetchSetEntity() {
        var result = false
        
        if SaveSetEntity().succcessful{
            let fetchRequest = NSFetchRequest<SetEntity>(entityName: Entities.setEntity.rawValue)
            
            do{
                let setEntities = try managedObjectContext.fetch(fetchRequest)
                    if setEntities.count > 0{
                        XCTAssertEqual(setEntities[0].name, "set1", "Should be able to fetch set entity")
                        result = true
                    }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to fetch set entity")
    }
    
    func testCanEditSetEntity() {
        var result = false
        
        if SaveSetEntity().succcessful{
            let fetchRequest = NSFetchRequest<SetEntity>(entityName: Entities.setEntity.rawValue)
            
            do{
                 let setEntities = try managedObjectContext.fetch(fetchRequest)
                    if setEntities.count > 0{
                        let setEntity = setEntities[0]
                        setEntity.name = "Edited Set Entity"
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
        
        let fetchRequest = NSFetchRequest<SetEntity>(entityName: Entities.setEntity.rawValue)
        
        do{
            let setEntities = try managedObjectContext.fetch(fetchRequest)
                if setEntities.count > 0{
                    XCTAssertEqual(setEntities[0].name, "Edited Set Entity", "Should be able to edit set entity")
                    result = true
                    
                }
        }
        catch{
            result = false
        }
        
        XCTAssertTrue(result, "Should be able to edit set entity")
    }
    
    func testCanDeleteSetEntity() {
        var result = false
        
        if SaveSetEntity().succcessful{
            let fetchRequest = NSFetchRequest<SetEntity>(entityName: Entities.setEntity.rawValue)
            
            do{
                 let setEntities = try managedObjectContext.fetch(fetchRequest)
                    if setEntities.count > 0{
                        let setEntity = setEntities[0]
                        managedObjectContext.delete(setEntity)
                        do{
                            try managedObjectContext.save()
                            let setEntities2 = try managedObjectContext.fetch(fetchRequest)
                                XCTAssertEqual(setEntities2.count, 0, "Should be able to delete set entity")
                                result = setEntities2.count == 0
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
        
        XCTAssertTrue(result, "Should be able to delete set entity")
    }
    
    func testSetEntityReturnCorrectName(){
        XCTAssertEqual(SetEntity.entityName, "SetEntity", "SetEntity should retuen correct entity name")
    }
    
    func testSetEntityReturnCorrectIdField(){
        XCTAssertEqual(SetEntity.idField, "id", "SetEntity should retuen correct id field name")
    }
    
    func testToModelWorksFine(){
        let setEntity = SaveSetEntity().entity
        do{
            let setModel: SetModel? = try setEntity?.toModel() as? SetModel
            XCTAssertEqual(setEntity?.name, setModel?.name, "Name should provide in toModel")
            XCTAssertEqual(setEntity?.id, setModel?.setId?.uuidString, "Id should provide in toModel")
        }
        catch{
            XCTFail("ToModel should work fine")
        }
    }
    
    fileprivate func SaveSetEntity() -> (succcessful: Bool, entity: SetEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveSetEntity(managedObjectContext)
    }
    
}
