//
//  MockValidator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/15/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

@testable import MemorizeItForever

class MockValidator: ValidatorProtocol {
    func validate(_ validatable: ValidatableProtocol, errorMessage: String, by validation: (ValidatableProtocol) -> Bool) -> Bool {
       let result = validation(validatable)
        
        if result{
            validatable.clearError()
        }
        else{
            validatable.applyError()
        }
        return result
    }
    
    func clear(validatable: ValidatableProtocol) {
        validatable.clearError()
    }
}
