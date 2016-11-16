////
////  WordHistoryDataAccessTests.swift
////  MemorizeItForeverCore
////
////  Created by Hadi Zamani on 10/23/16.
////  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
////
//
//import XCTest
//import BaseLocalDataAccess
//@testable import MemorizeItForeverCore
//
//class WordHistoryDataAccessTests: XCTestCase {
//    
//    var wordHistoryDataAccess: WordHistoryDataAccess!
//    var context: ManagedObjectContextProtocol!
//    
//    override func setUp() {
//        super.setUp()
//        context = InMemoryManagedObjectContext()
////        wordHistoryDataAccess = FakeWordHistoryDataAccess(context: context)
//    }
//    
//    override func tearDown() {
//        wordHistoryDataAccess = nil
//        context = nil
//        super.tearDown()
//    }
//    
//    func testSaveWordHistory(){
//        let word = newWordModel(context)
//        var historyModel = WordHistoryModel()
//        historyModel.columnNo = 3
//        historyModel.failureCount = 1
//        historyModel.word = word
//        do{
//            try wordHistoryDataAccess.saveOrUpdate(historyModel)
//        }
//        catch{
//            XCTFail("should be able to save a wordHistory")
//        }
//    }
//    
//    func testFetchWordHistoryByWordIdAndColumnNo(){
//        let word = newWordModel(context)
//        var historyModel = WordHistoryModel()
//        historyModel.columnNo = 3
//        historyModel.word = word
//        do{
//            try wordHistoryDataAccess.saveOrUpdate(historyModel)
//            let newHistoryModels = try wordHistoryDataAccess.fetchByWordId(historyModel)
//            XCTAssertEqual(newHistoryModels[0].columnNo, 3, "columnNo should be the given data(here is 3)")
//            XCTAssertEqual(newHistoryModels[0].failureCount, 1, "failureCount should be the given data(here is 1)")
//        }
//        catch{
//            XCTFail("should be able to save a wordHistory")
//        }
//    }
//    
//    func testSaveIncrementFailureCountWordHistory(){
//        let word = newWordModel(context)
//        var historyModel = WordHistoryModel()
//        historyModel.columnNo = 3
//        historyModel.word = word
//        do{
//            try wordHistoryDataAccess.saveOrUpdate(historyModel)
//            try wordHistoryDataAccess.saveOrUpdate(historyModel)
//            let newHistoryModels = try wordHistoryDataAccess.fetchByWordId(historyModel)
//            XCTAssertEqual(newHistoryModels[0].columnNo, 3, "columnNo should be the given data(here is 3)")
//            XCTAssertEqual(newHistoryModels[0].failureCount, 2, "failureCount should be the given data(here is 2)")
//        }
//        catch{
//            XCTFail("should be able to save a wordHistory")
//        }
//    }
//    
////    private func newWordModel(_ initialContext: ManagedObjectContextProtocol) -> WordModel?{
////        return TestFlowHelper().NewWordModel(initialContext)
////    }
//
//}
