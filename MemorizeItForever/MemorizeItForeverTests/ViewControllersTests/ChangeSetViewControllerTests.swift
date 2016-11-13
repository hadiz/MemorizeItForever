//
//  ChangeSetViewControllerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import MemorizeItForeverCore
@testable import MemorizeItForever

class ChangeSetViewControllerTests: XCTestCase {
    
    var changeSetViewController: ChangeSetViewController!
    var dataSource: SetTableDataSourceProtocol!
    var tappedSetModel: SetModel!
    
    override func setUp() {
        super.setUp()
        dataSource = FakeSetTableDataSource(setManager: nil)
        dataSource.handleTap = { (model) in
            self.tappedSetModel = model as? SetModel
        }
        changeSetViewController = ChangeSetViewController()
        changeSetViewController.dataSource = dataSource
        changeSetViewController.setManager = MockSetManager()
        _ = changeSetViewController.view
    }
    
    override func tearDown() {
        dataSource = nil
        objc_removeAssociatedObjects(changeSetViewController)
        changeSetViewController = nil

        super.tearDown()
    }
    
    func testChangeSetViewControllerHasATitle(){
        changeSetViewController.viewDidLoad()
        XCTAssertEqual(changeSetViewController.title, "Change Set", "ChangeSetViewController should have title")
    }
    
    func testChangeSetViewControllerHasADataSource(){
        changeSetViewController.viewDidLoad()
        XCTAssertNotNil(changeSetViewController.dataSource, "ChangeSetViewController should have dataSource")
    }
    
    func testChangeSetViewControllerHasATableView(){
        changeSetViewController.viewDidLoad()
        XCTAssertNotNil(changeSetViewController.dataSource,"ChangeSetViewController should have tableView")
    }
    
    func testTableViewInChangeSetViewControllerHasDataSource(){
        changeSetViewController.viewDidLoad()
        XCTAssertTrue((changeSetViewController.dataSource! as Any) is MemorizeItTableDataSourceProtocol , "Datasource property of tableView in ChangeSetViewController should be a MemorizeItTableDataSourceProtocol")
    }
    
    func testTableViewInChangeSetViewControllerHasDelegate(){
        changeSetViewController.viewDidLoad()
        XCTAssertTrue((changeSetViewController.dataSource! as Any) is MemorizeItTableDataSourceProtocol, "Delegate property of tableView in ChangeSetViewController be a MemorizeItTableDataSourceProtocol")
    }
    
    func testChangeSetViewControllerConformsToUIPopoverPresentationControllerDelegate(){
        XCTAssertTrue((changeSetViewController as Any) is UIPopoverPresentationControllerDelegate,"ChangeSetViewController should conforms to UIPopoverPresentationControllerDelegate")
        
    }
    
    func testIphonePresentPopover(){
        changeSetViewController.modalPresentationStyle = .popover
        let modalPresentationStyle = changeSetViewController.adaptivePresentationStyle(for: changeSetViewController.popoverPresentationController!)
        
        XCTAssertEqual(modalPresentationStyle, UIModalPresentationStyle.none, "AdaptivePresentationStyleForPresentationController should return none")
    }

}
