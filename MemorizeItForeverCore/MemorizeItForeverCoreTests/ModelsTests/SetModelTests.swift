//
//  SetModelTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForeverCore

class SetModelTests: XCTestCase {
    
    var set: SetModel!
    
    override func setUp() {
        super.setUp()
        set = SetModel()
    }
    
    override func tearDown() {
        set = nil
        
        super.tearDown()
    }
    
    func testSetHasSetId(){
        let id = UUID()
        set.setId = id
        XCTAssertEqual(set.setId, id, "Set should provide setId field")
    }
    
    func testSetHasName(){
        set.name = "FrenchToEnglish"
        XCTAssertEqual(set.name, "FrenchToEnglish", "Set should provide name field")
    }
    
}
