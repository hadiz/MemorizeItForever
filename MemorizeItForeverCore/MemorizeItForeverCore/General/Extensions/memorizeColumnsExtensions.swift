//
//  memorizeColumnsExtensions.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/2/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

extension MemorizeColumns{
    var days: Int{
        return Int(pow(Double(2), Double(self.rawValue)))
    }
}