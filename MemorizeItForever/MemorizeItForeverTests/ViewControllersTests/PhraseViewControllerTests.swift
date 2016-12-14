//
//  PhraseViewControllerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/3/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import MemorizeItForeverCore
@testable import MemorizeItForever

class PhraseViewControllerTests: XCTestCase {
    
    var phraseViewController: PhraseViewController!
    var dataSource: PhraseTableDataSourceProtocol!
    
    override func setUp() {
        super.setUp()
        dataSource = FakePhraseTableDataSource(wordManager: nil)
        dataSource.handleTap = { (model) in
        }

        phraseViewController = PhraseViewController()
        phraseViewController.dataSource = dataSource
        _ = phraseViewController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        dataSource = nil
        phraseViewController = nil
    }
    
    func testPhraseViewControllerHasTitle(){
        phraseViewController.viewDidLoad()
        XCTAssertEqual(phraseViewController.title,"Phrase Management","PhraseViewController should have a title")
    }
    
    func testHasDoneBarButton() {
        phraseViewController.viewDidLoad()
        let doneBarButton = phraseViewController.navigationItem.leftBarButtonItem
        XCTAssertEqual(doneBarButton?.title, "Close","View controller should have a left bar button titled 'Done'")
    }
    
    func testDoneBarButtonTapHandled() {
        
        let originalSelector = #selector(PhraseViewController.doneBarButtonTapHandler)
        let swizzledSelector = #selector(PhraseViewController.mockDoneBarButtonTapHandler)
        
        Helper.methodSwizzling(PhraseViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        phraseViewController.viewDidLoad()
        let doneBarButton = phraseViewController.navigationItem.leftBarButtonItem
        UIApplication.shared.sendAction(doneBarButton!.action!, to: doneBarButton!.target, from: self, for: nil)
        let result = objc_getAssociatedObject(phraseViewController, &key) as? PhraseViewControllerEnum
        XCTAssertEqual(result, .doneBarButtonTap,"should handle done bar button item tap")
    }
    
    func testHasATableView(){
        phraseViewController.viewDidLoad()
        XCTAssertNotNil(phraseViewController.tableView, "phraseViewController should have tableView")
    }
    
    func testHasUISearchController(){
        phraseViewController.viewDidLoad()
        XCTAssertNotNil(phraseViewController.searchController, "phraseViewController should have searchController")
    }
    
    func testViewControllerConformsToUISearchResultsUpdating(){
        phraseViewController.viewDidLoad()
        XCTAssertTrue(phraseViewController.conforms(to: UISearchResultsUpdating.self),"phraseViewController should conform to UISearchResultsUpdating")
    }
    
    func testViewControllerConformsToUISearchBarDelegate(){
        phraseViewController.viewDidLoad()
        XCTAssertTrue(phraseViewController.conforms(to: UISearchBarDelegate.self),"phraseViewController should conform to UISearchBarDelegate")
    }
    
    func testHasDataSource(){
        phraseViewController.viewDidLoad()
        XCTAssertNotNil(phraseViewController.dataSource, "phraseViewController should have dataSource")
    }
    
    func testTableViewHasDataSource(){
        phraseViewController.viewDidLoad()
        XCTAssertTrue((phraseViewController.tableView.dataSource! as Any) is PhraseTableDataSourceProtocol , "Datasource property should be a PhraseTableDataSourceProtocol")
    }
    
    func testTableViewHasDelegate(){
        phraseViewController.viewDidLoad()
        XCTAssertTrue((phraseViewController.tableView.delegate! as Any) is PhraseTableDataSourceProtocol , "Delegate property should be a PhraseTableDataSourceProtocol")
    }
    
    func testviewControllerConformsToUIPopoverPresentationControllerDelegate(){
        XCTAssertTrue((phraseViewController as Any) is UIPopoverPresentationControllerDelegate,"PhraseViewController should conforms to UIPopoverPresentationControllerDelegate")
        
    }
    
    func testIphonePresentPopover(){
        phraseViewController.modalPresentationStyle = .popover
        let modalPresentationStyle = phraseViewController.adaptivePresentationStyle(for: phraseViewController.popoverPresentationController!)
        
        XCTAssertEqual(modalPresentationStyle, UIModalPresentationStyle.none, "AdaptivePresentationStyleForPresentationController should return none")
    }
}

extension PhraseViewController{
    func mockDoneBarButtonTapHandler(){
        objc_setAssociatedObject(self, &key, PhraseViewControllerEnum.doneBarButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
