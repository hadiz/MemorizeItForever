//
//  MockWordManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore

class MockWordManager: WordManagerProtocol {
    public func fetchWords(phrase: String, status: WordStatus, fetchLimit: Int, fetchOffset: Int) -> [WordModel] {
        return []
    }

    func save(_ phrase: String, meaninig: String, setId: UUID) throws {
         objc_setAssociatedObject(self, &key, AddPhraseViewControllerEnum.saveWord, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func edit(_ wordModel: WordModel, phrase: String, meaninig: String) {
        
    }
    
    func delete(_ wordModel: WordModel) -> Bool {
        return false
    }
}
