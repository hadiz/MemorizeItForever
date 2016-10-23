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

class FakeWordDataAccess: WordDataAccess {
    
    override init(context initialContext: ManagedObjectContextProtocol){
        super.init(context: initialContext)
    }
    
    convenience init(){
        self.init(context: InMemoryManagedObjectContext())
    }
}
