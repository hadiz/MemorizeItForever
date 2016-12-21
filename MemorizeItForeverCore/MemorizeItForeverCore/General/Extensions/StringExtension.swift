//
//  StringExtension.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/18/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

public extension String
{
   public func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
