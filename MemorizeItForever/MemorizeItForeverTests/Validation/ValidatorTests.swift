//
//  ValidatorTests.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/14/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import XCTest
@testable import MemorizeItForever

class ValidatorTests: XCTestCase {
    
    var validator: ValidatorProtocol!
    var validatable: ValidatableProtocol!
    
    override func setUp() {
        super.setUp()
        validator = Validator()
        validatable = MockValidatable()
    }
    
    override func tearDown() {
        validator = nil
        validatable = nil
        super.tearDown()
    }
    
    func testValidateMethodShouldReturnFalseIfValidationFailed() {
        
        let result = validator.validate(validatable, errorMessage: "Should not empty"){_ in
            return false
        }
        
        XCTAssertFalse(result,"Validate method should return false if validation failed")
    }
    
    func testValidateMethodShouldReturnTrueIfValidationSucceed() {
        
        let result = validator.validate(validatable, errorMessage: "Should not empty"){_ in 
            return true
        }
        
        XCTAssertTrue(result,"Validate method should return true if validation succeed")
    }
    
    func testValidateMethodShouldCallApplyErrorIfValidationFailed() {
        
        _ = validator.validate(validatable, errorMessage: "Should not empty"){_ in 
            return false
        }
        
        let result = objc_getAssociatedObject(validatable, &key) as! Bool
        XCTAssertEqual(result, false, "Validate method should call applyError if validation failed")
    }
    
    func testValidateMethodShouldCallClearErrorIfValidationSucceed() {
        
        _ = validator.validate(validatable, errorMessage: "Should not empty"){_ in 
            return true
        }
        
        let result = objc_getAssociatedObject(validatable, &key) as! Bool
        XCTAssertEqual(result, true, "Validate method should call clearError if validation succeed")
    }
}
