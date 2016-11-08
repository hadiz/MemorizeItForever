//
//  WordInProgressDataAccessTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/23/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class WordInProgressDataAccessTests: XCTestCase {
    
    var wordInProgressDataAccess: WordInProgressDataAccess!
    var context: ManagedObjectContextProtocol!

    override func setUp() {
        super.setUp()
        context = InMemoryManagedObjectContext()
        wordInProgressDataAccess = FakeWordInProgressDataAccess(context: context)
    }
    
    override func tearDown() {
        wordInProgressDataAccess = nil
        context = nil
        super.tearDown()
    }
    
    func testSaveWordInProgress(){
        let word = newWordModel(context)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 0
        inProgressModel.date = Date()
        inProgressModel.word = word
        do{
            try wordInProgressDataAccess.save(inProgressModel)
        }
        catch{
            XCTFail("should be able to save a wordInProgress")
        }
    }
    
    func testFetchWordInProgress() {
        let word = newWordModel(context)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 0
        inProgressModel.date = Date()
        inProgressModel.word = word
        do{
            try wordInProgressDataAccess.save(inProgressModel)
            let wordInProgresses = try wordInProgressDataAccess.fetchAll()
            XCTAssertEqual(wordInProgresses.count, 1, "should be able to fetch wordInProgresses")
        }
        catch{
            XCTFail("should be able to fetch wordInProgresses")
        }
    }
    
    func testEditWordInProgress(){
        let word = newWordModel(context)
        var inProgressModel = WordInProgressModel()
        inProgressModel.column = 0
        inProgressModel.date = Date()
        inProgressModel.word = word
        do{
            try wordInProgressDataAccess.save(inProgressModel)
            var wordInProgresses = try wordInProgressDataAccess.fetchAll()[0]
            wordInProgresses.column = 2
            wordInProgresses.date = Date().addDay(4)
            try wordInProgressDataAccess.edit(wordInProgresses)
            let newWordInProgresses = try wordInProgressDataAccess.fetchAll()[0]
            XCTAssertEqual(newWordInProgresses.column, 2, "should be able to edit the column field")
            XCTAssertEqual(newWordInProgresses.date!.equalToDateWithoutTime(Date().addDay(4)!), true, "should be able to edit the date field")
        }
        catch{
            XCTFail("should be able to edit a wordInProgress")
        }
    }
    
    func testDeleteWordInProgresses(){
        do{
            let word = newWordModel(context)
            var inProgressModel = WordInProgressModel()
            inProgressModel.column = 0
            inProgressModel.date = Date()
            inProgressModel.word = word
            try wordInProgressDataAccess.save(inProgressModel)
            
            var wordInProgresses = try wordInProgressDataAccess.fetchAll()
            
            try wordInProgressDataAccess.delete(wordInProgresses[0])
            let newWordInProgresses = try wordInProgressDataAccess.fetchAll()
            
            XCTAssertEqual(newWordInProgresses.count, 0, "Should be able to delete a wordInProgresses")
        }
        catch{
            XCTFail("Should be able to delete a InProgresses")
        }
    }
    
    private func newWordModel(_ initialContext: ManagedObjectContextProtocol) -> WordModel?{
        return TestFlowHelper().NewWordModel(initialContext)
    }
    
}
