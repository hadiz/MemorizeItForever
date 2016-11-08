//
//  AddNewPhraseViewControllerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class AddPhraseViewControllerTests: XCTestCase {
    
    var addPhraseViewController: AddPhraseViewController!
    
    override func setUp() {
        super.setUp()
        addPhraseViewController = AddPhraseViewController()
        _ = addPhraseViewController.view
    }
    
    override func tearDown() {
        objc_removeAssociatedObjects(addPhraseViewController)
        super.tearDown()
    }
    
    func testAddPhraseViewControllerHasTitle(){
        addPhraseViewController.viewDidLoad()
        XCTAssertEqual(addPhraseViewController.title,"Add Phrase","AddPhraseViewController should have a title")
    }
    
    func testHasDoneBarButton() {
        addPhraseViewController.viewDidLoad()
        let doneBarButton = addPhraseViewController.navigationItem.leftBarButtonItem
        XCTAssertEqual(doneBarButton?.title, "Done","View controller should have a left bar button titled 'Done'")
    }
    
    func testDoneBarButtonTapHandled() {
        
        let originalSelector = #selector(AddPhraseViewController.doneBarButtonTapHandler)
        let swizzledSelector = #selector(AddPhraseViewController.mockDoneBarButtonTapHandler)
        
        Helper.methodSwizzling(AddPhraseViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        addPhraseViewController.viewDidLoad()
        let doneBarButton = addPhraseViewController.navigationItem.leftBarButtonItem
        UIApplication.shared.sendAction(doneBarButton!.action!, to: doneBarButton!.target, from: self, for: nil)
        let result = objc_getAssociatedObject(addPhraseViewController, &key) as! AddPhraseViewControllerEnum
        XCTAssertEqual(result, .doneBarButtonTap,"should handle done bar button item tap")
    }
    
    func testHasNextBarButton() {
        addPhraseViewController.viewDidLoad()
        let nextBarButton = addPhraseViewController.navigationItem.rightBarButtonItem
        XCTAssertEqual(nextBarButton?.title, "Next","View controller should have a left bar button titled 'Done'")
    }
    
    func testNextBarButtonTapHandled() {
        
        let originalSelector = #selector(AddPhraseViewController.nextBarButtonTapHandler)
        let swizzledSelector = #selector(AddPhraseViewController.mockNextBarButtonTapHandler)
        
        Helper.methodSwizzling(AddPhraseViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        addPhraseViewController.viewDidLoad()
        let nextBarButton = addPhraseViewController.navigationItem.rightBarButtonItem
        UIApplication.shared.sendAction(nextBarButton!.action!, to: nextBarButton!.target, from: self, for: nil)
        let result = objc_getAssociatedObject(addPhraseViewController, &key) as! AddPhraseViewControllerEnum
        XCTAssertEqual(result, .nextBarButtonTap,"should handle next bar button item tap")
    }
    
    func testHasLabelDesc() {
        addPhraseViewController.viewDidLoad()
        XCTAssertEqual(addPhraseViewController.desc.text, "Write the Phrase here","View controller should have a label description")
    }
    
    func testHasPharseTextView() {
        addPhraseViewController.viewDidLoad()
        addPhraseViewController.phrase.text = "Book"
        XCTAssertEqual(addPhraseViewController.phrase.text, "Book","View controller should have a phrase text view")
    }
}

extension AddPhraseViewController{
    func mockDoneBarButtonTapHandler(){
        objc_setAssociatedObject(self, &key, AddPhraseViewControllerEnum.doneBarButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func mockNextBarButtonTapHandler(){
        objc_setAssociatedObject(self, &key, AddPhraseViewControllerEnum.nextBarButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
