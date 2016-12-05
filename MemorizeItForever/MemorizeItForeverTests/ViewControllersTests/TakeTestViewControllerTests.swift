//
//  TakeTestViewControllerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/21/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import MemorizeItForeverCore
@testable import MemorizeItForever

class TakeTestViewControllerTests: XCTestCase {
    
    var wordFlowManager: WordFlowManagerProtocol!
    var takeTestViewController: TakeTestViewController!
    
    override func setUp() {
        super.setUp()
        var setModel = SetModel()
        setModel.setId = UUID()
        setModel.name = "Default"
        UserDefaults.standard.set(setModel.toDic(), forKey:  Settings.defaultSet.rawValue)
        wordFlowManager = MockWordFlowManager()
        takeTestViewController = TakeTestViewController()
        takeTestViewController.wordFlowManager = wordFlowManager
        _ = takeTestViewController.view
    }
    
    override func tearDown() {
        wordFlowManager = nil
        objc_removeAssociatedObjects(takeTestViewController)
        takeTestViewController = nil
        super.tearDown()
    }
    
    func testTakeTestViewControllerHasTitle(){
        takeTestViewController.viewDidLoad()
        XCTAssertEqual(takeTestViewController.title,"Take a Test","TakeTestViewController should have a title")
    }
    
    func testHasDoneBarButton() {
        takeTestViewController.viewDidLoad()
        let doneBarButton = takeTestViewController.navigationItem.leftBarButtonItem
        XCTAssertEqual(doneBarButton?.title, "Close","View controller should have a left bar button titled 'Done'")
    }
    
    func testDoneBarButtonTapHandled() {
        
        let originalSelector = #selector(TakeTestViewController.doneBarButtonTapHandler)
        let swizzledSelector = #selector(TakeTestViewController.mockDoneBarButtonTapHandler)
        
        Helper.methodSwizzling(TakeTestViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        takeTestViewController.viewDidLoad()
        let doneBarButton = takeTestViewController.navigationItem.leftBarButtonItem
        UIApplication.shared.sendAction(doneBarButton!.action!, to: doneBarButton!.target, from: self, for: nil)
        let result = objc_getAssociatedObject(takeTestViewController, &key) as? TakeTestViewControllerEnum
        XCTAssertEqual(result, .doneBarButtonTap,"should handle done bar button item tap")
    }
    
    func testHasSetView() {
        takeTestViewController.viewDidLoad()
        XCTAssertNotNil(takeTestViewController!.setText, "View controller should have a setText")
    }
    
    func testHasColumnCounterLabel() {
        takeTestViewController.viewDidLoad()
        XCTAssertNotNil(takeTestViewController!.columnCounter, "View controller should have a columnCounter label")
    }
    
    func testHasShowAnswerButton() {
        takeTestViewController.viewDidLoad()
        XCTAssertNotNil(takeTestViewController!.showAnswer, "View controller should have a showAnswer Button")
    }
    
    func testShowAnswerTapHandled() {
        
        let originalSelector = #selector(TakeTestViewController.showAnswerTapHandler)
        let swizzledSelector = #selector(TakeTestViewController.mockShowAnswerTapHandler)
        
        Helper.methodSwizzling(TakeTestViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        takeTestViewController.viewDidLoad()
        takeTestViewController.showAnswer?.sendActions(for: .touchUpInside)
        let result = objc_getAssociatedObject(takeTestViewController, &key) as? TakeTestViewControllerEnum
        XCTAssertEqual(result, .showAnswerButtonTap,"should handle showAnswer button tap")
    }

    func testHasFirstCardView() {
        takeTestViewController.viewDidLoad()
        XCTAssertNotNil(takeTestViewController!.firstCardView, "View controller should have firstCardView")
    }
    
    func testHasSecondCardView() {
        takeTestViewController.viewDidLoad()
        XCTAssertNotNil(takeTestViewController!.secondCardView, "View controller should have secondCardView")
    }
    
    func testHasShowCorrectButton() {
        takeTestViewController.viewDidLoad()
        XCTAssertNotNil(takeTestViewController!.correct, "View controller should have a correct button")
    }
    
    func testCorrectTapHandled() {
        
        let originalSelector = #selector(TakeTestViewController.correctTapHandler)
        let swizzledSelector = #selector(TakeTestViewController.mockCorrectTapHandler)
        
        Helper.methodSwizzling(TakeTestViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        takeTestViewController.viewDidLoad()
        takeTestViewController.correct?.sendActions(for: .touchUpInside)
        let result = objc_getAssociatedObject(takeTestViewController, &key) as? TakeTestViewControllerEnum
        XCTAssertEqual(result, .correctButtonTap,"should handle correct button tap")
    }
    
    func testHasShowWrongButton() {
        takeTestViewController.viewDidLoad()
        XCTAssertNotNil(takeTestViewController!.wrong, "View controller should have a wrong button")
    }
    
    func testWrongTapHandled() {
        
        let originalSelector = #selector(TakeTestViewController.wrongTapHandler)
        let swizzledSelector = #selector(TakeTestViewController.mockWrongTapHandler)
        
        Helper.methodSwizzling(TakeTestViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        takeTestViewController.viewDidLoad()
        takeTestViewController.wrong?.sendActions(for: .touchUpInside)
        let result = objc_getAssociatedObject(takeTestViewController, &key) as? TakeTestViewControllerEnum
        XCTAssertEqual(result, .wrongButtonTap,"should handle wrong button tap")
    }
}

extension TakeTestViewController{
    func mockDoneBarButtonTapHandler(){
        objc_setAssociatedObject(self, &key, TakeTestViewControllerEnum.doneBarButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func mockShowAnswerTapHandler(){
        objc_setAssociatedObject(self, &key, TakeTestViewControllerEnum.showAnswerButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func mockCorrectTapHandler(){
        objc_setAssociatedObject(self, &key, TakeTestViewControllerEnum.correctButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func mockWrongTapHandler(){
        objc_setAssociatedObject(self, &key, TakeTestViewControllerEnum.wrongButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

