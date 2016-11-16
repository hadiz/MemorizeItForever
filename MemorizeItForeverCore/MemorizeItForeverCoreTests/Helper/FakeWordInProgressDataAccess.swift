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
        
    }
    func edit(_ wordInProgressModel: WordInProgressModel) throws {
        
    }
    
    func delete(_ wordInProgressModel: WordInProgressModel) throws {
        
    }
    func fetchByWordId(_ wordInProgressModel: WordInProgressModel) throws -> WordInProgressModel? {
        return nil
    }
    func fetchByDateAndOlder(_ wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel] {
        return []
    }
    func fetchByDateAndColumn(_ wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel] {
        return []
    }
}
