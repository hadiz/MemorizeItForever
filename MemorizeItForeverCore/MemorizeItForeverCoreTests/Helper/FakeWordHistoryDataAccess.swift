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
        return 0
    }
    func saveOrUpdate(_ wordHistoryModel: WordHistoryModel) throws {
        
    }
}
