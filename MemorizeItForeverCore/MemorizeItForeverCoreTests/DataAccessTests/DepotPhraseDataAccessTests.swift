//
//  DepotPhraseDataAccessTests.swift
//  MemorizeItForeverCoreTests
//
//  Created by Hadi Zamani on 11/8/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForeverCore

class DepotPhraseDataAccessTests: XCTestCase {

    var depotDataAccess: DepotPhraseDataAccessProtocol!
    
    override func setUp() {
        depotDataAccess = DepotPhraseDataAccess()
    }

    override func tearDown() {
        depotDataAccess = nil
    }
    
    func testSave() {
        var depotModel = DepotPhraseModel()
        depotModel.phrase = "book"
        
        do {
            try depotDataAccess.save(depotPhraseModel: depotModel)
        }
        catch {
            XCTFail("should be able to save a depot phrase")
        }
    }

//    func testFetchDepotPhrasesWhenHasData() {
//        do {
//            let result = try depotDataAccess.fetchAll()
//            
//            XCTAssertGreaterThan(result.count, 0)
//        }
//        catch {
//            
//        }
//        
//    }
}
