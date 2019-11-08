//
//  TemporaryPhraseListDataSourceTests.swift
//  MemorizeItForeverTests
//
//  Created by Hadi Zamani on 11/3/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class TemporaryPhraseListDataSourceTests: XCTestCase {
    var phrase: TemporaryPhraseModel!
    var dataSource: MemorizeItTableDataSourceProtocol!
    var firstItemIndex: IndexPath!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        phrase = TemporaryPhraseModel(phrase: "Test")
        dataSource = TemporaryPhraseListDataSource()
        dataSource.setModels([phrase])
        firstItemIndex = IndexPath(item: 0, section: 0)
        tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifierEnum: .temporaryListTableIdentifier)
    }
    
    override func tearDown() {
        dataSource = nil
        firstItemIndex = nil
        phrase = nil
        tableView = nil
        super.tearDown()
    }
    
    func testReturnOneRowForOnePhrase(){
        let numberOfRows = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1, "Table should have just one row because there is just one phrase")
    }
    
    func testReturnTwoRowForTwoPhrases(){
        let phrase2 = TemporaryPhraseModel(phrase: "Test 2")
        dataSource.setModels([phrase, phrase2])
        let numberOfRows = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2, "Table should have just 2 rows because there is just 2 phrases")
    }
    
    func testEachCellHasTitleCorrespondsToPhraseName(){
        let cell = dataSource.tableView(tableView, cellForRowAt: firstItemIndex)
        XCTAssertEqual(cell.textLabel?.text, "Test", "The cell should have phrase as a title")
    }
    
    func testTableHasTheDeleteAction(){
        let actions = dataSource.tableView?(UITableView(), editActionsForRowAt: firstItemIndex)
        XCTAssertTrue(actions?.contains { $0.title == "Delete" } ?? false)
    }
    
    func testTableHasTheEditAction(){
        let actions = dataSource.tableView?(UITableView(), editActionsForRowAt: firstItemIndex)
        XCTAssertTrue(actions?.contains { $0.title == "Edit" } ?? false)
    }
    
    func testTableHasTheAddAction(){
        let actions = dataSource.tableView?(UITableView(), editActionsForRowAt: firstItemIndex)
        XCTAssertTrue(actions?.contains { $0.title == "Add" } ?? false)
    }
    
    func testDeleteAPhrase(){
       let actions = dataSource.tableView?(UITableView(), editActionsForRowAt: firstItemIndex)
        let deleteAction = actions?.first(where: { $0.title == "Delete" })
//        deleteAction.
    }
    
}
