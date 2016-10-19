//
//  WordHistoryModelTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForeverCore

class WordHistoryModelTests: XCTestCase {
    
    var wordHistory: WordHistoryModel?
    var word: WordModel?
    
    override func setUp() {
        super.setUp()
        
        word = WordModel()
        word!.phrase = "book"
        word!.meaning = "livre"
        wordHistory = WordHistoryModel()
        wordHistory!.word = word
    }
    
    override func tearDown() {
        wordHistory = nil
        word = nil
        
        super.tearDown()
    }
    
    func testWordHistoryHasWord() {
        XCTAssertEqual(wordHistory!.word, self.word!, "WordHistory should provide word field")
    }
    
    func testWordHistoryHasColumnNo() {
        wordHistory!.columnNo = 1
        XCTAssertEqual(wordHistory!.columnNo,  1, "WordHistory should provide columnNo field")
    }
    
    func testWordHistoryHasFailCount() {
        wordHistory!.failureCount = 1
        XCTAssertEqual(wordHistory!.failureCount,  1, "WordHistory should provide failCount field")
    }
    
    func testWordHistoryHasId(){
        let id = UUID()
        wordHistory!.wordHistoryId = id
        XCTAssertEqual(wordHistory!.wordHistoryId, id, "WordHistory should provide wordHistoryId field")
    }

}
