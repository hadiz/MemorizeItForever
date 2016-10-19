//
//  WordInProgressModelTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForeverCore

class WordInProgressModelTests: XCTestCase {
    
    var wordInProgress: WordInProgressModel?
    var word: WordModel?
    
    override func setUp() {
        super.setUp()
        
        word = WordModel()
        word!.phrase = "book"
        word!.meaning = "livre"
        word!.wordId = UUID()
        wordInProgress = WordInProgressModel()
        wordInProgress!.word = word
    }
    
    override func tearDown() {
        wordInProgress = nil
        word = nil
        
        super.tearDown()
    }
    
    func testWordInProgressHasWord() {
        XCTAssertEqual(wordInProgress!.word, self.word!, "WordInProgress should provide word ")
    }
    
    func testWordInProgressHasDate() {
        let date = Date()
        wordInProgress!.date = date
        XCTAssertEqual(wordInProgress!.date, date, "WordInProgress should provide date field")
    }
    
    func testWordInProgressHasColumn() {
        wordInProgress!.column = 1
        XCTAssertEqual(wordInProgress!.column, 1, "WordInProgress should provide column field")
    }
    
    func testWordInProgressHasId(){
        let id = UUID()
        wordInProgress!.wordInProgressId = id
        XCTAssertEqual(wordInProgress!.wordInProgressId, id, "WordInProgress should provide wordInProgressId field")
    }
    
}
