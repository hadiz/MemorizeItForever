//
//  PhraseTableDataSourceTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/3/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import MemorizeItForeverCore
@testable import MemorizeItForever

class PhraseTableDataSourceTests: XCTestCase {
    
    var word: WordModel!
    var dataSource: PhraseTableDataSourceProtocol!
    var firstItemIndex: IndexPath!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        word = WordModel()
        word.setId = UUID()
        word.meaning = "Book"
        word.order = 1
        word.phrase = "Livre"
        word.status = 0
        word.wordId = UUID()
        dataSource = PhraseTableDataSource(wordService: nil)
        dataSource.setModels([word])
        firstItemIndex = IndexPath(item: 0, section: 0)
        tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifierEnum: .phraseTableCellIdentifier)
    }
    
    override func tearDown() {
        dataSource = nil
        firstItemIndex = nil
        word = nil
        tableView = nil
        super.tearDown()
    }
    
    func testReturnOneRowForOneWord(){
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1, "It should Just 1 row in tableView because we have just 1 word")
    }
    
    func testReturnTwoRowForTwoSets(){
        var word2 = WordModel()
        word2.setId = UUID()
        word2.meaning = "Book2"
        word2.order = 2
        word2.phrase = "Livre2"
        word2.status = 0
        word2.wordId = UUID()
        dataSource.setModels([word, word2])
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2, "It should Just 2 row in tableView because we have just 2 words")
    }
    
    func testEachCellHasTitleCorrespondsToPhrase(){
        let cell = dataSource.tableView(tableView, cellForRowAt: firstItemIndex)
        XCTAssertEqual(cell.textLabel?.text, "Livre", "The cell should have phrase as a title")
    }
    
    func testCellBackgroundShouldBeWhiteWhenNotStarted(){
        var word2 = WordModel()
        word2.setId = UUID()
        word2.meaning = "Book2"
        word2.order = 2
        word2.phrase = "Livre2"
        word2.status = WordStatus.notStarted.rawValue
        word2.wordId = UUID()
        dataSource.setModels([word2])
        let cell = dataSource.tableView(tableView, cellForRowAt: firstItemIndex)
        var color: UIColor?
        
        if #available(iOS 11.0, *) {
            color = UIColor(named: "wordStatusNotStarted")
        } else {
            color =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        XCTAssertEqual(cell.backgroundColor, color, "The cell should have white background if the status of word is notStarted")
    }
    
    func testCellBackgroundShouldBeRedWhenInProgress(){
        var word2 = WordModel()
        word2.setId = UUID()
        word2.meaning = "Book2"
        word2.order = 2
        word2.phrase = "Livre2"
        word2.status = WordStatus.inProgress.rawValue
        word2.wordId = UUID()
        dataSource.setModels([word2])
        let cell = dataSource.tableView(tableView, cellForRowAt: firstItemIndex)
        var color: UIColor?
        
        if #available(iOS 11.0, *) {
            color = UIColor(named: "wordStatusInProgress")
        } else {
            color = #colorLiteral(red: 0.9993608594, green: 0.1497559547, blue: 0, alpha: 1).withAlphaComponent(0.5)
        }
        XCTAssertEqual(cell.backgroundColor, color, "The cell should have white background if the status of word is notStarted")
    }
    
    func testCellBackgroundShouldBeGreenWhenDone(){
        var word2 = WordModel()
        word2.setId = UUID()
        word2.meaning = "Book2"
        word2.order = 2
        word2.phrase = "Livre2"
        word2.status = WordStatus.done.rawValue
        word2.wordId = UUID()
        dataSource.setModels([word2])
        let cell = dataSource.tableView(tableView, cellForRowAt: firstItemIndex)
        var color: UIColor?
        
        if #available(iOS 11.0, *) {
            color = UIColor(named: "wordStatusDone")
        } else {
            color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1).withAlphaComponent(0.5)
        }
        XCTAssertEqual(cell.backgroundColor, color, "The cell should have white background if the status of word is notStarted")
    }
    
    func testPhraseTableDataSourceCanHoldAClouserForHandleTap(){
        dataSource.handleTap = { (model) in
        }
        XCTAssertNotNil(dataSource.handleTap, "PhraseTableDataSource can handle an clouser for handling tap event")
    }
    
    func testHandleTapClosureIsCalledWhenTapped(){
        var tapped = false
        dataSource.handleTap = { (model) in
            tapped = true
        }
        dataSource.tableView!(tableView, didSelectRowAt: firstItemIndex)
        XCTAssertTrue(tapped,"HandleTap clouser should be called in didSelectRowAtIndexPath action")
    }
    
    func testHandleTapClosureHasWordModelInstanceWhenTapped(){
        var wordModel: WordModel? = nil
        dataSource.handleTap = { (model) in
            wordModel = model as? WordModel
        }
        dataSource.tableView!(tableView, didSelectRowAt: firstItemIndex)
        XCTAssertEqual(wordModel?.phrase, "Livre","HandleTap clouser should hold  a setModel instance")
    }
}
