//
//  ApplySettingsTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import UIKit
import MemorizeItForeverCore
@testable import MemorizeItForever

class ApplySettingsTests: XCTestCase {
    
    var mockAppDelegate: MockAppDelegate!
    var uiApplication: UIApplication!
    
    
    override func setUp() {
        super.setUp()
        uiApplication = UIApplication.shared
        mockAppDelegate = MockAppDelegate()
        UIApplication.shared.delegate = mockAppDelegate
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Settings.wordSwitching.rawValue)
        defaults.removeObject(forKey: Settings.newWordsCount.rawValue)
        defaults.removeObject(forKey: Settings.judgeMyself.rawValue)
        defaults.removeObject(forKey: Settings.phraseColor.rawValue)
        defaults.removeObject(forKey: Settings.meaningColor.rawValue)
    }
    
    override func tearDown() {
       mockAppDelegate = nil
        uiApplication = nil
        super.tearDown()
    }
    
    func testWordSwitchingObjectShouldNotExists() {
        let defaults = UserDefaults.standard
        XCTAssertFalse(defaults.bool(forKey: Settings.wordSwitching.rawValue), "User defaults should not have word switching option")
    }
    func testWordsCountObjectShouldNotExists() {
        let defaults = UserDefaults.standard
        XCTAssertFalse(defaults.bool(forKey: Settings.newWordsCount.rawValue), "User defaults should not have words count")
    }
    func testJudgeMyselfObjectShouldNotExists() {
        let defaults = UserDefaults.standard
        XCTAssertFalse(defaults.bool(forKey: Settings.judgeMyself.rawValue), "User defaults should not have judge myself option")
    }
    func testExpressionColorObjectShouldNotExists() {
        let defaults = UserDefaults.standard
        XCTAssertFalse(defaults.bool(forKey: Settings.phraseColor.rawValue), "User defaults should not have expression color option")
    }
    func testMeaningColorObjectShouldNotExists() {
        let defaults = UserDefaults.standard
        XCTAssertFalse(defaults.bool(forKey: Settings.meaningColor.rawValue), "User defaults should not have meaning color option")
    }
    func testWordSwitchingObjectShouldExistsAfterApplicationLunched() {
        let defaults = UserDefaults.standard
        _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(defaults.bool(forKey: Settings.wordSwitching.rawValue), "Word switching option in User defaults should have value")
    }
    func testWordsCountObjectShouldExistsAfterApplicationLunched() {
        let defaults = UserDefaults.standard
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(defaults.bool(forKey: Settings.newWordsCount.rawValue), "Words count option in User defaults should have value")
    }
    func testJudgeMyselfObjectShouldExistsAfterApplicationLunched() {
        let defaults = UserDefaults.standard
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertTrue(defaults.bool(forKey: Settings.judgeMyself.rawValue), "Judge myself option in User defaults should have value")
    }
    func testPhraseColorObjectShouldExistsAfterApplicationLunched() {
        let defaults = UserDefaults.standard
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.colorForKey(Settings.phraseColor.rawValue), "Phrase Color option in User defaults should have value")
    }
    func testMeaningColorObjectShouldExistsAfterApplicationLunched() {
        let defaults = UserDefaults.standard
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.colorForKey(Settings.meaningColor.rawValue), "Meaning Color option in User defaults should have value")
    }
    func testWordSwitchingShouldHaveUsersValue() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: Settings.wordSwitching.rawValue)
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.object(forKey: Settings.wordSwitching.rawValue) as? Bool, "Word switching object should have boolean value")
        
        XCTAssertFalse(defaults.object(forKey: Settings.wordSwitching.rawValue) as! Bool, "Word switching object should have the user setting value")
    }
    func testWordsCountShouldHaveUsersValue() {
        let defaults = UserDefaults.standard
        defaults.set(20, forKey: Settings.newWordsCount.rawValue)
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.object(forKey: Settings.newWordsCount.rawValue) as? Int, "Words count object should have integer value")
        XCTAssertEqual(defaults.object(forKey: Settings.newWordsCount.rawValue) as? Int, 20,  "Words count object should have the user setting value")
    }
    func testJudgeMyselfShouldHaveUsersValue() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: Settings.judgeMyself.rawValue)
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.object(forKey: Settings.judgeMyself.rawValue) as? Bool, "Judge myself count object should have boolean value")
        XCTAssertFalse(defaults.object(forKey: Settings.judgeMyself.rawValue) as! Bool, "Judge myself object should have the user setting value")
    }
    func testPhraseColorShouldHaveUsersValue() {
        let defaults = UserDefaults.standard
        let color = UIColor.white
        defaults.setColor(color, forKey: Settings.phraseColor.rawValue)
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.object(forKey: Settings.phraseColor.rawValue), "phrase Color object should have UIColor value")
        XCTAssertEqual(defaults.colorForKey(Settings.phraseColor.rawValue), color,  "phrase Color object should have the user setting value")
    }
    
    func testMeaningColorShouldHaveUsersValue() {
        let defaults = UserDefaults.standard
        let color = UIColor.blue
        defaults.setColor(color, forKey: Settings.meaningColor.rawValue)
        _ = _ = mockAppDelegate.application(uiApplication, didFinishLaunchingWithOptions: nil)
        
        XCTAssertNotNil(defaults.object(forKey: Settings.meaningColor.rawValue), "Meaning Color object should have UIColor value")
        XCTAssertEqual(defaults.colorForKey(Settings.meaningColor.rawValue), color,  "Meaning Color object should have the user setting value")
    }
}
