//
//  FakeWordInProgressDataAccess.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/23/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class FakeWordInProgressDataAccess: WordInProgressDataAccessProtocol {
    func save(_ wordInProgressModel: WordInProgressModel) throws {
         objc_setAssociatedObject(self, &columnKey, wordInProgressModel.column, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &dateKey, wordInProgressModel.date, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &wordIdKey, wordInProgressModel.word?.wordId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func edit(_ wordInProgressModel: WordInProgressModel) throws {
        objc_setAssociatedObject(self, &columnKey, wordInProgressModel.column, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &dateKey, wordInProgressModel.date, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &wordIdKey, wordInProgressModel.word?.wordId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &wordIdInProgressKey, wordInProgressModel.wordInProgressId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func delete(_ wordInProgressModel: WordInProgressModel) throws {
         objc_setAssociatedObject(self, &resultKey, FakeWordInProgressDataAccessEnum.delete, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func fetchAll() throws -> [WordInProgressModel] {
        return []
    }
    func fetchByWordId(_ wordInProgressModel: WordInProgressModel) throws -> WordInProgressModel? {
        let wordInProgress = WordInProgressModel(word: nil, date: Date(), column: 0, wordInProgressId: UUID())
        return wordInProgress
    }
    func fetchByDateAndOlder(_ wordInProgressModel: WordInProgressModel, set: SetModel) throws -> [WordInProgressModel] {
        objc_setAssociatedObject(self, &dateKey, wordInProgressModel.date, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        var word = WordModel()
        word.wordId = UUID()
        word.phrase = "Livre"
        word.meaning = "Book"
        word.order = 1
        word.setId = UUID()
        word.status =  WordStatus.notStarted.rawValue
        let wordInProgress = WordInProgressModel(word: word, date: Date(), column: 3, wordInProgressId: UUID())
        let wordInProgress1 = WordInProgressModel(word: word, date: Date(), column: 1, wordInProgressId: UUID())
        return [wordInProgress1,wordInProgress]
    }
    func fetchByDateAndColumn(_ wordInProgressModel: WordInProgressModel, set: SetModel) throws -> [WordInProgressModel] {
        objc_setAssociatedObject(self, &columnKey, wordInProgressModel.column, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &dateKey, wordInProgressModel.date, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        var word = WordModel()
        word.wordId = UUID()
        word.phrase = "Livre"
        word.meaning = "Book"
        word.order = 1
        word.setId = UUID()
        word.status =  WordStatus.notStarted.rawValue
        let wordInProgress = WordInProgressModel(word: word, date: Date(), column: 0, wordInProgressId: UUID())
        return [wordInProgress]
    }
}
