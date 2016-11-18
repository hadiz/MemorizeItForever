//
//  WordManagerTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/23/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class WordManagerTests: XCTestCase {
    
    var wordManager: WordManagerProtocol!
    var wordDataAccess: WordDataAccessProtocol!

    override func setUp() {
        super.setUp()
        wordDataAccess = FakeWordDataAccess()
        wordManager = WordManager(wordDataAccess: wordDataAccess)
    }
    
    override func tearDown() {
        wordDataAccess = nil
        wordManager = nil
        super.tearDown()
    }
    
    func testSaveNewWord() {
        wordManager.saveWord("Livre", meaninig: "Book", setId: UUID())
        if let enumResult = objc_getAssociatedObject(wordDataAccess, &resultKey) as? FakeSetDataAccessEnum{
            XCTAssertEqual(enumResult, .save ,"should save word")
        }
        else{
            XCTFail("should save word")
        }
    }
    func testEditWord() {
        let wordModel = WordModel(wordId: UUID(), phrase: "Livre", meaning: "Book", order: 1, setId: UUID(), status:  WordStatus.notStarted.rawValue)
        
        wordManager.editWord(wordModel, phrase: "Merci", meaninig: "Thanks")
        
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
         let wordModel = WordModel(wordId: UUID(), phrase: "Livre", meaning: "Book", order: 1, setId: UUID(), status:  WordStatus.notStarted.rawValue)
        wordManager.deleteWord(wordModel)
        if let enumResult = objc_getAssociatedObject(wordDataAccess, &resultKey) as? FakeSetDataAccessEnum{
            XCTAssertEqual(enumResult, .delete ,"should delete word")
        }
        else{
            XCTFail("should delete word")
        }

    }

}
