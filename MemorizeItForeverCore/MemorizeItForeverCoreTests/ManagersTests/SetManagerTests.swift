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
    
    var setManager: SetManagerProtocol!
    var setDataAccess: SetDataAccessProtocol!
    
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
        objc_setAssociatedObject(setDataAccess, &setNumberKey, 0, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        setManager.createDefaultSet()
        if let enumResult = objc_getAssociatedObject(setDataAccess, &resultKey) as? FakeSetDataAccessEnum{
            XCTAssertEqual(enumResult, .save ,"should create Default Set")
        }
        else{
            XCTFail("should create Default Set")
        }
    }
    
    func testDoNotCreateDefaultSetIfSetExists() {
        
        objc_setAssociatedObject(setDataAccess, &setNumberKey, 1, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        setManager.createDefaultSet()
        let enumResult = objc_getAssociatedObject(setDataAccess, &resultKey) as? FakeSetDataAccessEnum
        XCTAssertNil(enumResult, "Should not create Default set if it is exists")
    }
    
    func testSaveNewSet() {
        setManager.save("EnglishToFrench")
        if let enumResult = objc_getAssociatedObject(setDataAccess, &resultKey) as? FakeSetDataAccessEnum{
            XCTAssertEqual(enumResult, .save ,"should save Set")
        }
        else{
            XCTFail("should save Set")
        }
    }
    
    func testEditSet() {
        var model = SetModel()
        model.name = "Default"
        model.setId = UUID()
        
        setManager.edit(model, setName: "Default2")
        
        if let setName = objc_getAssociatedObject(setDataAccess, &setNameKey) as? String{
            XCTAssertEqual(setName, "Default2" ,"should edit with new SetName")
        }
        else{
            XCTFail("should edit Set")
        }
        
        if let setName = objc_getAssociatedObject(setDataAccess, &setIdKey) as? UUID{
            XCTAssertEqual(setName, model.setId ,"should edit with initial SetId")
        }
        else{
            XCTFail("should edit Set")
        }
    }
    
    func testDeleteSetIfIsDeletable() {
        objc_setAssociatedObject(setDataAccess, &setNumberKey, 2, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        var model = SetModel()
        model.name = "Default"
        model.setId = UUID()
        let deleted = setManager.delete(model)
        if let enumResult = objc_getAssociatedObject(setDataAccess, &resultKey) as? FakeSetDataAccessEnum{
            XCTAssertEqual(enumResult, .delete ,"should delete Set")
        }
        else{
            XCTFail("should delete Set")
        }
        XCTAssertTrue(deleted, "should delete Set")
    }
    
    func testNotDeleteSetIfIsNotDeletable() {
        objc_setAssociatedObject(setDataAccess, &setNumberKey, 1, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        var model = SetModel()
        model.name = "Default"
        model.setId = UUID()
        let deleted = setManager.delete(model)
        let enumResult = objc_getAssociatedObject(setDataAccess, &resultKey) as? FakeSetDataAccessEnum
        XCTAssertNil(enumResult ,"should not delete Set")
        XCTAssertFalse(deleted, "should not delete Set")
    }
}
