//
//  SetDataAccessTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/22/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForeverCore

class SetDataAccessTests: XCTestCase {
    
    var setDataAccess: SetDataAccessProtocol!
    
    override func setUp() {
        super.setUp()
        let managedObjectContext = InMemoryManagedObjectContext()
        let dataAccess = MockGenericDataAccess<SetEntity>(context: managedObjectContext)
        setDataAccess = FakeSetDataAccess(genericDataAccess: dataAccess)
    }
    
    override func tearDown() {
        setDataAccess = nil
        super.tearDown()
    }
    
    func testFetchSetNumberReturnAnInteger() {
        do{
            let numberOfSets = try setDataAccess.fetchSetNumber()
            XCTAssertNotNil(Int(numberOfSets), "fetchSetNumber should retuen an integer")
        }
        catch{
            XCTFail("fetchSetNumber should retuen an integer")
        }
    }
    
    func testSaveSetEntity(){
        var setModel = SetModel()
        setModel.name = "Default"
        do{
            try setDataAccess.save(setModel)
        }
        catch{
            XCTFail("should be able to save an set")
        }
    }
    
    func testFetchSetNumberReturnCorrectNumber(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess.save(setModel)
            let numberOfSets = try setDataAccess.fetchSetNumber()
            XCTAssertEqual(numberOfSets, 1, "fetchSetNumber should retuen correct number of set stored")
        }
        catch{
            XCTFail("fetchSetNumber should retuen correct number of set stored")
        }
    }
    
    func testFetchSet(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess.save(setModel)
            let sets = try setDataAccess.fetchAll()
            XCTAssertEqual(sets.count, 1, "should be able to fetch sets")
        }
        catch{
            XCTFail("should be able to fetch sets")
        }
    }
    
    func testEditSet(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess.save(setModel)
            var sets = try setDataAccess.fetchAll()
            sets[0].name = "Edited"
            try setDataAccess.edit(sets[0])
            let newSets = try setDataAccess.fetchAll()
            
            XCTAssertEqual(newSets[0].name, "Edited", "Should be able to edit a set")
        }
        catch{
            XCTFail("Should be able to edit a set")
        }
    }
    
    func testDeleteSet(){
        do{
            var setModel = SetModel()
            setModel.name = "Default"
            try setDataAccess.save(setModel)
            var sets = try setDataAccess.fetchAll()
            try setDataAccess.delete(sets[0])
            let newSets = try setDataAccess.fetchAll()
            
            XCTAssertEqual(newSets.count, 0, "Should be able to delete a set")
        }
        catch{
            XCTFail("Should be able to delete a set")
        }
    }

}
