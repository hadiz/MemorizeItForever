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
        let managedObjectContext = InMemoryManagedObjectContext()
        let dataAccess = MockGenericDataAccess<DepotPhraseEntity>(context: managedObjectContext)
        depotDataAccess = DepotPhraseDataAccess(genericDataAccess: dataAccess)
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
    
    func testBatchSave() {
        var DepotPhraseModels = [DepotPhraseModel]()
        var depotModel = DepotPhraseModel()
        depotModel.phrase = "book"
        
        var depotModel2 = DepotPhraseModel()
        depotModel2.phrase = "apple"
        
        DepotPhraseModels.append(depotModel)
        DepotPhraseModels.append(depotModel2)
        
        do {
            try depotDataAccess.save(depotPhraseModels: DepotPhraseModels)
        }
        catch {
            XCTFail("should be able to save batch depot phrase")
        }
    }
    
    func testFetch(){
        do{
            var depotModel = DepotPhraseModel()
            depotModel.phrase = "book"
            
            try depotDataAccess.save(depotPhraseModel: depotModel)
            let depotPhrases = try depotDataAccess.fetchAll()
            XCTAssertEqual(depotPhrases.count, 1, "should be able to fetch depotPhrases")
        }
        catch{
            XCTFail("should be able to fetch depotPhrases")
        }
    }
    
    func testDelete(){
        do{
            var depotModel = DepotPhraseModel()
            depotModel.phrase = "book"
            
            try depotDataAccess.save(depotPhraseModel: depotModel)
            let depotPhrases = try depotDataAccess.fetchAll()
            try depotDataAccess.delete(depotPhrases[0])
            let newdepotPhrases = try depotDataAccess.fetchAll()
            
            XCTAssertEqual(newdepotPhrases.count, 0, "Should be able to delete a depotPhrases")
        }
        catch{
            XCTFail("Should be able to delete a set")
        }
    }
}
