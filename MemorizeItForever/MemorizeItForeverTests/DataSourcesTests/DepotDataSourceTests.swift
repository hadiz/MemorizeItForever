//
//  DepotDataSourceTests.swift
//  MemorizeItForeverTests
//
//  Created by Hadi Zamani on 11/19/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import MemorizeItForeverCore
@testable import MemorizeItForever

class DepotDataSourceTests: XCTestCase {
    var depotModel: DepotPhraseModel!
    var dataSource: MemorizeItTableDataSourceProtocol!
    var firstItemIndex: IndexPath!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        depotModel = DepotPhraseModel()
        depotModel.id = UUID()
        depotModel.phrase = "Test"
        dataSource = DepotDataSource(service: MockDepotPhraseService())
        dataSource.setModels([depotModel])
        firstItemIndex = IndexPath(item: 0, section: 0)
        tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifierEnum: .depotTableCellIdentifier)
    }

    override func tearDown() {
        dataSource = nil
        firstItemIndex = nil
        depotModel = nil
        tableView = nil
        super.tearDown()
    }

    func testReturnOneRowForOnePhrase(){
        let numberOfRows = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1, "Table should have just one row because there is just one phrase")
    }
    
    func testReturnTwoRowForTwoPhrases(){
        var depotModel2 = DepotPhraseModel()
        depotModel2.phrase = "Test 2"
        dataSource.setModels([depotModel, depotModel2])
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
    
    func testTableHasTheAddAction(){
        let actions = dataSource.tableView?(UITableView(), editActionsForRowAt: firstItemIndex)
        XCTAssertTrue(actions?.contains { $0.title == "Add" } ?? false)
    }
}
