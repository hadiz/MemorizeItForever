//
//  ChangeSetTableDataSourceTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import MemorizeItForeverCore
@testable import MemorizeItForever

class ChangeSetTableDataSourceTests: XCTestCase {
    
    var set: SetModel!
    var dataSource: SetTableDataSourceProtocol!
    var firstItemIndex: IndexPath!
    
    override func setUp() {
        super.setUp()
        set = SetModel()
        set.setId = UUID()
        set.name = "Default"
        dataSource = ChangeSetTableDataSource()
        dataSource.setModels([set])
        firstItemIndex = IndexPath(item: 0, section: 0)
    }
    
    override func tearDown() {
        dataSource = nil
        firstItemIndex = nil
        set = nil
        super.tearDown()
    }
    
    func testReturnOneRowForOneSet(){
        let numberOfRows = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1, "It should Just 1 row in tableView because we have just 1 set")
    }
    
    func testReturnTwoRowForTwoSets(){
        var set = SetModel()
        set.setId = UUID()
        set.name = "Default"
        var set2 = SetModel()
        set2.setId = UUID()
        set2.name = "Default2"
        dataSource.setModels([set, set2])
        let numberOfRows = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2, "It should Just 2 row in tableView because we have just 2 sets")
    }
    
    func testEachCellHasTitleCorrespondsToSetName(){
        let cell = dataSource.tableView(UITableView(), cellForRowAt: firstItemIndex)
        XCTAssertEqual(cell.textLabel?.text, "Default", "The cell should have set name as a title")
    }
    
    func testSetTableDataSourceCanHoldAClouserForHandleTap(){
        dataSource = SetTableDataSource(setManager: nil)
        dataSource.handleTap = { (model) in
        }
        XCTAssertNotNil((dataSource as? SetTableDataSource)!.handleTap, "SetTableDataSource can handle an clouser for handling tap event")
    }
    
    func testHandleTapClosureIsCalledWhenTapped(){
        var tapped = false
         dataSource = ChangeSetTableDataSource(setManager: nil)
        dataSource.handleTap = { (model) in
            tapped = true
        }
        dataSource.setModels([set])
        dataSource.tableView!(UITableView(), didSelectRowAt: firstItemIndex)
        XCTAssertTrue(tapped,"HandleTap clouser should be called in didSelectRowAtIndexPath action")
    }
    
    func testHandleTapClosureHasSetModelInstanceWhenTapped(){
        var setModel: SetModel? = nil
        dataSource = SetTableDataSource(setManager: nil)
        dataSource.handleTap = { (model) in
            setModel = model as? SetModel
        }
        dataSource.setModels([set])
        dataSource.tableView!(UITableView(), didSelectRowAt: firstItemIndex)
        XCTAssertEqual(setModel?.name, "Default","HandleTap clouser should hold  a setModel instance")
    }
}
