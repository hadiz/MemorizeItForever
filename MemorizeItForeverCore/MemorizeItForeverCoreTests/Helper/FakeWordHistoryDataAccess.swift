//
//  FakeWordHistoryDataAccess.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/23/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class FakeWordHistoryDataAccess: WordHistoryDataAccessProtocol {
    func fetchByWordId(_ wordHistoryModel: WordHistoryModel) throws -> [WordHistoryModel] {
        return []
    }
    func countByWordId(_ wordHistoryModel: WordHistoryModel) throws -> Int {
        if let result = objc_getAssociatedObject(self, &wordHistoryCountKey) as? Int{
            return result
        }
        return 0
    }
    func saveOrUpdate(_ wordHistoryModel: WordHistoryModel) throws {
        objc_setAssociatedObject(self, &columnNoKey, wordHistoryModel.columnNo, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &wordIdKey, wordHistoryModel.word?.wordId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
