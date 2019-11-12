//
//  DepotPhraseModelTests.swift
//  MemorizeItForeverCoreTests
//
//  Created by Hadi Zamani on 11/10/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForeverCore

class DepotPhraseModelTests: XCTestCase {
    
    var depot: DepotPhraseModel!
    
    override func setUp() {
        depot = DepotPhraseModel()
    }
    
    override func tearDown() {
        depot = nil
    }
    
    func testDepotHasId(){
        let id = UUID()
        depot.id = id
        XCTAssertEqual(depot.id, id, "DepotPhrase should provide id field")
    }
    
    func testDepotHasPhrase(){
        depot.phrase = "book"
        XCTAssertEqual(depot.phrase, "book", "DepotPhrase should provide phrase field")
    }
    
}
