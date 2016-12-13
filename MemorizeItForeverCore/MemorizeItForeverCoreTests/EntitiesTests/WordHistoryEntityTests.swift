//
//  WordHistoryEntityTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/22/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import CoreData
@testable import MemorizeItForeverCore

class WordHistoryEntityTests: XCTestCase {
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
         managedObjectContext = InMemoryManagedObjectContext().setUpInMemoryManagedObjectContext()
    }
    
    override func tearDown() {
       managedObjectContext = nil
        super.tearDown()
    }
    
    func testCreateANewObjectOfWordHistoryEntity() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "WordHistoryEntity", into: managedObjectContext)
        XCTAssertNotNil(entity, "Should be able to define a new WordHistory entity")
    }
    
    func testSaveANewWordHistoryEntity() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordHistoryEntity", into: managedObjectContext) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.failureCount = 4
                entity.id = UUID().uuidString
                entity.word = wordEntity
                do{
                    try managedObjectContext.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        XCTAssertTrue(result, "A new WordHistory entity should be saved")
    }
    
    func testCouldNotSaveANewWordHistoryWithoutIdProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordHistoryEntity", into: managedObjectContext) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.failureCount = 4
                entity.word = wordEntity
                do{
                    try managedObjectContext.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        
        XCTAssertFalse(result, "If id wasn't set, save method should throw an error")
    }
    
    
    func testCouldNotSaveANewWordHistoryWithoutColumnNoProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordHistoryEntity", into: managedObjectContext) as? WordHistoryEntity{
                entity.failureCount = 4
                entity.word = wordEntity
                do{
                    try managedObjectContext.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        
        XCTAssertFalse(result, "If columnNo wasnt set, save method should throw an error")
    }
    
    func testCouldNotSaveANewWordHistoryWithoutFailureCountProperty() {
        var result = false
        if let wordEntity = SaveWordEntity().entity{
            if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordHistoryEntity", into: managedObjectContext) as? WordHistoryEntity{
                entity.columnNo = 1
                entity.word = wordEntity
                do{
                    try managedObjectContext.save()
                    result = true
                }
                catch {
                    result = false
                }
            }
        }
        
        XCTAssertFalse(result, "if failureCount wasn't set, save method should throw an error")
    }
    func testCouldNotSaveANewWordHistoryWithoutWordProperty() {
        var result = false
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "WordHistoryEntity", into: managedObjectContext) as? WordHistoryEntity{
            entity.columnNo = 1
            entity.failureCount = 4
            do{
                try managedObjectContext.save()
                result = true
            }
            catch {
                result = false
            }
        }
        
        XCTAssertFalse(result, "If word field wasnt set, save method should throw an error")
    }
    
    func testCanFetchWordHistoryEntity() {
        var result = false
        
        if SaveWordHistoryEntity().succcessful{
            let fetchRequest = NSFetchRequest<WordHistoryEntity>(entityName: "WordHistoryEntity")
            
            do{
                let wordHistoryEntities = try managedObjectContext.fetch(fetchRequest)
                    if wordHistoryEntities.count > 0{
                        XCTAssertEqual(wordHistoryEntities[0].columnNo, 1, "Should be able to fetch wordHistory entity")
                        result = true
                    }
            }
            catch{
                result = false
            }
        }
        
        XCTAssertTrue(result, "Should be able to fetch wordHistory entity")
    }
    
    func testCanEditWordHistoryEntity() {
        var result = false
        
        if SaveWordHistoryEntity().succcessful{
            let fetchRequest = NSFetchRequest<WordHistoryEntity>(entityName: "WordHistoryEntity")
            
            do{
                let wordHistoryEntities = try managedObjectContext.fetch(fetchRequest)
                    if wordHistoryEntities.count > 0{
                        let wordHistoryEntity = wordHistoryEntities[0]
                        wordHistoryEntity.failureCount = 7
                        do{
                            try managedObjectContext.save()
                            result = true
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
        
        let fetchRequest = NSFetchRequest<WordHistoryEntity>(entityName: "WordHistoryEntity")
        
        do{
            let wordHistoryEntities = try managedObjectContext.fetch(fetchRequest)
                if wordHistoryEntities.count > 0{
                    XCTAssertEqual(wordHistoryEntities[0].failureCount, 7, "Should be able to edit wordHistory entity")
                    result = true
                    
                }
        }
        catch{
            result = false
        }
        
        
        XCTAssertTrue(result, "Should be able to edit wordHistory entity")
    }
    
    func testCanDeleteWordHistoryEntity() {
        var result = false
        
        if SaveWordHistoryEntity().succcessful{
            let fetchRequest = NSFetchRequest<WordHistoryEntity>(entityName: "WordHistoryEntity")
            
            do{
                let wordHistoryEntities = try managedObjectContext.fetch(fetchRequest)
                    if wordHistoryEntities.count > 0{
                        let setEntity = wordHistoryEntities[0]
                        managedObjectContext.delete(setEntity)
                        do{
                            try managedObjectContext.save()
                            let wordHistoryEntities2 = try managedObjectContext.fetch(fetchRequest)
                                XCTAssertEqual(wordHistoryEntities2.count, 0, "Should be able to delete wordHistory entity")
                                result = wordHistoryEntities2.count == 0
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
        
        XCTAssertTrue(result, "Should be able to delete wordHistory entity")
    }
    
    func testToModelWorksFine(){
        let wordHistoryEntity = SaveWordHistoryEntity().entity
        do{
            let wordHistoryModel: WordHistoryModel? = try wordHistoryEntity?.toModel() as? WordHistoryModel
            XCTAssertEqual(wordHistoryEntity?.id, wordHistoryModel?.wordHistoryId?.uuidString, "Id should provide in toModel")
            XCTAssertEqual(wordHistoryEntity?.columnNo, wordHistoryModel?.columnNo, "ColumnNo should provide in toModel")
            XCTAssertEqual(wordHistoryEntity?.failureCount, wordHistoryModel?.failureCount, "FailureCount should provide in toModel")
            XCTAssertEqual(wordHistoryEntity?.word?.id, wordHistoryModel?.word?.wordId?.uuidString, "Word should provide in toModel")
        }
        catch{
            XCTFail("ToModel should work fine")
        }
    }
    
    func testSetEntityReturnCorrectName(){
        XCTAssertEqual(WordHistoryEntity.entityName, "WordHistoryEntity", "WordHistoryEntity should retuen correct entity name")
    }
    
    func testSetEntityReturnCorrectIdField(){
        XCTAssertEqual(WordHistoryEntity.idField, "id", "WordHistoryEntity should retuen correct id field name")
    }
    
    fileprivate func SaveWordEntity() -> (succcessful: Bool, entity: WordEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveWordEntity(managedObjectContext)
    }
    fileprivate func SaveWordHistoryEntity() -> (succcessful: Bool, entity: WordHistoryEntity?){
        let entityCreationHelper = EntityCreationHelper()
        return entityCreationHelper.SaveWordHistoryEntity(managedObjectContext)
    }
    
}
