//
//  Helper.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/18/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation

var resultKey = 0
var setNumberKey = 1
var setNameKey = 2
var setIdKey = 3
var phraseKey = 4
var meaningKey = 5
var statusKey = 6
var orderKey = 7
var wordIdKey = 8
var columnKey = 9
var dateKey = 10
var wordIdInProgressKey = 11
var columnNoKey = 12
var wordKey = 13
var wordHistoryCountKey = 13

class Helper {
    static func methodSwizzling(_ cls: Swift.AnyClass!, origin: Selector!, swizzled: Selector!){
        let originalMethod = class_getInstanceMethod(cls, origin)
        let swizzledMethod = class_getInstanceMethod(cls, swizzled)
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
