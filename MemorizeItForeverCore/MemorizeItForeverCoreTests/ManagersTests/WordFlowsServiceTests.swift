//
//  WordFlowsTests.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/23/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class WordFlowsTests: XCTestCase {
    var wordFlowService: WordFlowServiceProtocol!
    var wordDataAccess: WordDataAccessProtocol!
    var wordInProgressDataAccess: WordInProgressDataAccessProtocol!
    var wordHistoryDataAccess: WordHistoryDataAccessProtocol!
    var setModel: SetModel!
    
    override func setUp() {
        super.setUp()
        wordDataAccess = FakeWordDataAccess()
        wordInProgressDataAccess = FakeWordInProgressDataAccess()
        wordHistoryDataAccess = FakeWordHistoryDataAccess()
        wordFlowService = WordFlowService(wordDataAccess: wordDataAccess, wordInProgressDataAccess: wordInProgressDataAccess, wordHistoryDataAccess: wordHistoryDataAccess)
        setModel = SetModel()
        setModel.setId = UUID()
        setModel.name = "Default"
    }
    
    override func tearDown() {
        wordDataAccess = nil
        wordFlowService = nil
        wordInProgressDataAccess = nil
        wordHistoryDataAccess = nil
        setModel = nil
        super.tearDown()
    }
    
    func testPutWordInPreColumn(){
        let word  = newWordModel()
        do{
            try wordFlowService.putWordInPreColumn(word)
        }
        catch{
            XCTFail("should save wordInProgress")
        }
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 0 ,"shoud put word in 0 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set tomorrow")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordId, word.wordId ,"shoud set word in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testAnswerCorrectlyPreColumn(){
        let word = newWordModel()
        let wordInprogress = WordInProgressModel(word: word, date: Date().addingTimeInterval(1 * 24 * 60 * 60), column: 0, wordInProgressId: UUID())
        
        wordFlowService.answerCorrectly(wordInprogress)
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 1 ,"shoud put word in 1 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(2 * 24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set 2 days later")
        }
        else{
            XCTFail("should progress word")
        }
        
        if let wordId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordId, word.wordId ,"shoud word not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordInProgressId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdInProgressKey) as? UUID{
            XCTAssertEqual(wordInProgressId, wordInprogress.wordInProgressId ,"shoud wordInprogressId not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testAnswerCorrectlyFirstColumn(){
        let word = newWordModel()
        let wordInprogress = WordInProgressModel(word: word, date: Date().addingTimeInterval(2 * 24 * 60 * 60), column: 1, wordInProgressId: UUID())
        
        wordFlowService.answerCorrectly(wordInprogress)
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 2 ,"shoud put word in 2 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(4 * 24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set 4 days later")
        }
        else{
            XCTFail("should progress word")
        }
        
        if let wordId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordId, word.wordId ,"shoud word not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordInProgressId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdInProgressKey) as? UUID{
            XCTAssertEqual(wordInProgressId, wordInprogress.wordInProgressId ,"shoud wordInprogressId not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testAnswerCorrectlySecondColumn(){
        let word = newWordModel()
        let wordInprogress = WordInProgressModel(word: word, date: Date().addingTimeInterval(4 * 24 * 60 * 60), column: 2, wordInProgressId: UUID())
        
        wordFlowService.answerCorrectly(wordInprogress)
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 3 ,"shoud put word in 3 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(8 * 24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set 8 days later")
        }
        else{
            XCTFail("should progress word")
        }
        
        if let wordId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordId, word.wordId ,"shoud word not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordInProgressId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdInProgressKey) as? UUID{
            XCTAssertEqual(wordInProgressId, wordInprogress.wordInProgressId ,"shoud wordInprogressId not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testAnswerCorrectlyThirdColumn(){
        let word = newWordModel()
        let wordInprogress = WordInProgressModel(word: word, date: Date().addingTimeInterval(8 * 24 * 60 * 60), column: 3, wordInProgressId: UUID())
        
        wordFlowService.answerCorrectly(wordInprogress)
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 4 ,"shoud put word in 4 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(16 * 24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set 8 days later")
        }
        else{
            XCTFail("should progress word")
        }
        
        if let wordId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordId, word.wordId ,"shoud word not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordInProgressId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdInProgressKey) as? UUID{
            XCTAssertEqual(wordInProgressId, wordInprogress.wordInProgressId ,"shoud wordInprogressId not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testAnswerCorrectlyFourthColumn(){
        let word = newWordModel()
        let wordInprogress = WordInProgressModel(word: word, date: Date().addingTimeInterval(16 * 24 * 60 * 60), column: 4, wordInProgressId: UUID())
        
        wordFlowService.answerCorrectly(wordInprogress)
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 5 ,"shoud put word in 5 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(32 * 24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set 8 days later")
        }
        else{
            XCTFail("should progress word")
        }
        
        if let wordId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordId, word.wordId ,"shoud word not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordInProgressId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdInProgressKey) as? UUID{
            XCTAssertEqual(wordInProgressId, wordInprogress.wordInProgressId ,"shoud wordInprogressId not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testAnswerCorrectlyFifthColumn(){
        let word = newWordModel()
        let wordInprogress = WordInProgressModel(word: word, date: Date().addingTimeInterval(32 * 24 * 60 * 60), column: 5, wordInProgressId: UUID())
        
        wordFlowService.answerCorrectly(wordInprogress)
        
        if let status = objc_getAssociatedObject(wordDataAccess, &statusKey) as? Int16{
            XCTAssertEqual(status, WordStatus.done.rawValue ,"shoud set word status as Done")
        }
        else{
            XCTFail("shoud set word status as Done")
        }
        
        if let enumResult = objc_getAssociatedObject(wordInProgressDataAccess, &resultKey) as? FakeWordInProgressDataAccessEnum{
            XCTAssertEqual(enumResult, .delete ,"should delete wordInProgress")
        }
        else{
            XCTFail("should delete wordInProgress")
        }
    }
    
    func testAnswerWronglyInMiddleColumns(){
        let word = newWordModel()
        let wordInprogress = WordInProgressModel(word: word, date: Date().addingTimeInterval(8 * 24 * 60 * 60), column: 3, wordInProgressId: UUID())
        
        wordFlowService.answerWrongly(wordInprogress)
        
        if let columnNO = objc_getAssociatedObject(wordHistoryDataAccess, &columnNoKey) as? Int16{
            XCTAssertEqual(columnNO, 3 ,"shoud set correct column No")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordId = objc_getAssociatedObject(wordHistoryDataAccess, &wordIdKey) as? UUID{
            XCTAssertEqual(wordId, word.wordId ,"shoud word not changed in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(1 * 24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set 1 days later")
        }
        else{
            XCTFail("should progress word")
        }
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 0 ,"shoud put word in 0 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testAddDayExtension(){
        let now = Date(timeIntervalSinceReferenceDate: 0)
        let tomorrow = Date(timeIntervalSinceReferenceDate: 60*60*24)
        XCTAssertEqual(now.addDay(1), tomorrow, "AddDay extension should work fine")
    }
    
    func testFetchWordsForPuttingInPreColumn(){
        UserDefaults.standard.setValue(10, forKey: Settings.newWordsCount.rawValue)
        UserDefaults.standard.setValue(setModel.toDic(), forKey: Settings.defaultSet.rawValue)
        do{
            try wordFlowService.fetchNewWordsToPutInPreColumn()
        }
        catch{
            XCTFail("should be able to fetch words in pre column")
        }
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 0 ,"shoud put word in 0 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud set tomorrow")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let wordId = objc_getAssociatedObject(wordInProgressDataAccess, &wordIdKey) as? UUID{
            XCTAssertNotNil(wordId ,"shoud set word in wordInprogress")
        }
        else{
            XCTFail("should save wordInProgress")
        }
        
        if let status = objc_getAssociatedObject(wordDataAccess, &statusKey) as? Int16{
            XCTAssertEqual(status, WordStatus.inProgress.rawValue ,"shoud status word set to InProgress")
        }
        else{
            XCTFail("shou set word status as InProgress")
        }
    }
    
    func testDoNotFetchWordsForPuttingInPreColumnIfAlreadyFetched(){
        UserDefaults.standard.setValue(setModel.toDic(), forKey: Settings.defaultSet.rawValue)
        let word = newWordModel()
        objc_setAssociatedObject(wordDataAccess, &wordKey, word, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        do{
            try wordFlowService.fetchNewWordsToPutInPreColumn()
        }
        catch{
            XCTFail("should be able to fetch words in pre column")
        }
        let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16
        XCTAssertNil(column, "Should not put progress in column 0")
    }
    
    func testShouldWordsForPuttingInPreColumnIfAnsweredAlreadyWrongly(){
        UserDefaults.standard.setValue(setModel.toDic(), forKey: Settings.defaultSet.rawValue)
        let word = newWordModel()
        objc_setAssociatedObject(wordDataAccess, &wordKey, word, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(wordHistoryDataAccess, &wordHistoryCountKey, 1, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        do{
            try wordFlowService.fetchNewWordsToPutInPreColumn()
        }
        catch{
            XCTFail("should be able to fetch words in pre column")
        }
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 0 ,"shoud put word in 0 column")
        }
        else{
            XCTFail("should save wordInProgress")
        }
    }
    
    func testFetchWordsForReview(){
        UserDefaults.standard.setValue(setModel.toDic(), forKey: Settings.defaultSet.rawValue)
        do{
            let words = try wordFlowService.fetchWordsForReview()
            XCTAssertGreaterThanOrEqual(words.count, 0, "should return words for review")
        }
        catch{
            XCTFail("Should be able to fetch words for review")
        }
        
        if let column = objc_getAssociatedObject(wordInProgressDataAccess, &columnKey) as? Int16{
            XCTAssertEqual(column, 0 ,"shoud filter with 0 column")
        }
        else{
            XCTFail("shoud filter with 0 column")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().addingTimeInterval(24 * 60 * 60).getDate()!), ComparisonResult.orderedSame ,"shoud filter with tomorrow date")
        }
        else{
            XCTFail("shoud filter with tomorrow date")
        }
        
    }
    
    func testFetchWordsToExamine(){
        
        // it should fetch words for today and all words that belongs to past
        UserDefaults.standard.setValue(setModel.toDic(), forKey: Settings.defaultSet.rawValue)
        do{
            let wordInProgressLists = try wordFlowService.fetchWordsToExamin()
            XCTAssertEqual(wordInProgressLists[0].column, 3,"should sort wordInprogress list")
        }
        catch{
            XCTFail("Should be able to fetch words for examin")
        }
        
        if let date = objc_getAssociatedObject(wordInProgressDataAccess, &dateKey) as? Date{
            XCTAssertEqual(date.getDate()!.compare(Date().getDate()!), ComparisonResult.orderedSame ,"shoud filter with today date")
        }
        else{
            XCTFail("shoud filter with today date")
        }
    
    }
    
    private func newWordModel() -> WordModel{
        var wordModel = WordModel()
        wordModel.wordId = UUID()
        wordModel.phrase = "Livre"
        wordModel.meaning = "Book"
        wordModel.order = 1
        wordModel.setId = UUID()
        wordModel.status =  WordStatus.notStarted.rawValue
        return wordModel
    }
}
