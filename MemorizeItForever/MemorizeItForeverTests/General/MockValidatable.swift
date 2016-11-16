//
//  MockValidatable.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/14/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation
@testable import MemorizeItForever

class MockValidatable: ValidatableProtocol {
    func applyError(){
        objc_setAssociatedObject(self, &key, false, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func clearError(){
        objc_setAssociatedObject(self, &key, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
