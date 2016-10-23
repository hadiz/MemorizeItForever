//
//  TestFlowHelper.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/22/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class TestFlowHelper {
    func NewSetModel(_ initialContext: ManagedObjectContextProtocol) -> SetModel?{
        let fakeSetDataAccess = FakeSetDataAccess(context: initialContext)
        var setModel = SetModel()
        setModel.name = "Default"
        do{
            try fakeSetDataAccess.save(setModel)
            return try fakeSetDataAccess.fetchAll()[0]
        }
        catch{
            return nil
        }
    }
    
    func NewWordModel(_ initialContext: ManagedObjectContextProtocol) -> WordModel?{
        let fakeWordDataAccess = FakeWordDataAccess(context: initialContext)
        var wordModel = WordModel()
        wordModel.meaning = "Book"
        wordModel.phrase = "Livre"
        wordModel.setId = NewSetModel(initialContext)?.setId
        do{
            try fakeWordDataAccess.save(wordModel)
            let words = try fakeWordDataAccess.fetchAll()
            return words[words.count - 1]
        }
        catch{
            return nil
        }
        
    }
}
