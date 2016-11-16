//
//  StringExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/14/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
