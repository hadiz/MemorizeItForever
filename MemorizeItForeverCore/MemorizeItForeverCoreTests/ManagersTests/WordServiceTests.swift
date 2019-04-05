//
//  WordServiceTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/23/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class WordServiceTests: XCTestCase {
    
    var wordService: WordServiceProtocol!
    var wordDataAccess: WordDataAccessProtocol!
    var wordModel: WordModel!

    override func setUp() {
        super.setUp()
        wordDataAccess = FakeWordDataAccess()
        wordService = WordService(wordDataAccess: wordDataAccess)
        wordModel = WordModel()
        wordModel.wordId = UUID()
        wordModel.phrase = "Livre"
        wordModel.meaning = "Book"
        wordModel.order = 1
        wordModel.setId = UUID()
        wordModel.status =  WordStatus.notStarted.rawValue
    }
    
    override func tearDown() {
        wordDataAccess = nil
        wordService = nil
        wordModel = nil
        super.tearDown()
    }
    
    func testSaveNewWord() {
        do{
            try wordService.save("Livre", meaninig: "Book", setId: UUID())
        }
        catch{
        }
        if let enumResult = objc_getAssociatedObject(wordDataAccess, &resultKey) as? FakeSetDataAccessEnum{
            XCTAssertEqual(enumResult, .save ,"should save word")
        }
        else{
            XCTFail("should save word")
        }
    }
    func testEditWord() {
        
        wordService.edit(wordModel, phrase: "Merci", meaninig: "Thanks", setId: nil)
        
        if let wordPhrase = objc_getAssociatedObject(wordDataAccess, &phraseKey) as? String{
            XCTAssertEqual(wordPhrase, "Merci" ,"should edit with new phrase")
        }
        else{
            XCTFail("should edit word")
        }
        
        if let wordMeaninig = objc_getAssociatedObject(wordDataAccess, &meaningKey) as? String{
            XCTAssertEqual(wordMeaninig, "Thanks" ,"should edit with new meaninig")
        }
        else{
            XCTFail("should edit word")
        }
        
        if let wordOrder = objc_getAssociatedObject(wordDataAccess, &orderKey) as? Int32{
            XCTAssertEqual(wordOrder, wordModel.order! ,"should edit with initial order")
        }
        else{
            XCTFail("should edit word")
        }
        
        if let wordStatus = objc_getAssociatedObject(wordDataAccess, &statusKey) as? Int16{
            XCTAssertEqual(wordStatus, wordModel.status! ,"should edit with initial status")
        }
        else{
            XCTFail("should edit word")
        }
        
        if let wordSetId = objc_getAssociatedObject(wordDataAccess, &setIdKey) as? UUID{
            XCTAssertEqual(wordSetId, wordModel.setId! ,"should edit with initial setId")
        }
        else{
            XCTFail("should edit word")
        }
        
        if let wordWordId = objc_getAssociatedObject(wordDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordWordId, wordModel.wordId! ,"should edit with initial wordId")
        }
        else{
            XCTFail("should edit word")
        }
    }
    
    func testDeleteWord() {
        _ = wordService.delete(wordModel)
        if let enumResult = objc_getAssociatedObject(wordDataAccess, &resultKey) as? FakeSetDataAccessEnum{
            XCTAssertEqual(enumResult, .delete ,"should delete word")
        }
        else{
            XCTFail("should delete word")
        }
    }
}
