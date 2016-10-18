//
//  NSUserDefaultsExtensions.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/27/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

extension UserDefaults{
    
   public func colorForKey(_ key: String) -> UIColor?{
        var color: UIColor?
        if let colorData = data(forKey: key){
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    public func setColor(_ color: UIColor?, forKey key: String){
        var colorData: Data?
        if let color = color{
            colorData = NSKeyedArchiver.archivedData(withRootObject: color)
        }
        set(colorData, forKey: key)
    }
}
