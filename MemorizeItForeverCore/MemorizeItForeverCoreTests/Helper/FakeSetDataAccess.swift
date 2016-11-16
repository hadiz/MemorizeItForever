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
        return 0
    }
    
    func save(_ setModel: SetModel) throws {
        
    }
    
    func edit(_ setModel: SetModel) throws {
        
    }
    
    func delete(_ setModel: SetModel) throws {
        
    }
    
    func fetchAll() throws -> [SetModel] {
       return []
    }
}

