//
//  FakeWordDataAccess.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/22/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class FakeWordDataAccess: WordDataAccessProtocol{
    
    public func fetchWords(phrase: String, status: WordStatus, fetchLimit: Int) throws -> [WordModel] {
        return [WordModel(wordId: UUID(), phrase: phrase, meaning: "Book", order: 1, setId: UUID(), status:  status.rawValue)]
    }

    public func fetchWords(status: WordStatus, fetchLimit: Int) throws -> [WordModel] {
        return [WordModel(wordId: UUID(), phrase: "Livre", meaning: "Book", order: 1, setId: UUID(), status:  status.rawValue)]
    }

    func save(_ wordModel: WordModel) throws {
        guard let phrase = wordModel.phrase,
              let meaning = wordModel.meaning,
              let _ = wordModel.setId,
              !phrase.trim().isEmpty,
              !meaning.trim().isEmpty else {
            return
        }
        objc_setAssociatedObject(self, &resultKey, FakeSetDataAccessEnum.save, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func edit(_ wordModel: WordModel) throws {
        objc_setAssociatedObject(self, &phraseKey, wordModel.phrase, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &meaningKey, wordModel.meaning, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &statusKey, wordModel.status, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &orderKey, wordModel.order, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &wordIdKey, wordModel.wordId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &setIdKey, wordModel.setId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func delete(_ wordModel: WordModel) throws {
        objc_setAssociatedObject(self, &resultKey, FakeSetDataAccessEnum.delete, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func fetchAll(fetchLimit: Int?) throws -> [WordModel] {
        return []
    }
    
    func fetchLast(_ wordStatus: WordStatus) throws -> WordModel? {
        if let result = objc_getAssociatedObject(self, &wordKey) as? WordModel{
            return result
        }
        return nil
    }
    func fetchWithNotStartedStatus(fetchLimit: Int) throws -> [WordModel] {
        return [WordModel(wordId: UUID(), phrase: "Livre", meaning: "Book", order: 1, setId: UUID(), status:  WordStatus.notStarted.rawValue)]
    }
}
