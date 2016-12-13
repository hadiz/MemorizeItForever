//
//  WordModelTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForeverCore

class WordModelTests: XCTestCase {
    
    var word: WordModel!
    
    override func setUp() {
        super.setUp()
        
        word = WordModel()
        word.phrase = "book"
        word.meaning = "livre"
        
    }
    
    override func tearDown() {
        word = nil
        
        super.tearDown()
    }
    
    func testWordHasPhrase() {
        XCTAssertEqual(word.phrase, "book", "Word should provide phrase field")
    }
    
    func testWordHasMeaning() {
        XCTAssertEqual(word.meaning, "livre", "Word should provide meaning field")
    }
    
    func testWordHasOrder(){
        word.order = 1
        XCTAssertEqual(word.order, 1, "Word should provide order field")
    }
    
    func testWordHasWordId(){
        let id = UUID()
        word.wordId = id
        XCTAssertEqual(word.wordId, id, "Word should provide wordId field")
    }
    
    func testWordHasSetId(){
        let id = UUID()
        var set = SetModel()
        set.setId = id
        word.setId = set.setId
        XCTAssertEqual(word.setId, id, "Word should provide setId field")
    }
    
    func testWordHasStatus() {
        word.status = WordStatus.done.rawValue
        XCTAssertEqual(word.status, WordStatus.done.rawValue, "Word should provide status field")
    }
    
}
