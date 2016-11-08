//
//  SetManagerTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/23/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class SetManagerTests: XCTestCase {
    
    var setManager: SetManager!
    var setDataAccess: SetDataAccess!
    
    override func setUp() {
        super.setUp()
        setDataAccess = FakeSetDataAccess()
        setManager = SetManager(dataAccess: setDataAccess)
    }
    
    override func tearDown() {
        setManager = nil
        setDataAccess = nil
        super.tearDown()
    }
    
    func testCreateDefaultSetIfDoesNotExists() {
        do{
            setManager.createDefaultSet()
            let number = try setDataAccess.fetchSetNumber()
            XCTAssertEqual(number, 1, "Should create a default set if does not exist")
        }
        catch{
            XCTFail("Should create a default set if does not exist")
        }
    }
    
    func testDoNotCreateDefaultSetIfSetExists() {
        do{
            var model = SetModel()
            model.name = "EnglishToFrench"
            try setDataAccess.save(model)
            setManager.createDefaultSet()
            let number = try setDataAccess.fetchSetNumber()
            XCTAssertEqual(number, 1, "Should create a default set if does not exist")
        }
        catch{
            XCTFail("Should create a default set if does not exist")
        }
    }
    
    func testSaveNewSet() {
        do{
            setManager.save("EnglishToFrench")
            let number = try setDataAccess.fetchSetNumber()
            XCTAssertEqual(number, 1, "Should save a new set")
        }
        catch{
            XCTFail("Should save a new set")
        }
    }
    
    func testEditSet() {
        do{
            var model = SetModel()
            model.name = "EnglishToFrench"
            try setDataAccess.save(model)
            let fetchedSet = try setDataAccess.fetchAll()[0]
            setManager.edit(fetchedSet, setName: "EnglishToFrenchEdited")
            let sets = try setDataAccess.fetchAll()
            XCTAssertEqual(sets[0].name, "EnglishToFrenchEdited", "Should be able to edit name field of a set")
        }
        catch{
            XCTFail("Should be able to edit a set")
        }
    }
    
    func testDeleteSet() {
        do{
            var model = SetModel()
            model.name = "Default"
            try setDataAccess.save(model)
            
            var model1 = SetModel()
            model1.name = "EnglishToFrench"
            try setDataAccess.save(model1)
            
            let fetchedSet = try setDataAccess.fetchAll()[0]
            _ = setManager.delete(fetchedSet)
            let sets = try setDataAccess.fetchAll()
            XCTAssertEqual(sets.count, 1, "Should be able to delete a set")
        }
        catch{
            XCTFail("Should be able to delete a set")
        }
    }
    
    func testFetchSets(){
        
    }    
}
