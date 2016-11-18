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
    func NewSetModel(initialContext: ManagedObjectContextProtocol) -> SetModel?{
        let dataAccess = MockGenericDataAccess<SetEntity>(context: initialContext)
        let setDataAccess = SetDataAccess(genericDataAccess: dataAccess)
        
        
        var setModel = SetModel()
        setModel.name = "Default"
        do{
            try setDataAccess.save(setModel)
            return try setDataAccess.fetchAll()[0]
        }
        catch{
            return nil
        }
    }
    
    func NewWordModel(_ initialContext: ManagedObjectContextProtocol) -> WordModel?{
        let dataAccess = MockGenericDataAccess<SetEntity>(context: initialContext)
        let genericDataAccess = MockGenericDataAccess<WordEntity>(context: initialContext)
        let wordDataAccess = WordDataAccess(genericDataAccess: genericDataAccess, setDataAccess: dataAccess)
        var wordModel = WordModel()
        wordModel.meaning = "Book"
        wordModel.phrase = "Livre"
        wordModel.setId = NewSetModel(initialContext: initialContext)?.setId
        do{
            try wordDataAccess.save(wordModel)
            let words = try wordDataAccess.fetchAll()
            return words[words.count - 1]
        }
        catch{
            return nil
        }
        
    }
}
