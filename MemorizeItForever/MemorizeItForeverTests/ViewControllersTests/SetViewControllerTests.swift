//
//  SetViewControllerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import MemorizeItForeverCore
@testable import MemorizeItForever

class SetViewControllerTests: XCTestCase {
    
    var setViewController: SetViewController?
    var dataSource: MemorizeItTableDataSourceProtocol?
    var tableView: UITableView?
    var tappedSetModel: SetModel?
    
    override func setUp() {
        super.setUp()
        dataSource = FakeSetTableDataSource(handleTap: { (model) in
            self.tappedSetModel = model as? SetModel
        })
        tableView = UITableView()
        setViewController = SetViewController()
        setViewController!.dataSource = dataSource
        setViewController!.tableView = tableView
    }
    
    override func tearDown() {
        dataSource = nil
        tableView = nil
        objc_removeAssociatedObjects(setViewController)
        setViewController = nil
        super.tearDown()
    }
    
    func testSetViewControllerHasATitle(){
        setViewController?.viewDidLoad()
        XCTAssertEqual(setViewController?.title, "Set List", "SetViewController should have title")
    }
    
    func testSetViewControllerHasADataSource(){
        setViewController?.viewDidLoad()
        XCTAssertNotNil(setViewController?.dataSource, "SetViewController should have dataSource")
    }
    
    func testSetViewControllerHasATableView(){
        setViewController?.viewDidLoad()
        XCTAssertEqual(tableView?.isEqual(setViewController?.tableView), true, "SetViewController should have tableView")
    }
    
    func testTableViewInSetViewControllerHasDataSource(){
        setViewController?.viewDidLoad()
        XCTAssertEqual(tableView?.dataSource is MemorizeItTableDataSourceProtocol, true, "Datasource property of tableView in SetViewController should be a MemorizeItTableDataSourceProtocol")
    }
    
    func testTableViewInSetViewControllerHasDelegate(){
        setViewController?.viewDidLoad()
        XCTAssertEqual(tableView?.delegate is MemorizeItTableDataSourceProtocol, true, "Delegate property of tableView in SetViewController be a MemorizeItTableDataSourceProtocol")
    }
    
    func testSetViewControllerConformsToUIPopoverPresentationControllerDelegate(){
        XCTAssertTrue(setViewController is UIPopoverPresentationControllerDelegate,"setViewController should conforms to UIPopoverPresentationControllerDelegate")
        
    }
    
    func testIphonePresentPopover(){
        setViewController!.modalPresentationStyle = .popover
        let modalPresentationStyle = setViewController?.adaptivePresentationStyle(for: setViewController!.popoverPresentationController!)
        
        XCTAssertEqual(modalPresentationStyle, UIModalPresentationStyle.none, "AdaptivePresentationStyleForPresentationController should return none")
    }
    
}
