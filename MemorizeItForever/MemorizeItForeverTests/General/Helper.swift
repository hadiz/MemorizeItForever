//
//  Helper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/25/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation

var key = 0

class Helper {
    static func methodSwizzling(_ cls: Swift.AnyClass!, origin: Selector!, swizzled: Selector!){
        let originalMethod = class_getInstanceMethod(cls, origin)
        let swizzledMethod = class_getInstanceMethod(cls, swizzled)
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
