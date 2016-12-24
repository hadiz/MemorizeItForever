//
//  MockSetService.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/13/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore

class MockSetService: SetServiceProtocol {
    func delete(_ setModel: SetModel) -> Bool {
        return false
    }
    
    func get() -> [SetModel] {
        return []
    }
    
    func createDefaultSet() {
        
    }
    
    func setUserDefaultSet() {
        
    }
    
    func setUserDefaultSet(force: Bool){
        
    }
    
    func save(_ setName: String) {
        
    }
    
    func edit(_ setModel: SetModel, setName: String) {
        
    }
    func changeSet(_ setModel: SetModel){
        
    }
}
