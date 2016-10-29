//
//  ReviewPhraseViewControllerTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/25/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class ReviewPhraseViewControllerTests: XCTestCase {
    
    var reviewPhraseViewController: ReviewPhraseViewController?
    
    override func setUp() {
        super.setUp()
        reviewPhraseViewController = ReviewPhraseViewController()
    }
    
    override func tearDown() {
        reviewPhraseViewController = nil
        super.tearDown()
    }
    
    func testHasTitle() {
        reviewPhraseViewController?.viewDidLoad()
        XCTAssertEqual(reviewPhraseViewController?.title, "Review Phrases","View controller should have a title")
    }
    
    func testHasPreviousbarButton() {
        reviewPhraseViewController?.viewDidLoad()
        let previousBarButton = reviewPhraseViewController?.navigationItem.leftBarButtonItem
        XCTAssertEqual(previousBarButton?.title, "Previous","View controller should have a left bar button titled 'Previous'")
    }
    
    func testPreviousBarButtonTapHandled() {
        
        let originalSelector = #selector(ReviewPhraseViewController.previousbarButtonTapHandler)
        let swizzledSelector = #selector(ReviewPhraseViewController.mockPreviousbarButtonTapHandler)

        Helper.methodSwizzling(ReviewPhraseViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        reviewPhraseViewController?.viewDidLoad()
        let previousBarButton = reviewPhraseViewController?.navigationItem.leftBarButtonItem
        UIApplication.shared.sendAction(previousBarButton!.action!, to: previousBarButton!.target, from: self, for: nil)
        let result = objc_getAssociatedObject(reviewPhraseViewController, &key) as! ReviewPhraseViewControllerEnum
        XCTAssertEqual(result, .previousBarButtonTap,"should handle previous bar button item tap")
    }
    
    func testHasNextBarButton() {
        reviewPhraseViewController?.viewDidLoad()
        let nextBarButton = reviewPhraseViewController?.navigationItem.rightBarButtonItem
        XCTAssertEqual(nextBarButton?.title, "Next","View controller should have a right bar button titled 'Next'")
    }

    func testNextBarButtonTapHandled() {
        
        let originalSelector = #selector(ReviewPhraseViewController.nextbarButtonTapHandler)
        let swizzledSelector = #selector(ReviewPhraseViewController.mockNextbarButtonTapHandler)
        
        Helper.methodSwizzling(ReviewPhraseViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        reviewPhraseViewController?.viewDidLoad()
        let nextBarButton = reviewPhraseViewController?.navigationItem.rightBarButtonItem
        UIApplication.shared.sendAction(nextBarButton!.action!, to: nextBarButton!.target, from: self, for: nil)
        let result = objc_getAssociatedObject(reviewPhraseViewController, &key) as! ReviewPhraseViewControllerEnum
        XCTAssertEqual(result, .nextBarButtonTap ,"should handle next bar button item tap")
    }
    
    func testHasPhraseLabel() {
        reviewPhraseViewController?.viewDidLoad()
        reviewPhraseViewController?.phrase?.text = "Book"
        XCTAssertEqual(reviewPhraseViewController?.phrase?.text, "Book","View controller should have a phrase label")
    }
    
    func testHasMeaningLabel() {
        reviewPhraseViewController?.viewDidLoad()
        reviewPhraseViewController?.meaning?.text = "Livre"
        XCTAssertEqual(reviewPhraseViewController?.meaning?.text, "Livre","View controller should have a phrase label")
    }
    
    func testHasFlipButton() {
        reviewPhraseViewController?.viewDidLoad()
        XCTAssertEqual(reviewPhraseViewController?.flip?.titleLabel?.text, "Flip!","View controller should have a flip button")
    }
    
    func testFlipButtonTapHandled() {
        
        let originalSelector = #selector(ReviewPhraseViewController.flipTapHandler)
        let swizzledSelector = #selector(ReviewPhraseViewController.mockFlipTapHandler)
        
        Helper.methodSwizzling(ReviewPhraseViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        reviewPhraseViewController?.viewDidLoad()
        reviewPhraseViewController?.flip?.sendActions(for: .touchUpInside)
        let result = objc_getAssociatedObject(reviewPhraseViewController, &key) as! ReviewPhraseViewControllerEnum
        XCTAssertEqual(result, .flipButtonTap ,"should handle flip button tap")
    }
    
    func testHasDoneButton() {
        reviewPhraseViewController?.viewDidLoad()
        XCTAssertEqual(reviewPhraseViewController?.done?.titleLabel?.text, "Done","View controller should have a done button")
    }
    
    func testDoneButtonTapHandled() {
        
        let originalSelector = #selector(ReviewPhraseViewController.doneTapHandler)
        let swizzledSelector = #selector(ReviewPhraseViewController.mockDoneTapHandler)
        
        Helper.methodSwizzling(ReviewPhraseViewController.self, origin: originalSelector, swizzled: swizzledSelector)
        
        reviewPhraseViewController?.viewDidLoad()
        reviewPhraseViewController?.done?.sendActions(for: .touchUpInside)
        let result = objc_getAssociatedObject(reviewPhraseViewController, &key) as! ReviewPhraseViewControllerEnum
        XCTAssertEqual(result, .doneButtonTap ,"should handle done button tap")
    }

}
var key = 0
extension ReviewPhraseViewController{
    func mockPreviousbarButtonTapHandler(){
        objc_setAssociatedObject(self, &key, ReviewPhraseViewControllerEnum.previousBarButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func mockNextbarButtonTapHandler(){
        objc_setAssociatedObject(self, &key, ReviewPhraseViewControllerEnum.nextBarButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func mockFlipTapHandler(){
        objc_setAssociatedObject(self, &key, ReviewPhraseViewControllerEnum.flipButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func mockDoneTapHandler(){
        objc_setAssociatedObject(self, &key, ReviewPhraseViewControllerEnum.doneButtonTap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
