//
//  DepotPhraseServiceTests.swift
//  MemorizeItForeverCoreTests
//
//  Created by Hadi Zamani on 11/14/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class DepotPhraseServiceTests: XCTestCase {

    var service: DepotPhraseServiceProtocol!
    var dataAccess: DepotPhraseDataAccessProtocol!
    
    override func setUp() {
        dataAccess = FakeDepotPhraseDataAccess()
        service = DepotPhraseService(dataAccess: dataAccess)
    }

    override func tearDown() {
        dataAccess = nil
        service = nil
    }

    func testSaveNewDepotPhrase() {
        service.save("Book")
        if let enumResult = objc_getAssociatedObject(dataAccess, &resultKey) as? FakeDepotPhraseDataAccessEnum{
            XCTAssertEqual(enumResult, .save ,"should save DepotPhrase")
        }
        else{
            XCTFail("should save DepotPhrase")
        }
    }
    
    func testSaveBatchDepotPhrase() {
        service.save(["Book", "apple", "develop"])
        if let enumResult = objc_getAssociatedObject(dataAccess, &resultKey) as? FakeDepotPhraseDataAccessEnum{
            XCTAssertEqual(enumResult, .save ,"should save DepotPhrase")
        }
        else{
            XCTFail("should save DepotPhrase")
        }
    }
    
    func testDeleteDepotPhrase() {
        objc_setAssociatedObject(dataAccess, &setNumberKey, 2, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        var model = DepotPhraseModel()
        model.phrase = "Book"
        model.id = UUID()
        let deleted = service.delete(model)
        if let enumResult = objc_getAssociatedObject(dataAccess, &resultKey) as? FakeDepotPhraseDataAccessEnum{
            XCTAssertEqual(enumResult, .delete ,"should delete DepotPhrase")
        }
        else{
            XCTFail("should delete DepotPhrase")
        }
        XCTAssertTrue(deleted, "should delete DepotPhrase")
    }

}
