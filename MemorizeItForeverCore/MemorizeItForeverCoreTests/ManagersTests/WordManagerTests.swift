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
    
    var wordManager: WordManager?
    var wordDataAccess: WordDataAccess?
    var context: ManagedObjectContextProtocol?
    
    override func setUp() {
        super.setUp()
        context = InMemoryManagedObjectContext()
        wordDataAccess = FakeWordDataAccess(context: context!)
        wordManager = WordManager(dataAccess: wordDataAccess!, wordInProgressDataAccess: nil, wodHistoryDataAccess: nil)
    }
    
    override func tearDown() {
        wordDataAccess = nil
        wordManager = nil
        context = nil
        super.tearDown()
    }
    
    func testSaveNewWord() {
        do{
            wordManager!.saveWord("Livre",meaninig: "Book",setId: newSetEntity(context!)!.setId!)
            let words = try wordDataAccess?.fetchAll()
            XCTAssertEqual(words?.count, 1, "Should save a new word")
        }
        catch{
            XCTFail("Should save a new word")
        }
    }
    func testEditWord() {
        do{
            wordManager!.saveWord("Livre",meaninig: "Book",setId: newSetEntity(context!)!.setId!)
            let word = try wordDataAccess?.fetchAll()[0]
            wordManager!.editWord(word!, phrase: "LivreEdited", meaninig: "BookEdited")
            let words = try wordDataAccess?.fetchAll()
            XCTAssertEqual(words![0].phrase, "LivreEdited", "Should be able to edit phrase field of a word")
            XCTAssertEqual(words![0].meaning, "BookEdited", "Should be able to edit meaning field of a word")
        }
        catch{
            XCTFail("Should be able to edit a word")
        }
    }
    
    func testDeleteWord() {
        do{
            wordManager!.saveWord("Livre",meaninig: "Book",setId: newSetEntity(context!)!.setId!)
            let word = try wordDataAccess?.fetchAll()[0]
            wordManager!.deleteWord(word!)
            let newWords = try wordDataAccess?.fetchAll()
            XCTAssertEqual(newWords?.count, 0, "Should be able to delete a word")
        }
        catch{
            XCTFail("Should be able to delete a word")
        }
    }
    
    private func newSetEntity(_ initialContext: ManagedObjectContextProtocol) -> SetModel?{
        return TestFlowHelper().NewSetModel(initialContext)
    }
    
}
