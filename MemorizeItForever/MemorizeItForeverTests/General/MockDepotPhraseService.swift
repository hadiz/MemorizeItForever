//
//  MockDepotPhraseService.swift
//  MemorizeItForeverTests
//
//  Created by Hadi Zamani on 11/21/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore

final class MockDepotPhraseService: DepotPhraseServiceProtocol {
    func get() -> [DepotPhraseModel] {
        return []
    }
    
    func save(_ phrase: String) {
        
    }
    
    func save(_ phrases: [String]) {
        
    }
    
    func delete(_ model: DepotPhraseModel) -> Bool {
        return false
    }
}
