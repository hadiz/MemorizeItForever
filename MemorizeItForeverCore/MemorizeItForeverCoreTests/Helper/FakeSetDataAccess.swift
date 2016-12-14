//
//  FakeSetDataAccess.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/22/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class FakeSetDataAccess: SetDataAccessProtocol {
    
    func fetchSetNumber() throws -> Int {
        if let result = objc_getAssociatedObject(self, &setNumberKey) as? Int{
            return result
        }
        fatalError("number of set was not supplied")
    }
    
    func save(_ setModel: SetModel) throws {
        guard let name = setModel.name, !name.trim().isEmpty else {
            return
        }
        objc_setAssociatedObject(self, &resultKey, FakeSetDataAccessEnum.save, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func edit(_ setModel: SetModel) throws {
        objc_setAssociatedObject(self, &setNameKey, setModel.name, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &setIdKey, setModel.setId, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func delete(_ setModel: SetModel) throws {
        objc_setAssociatedObject(self, &resultKey, FakeSetDataAccessEnum.delete, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func fetchAll() throws -> [SetModel] {
       return []
    }
}
