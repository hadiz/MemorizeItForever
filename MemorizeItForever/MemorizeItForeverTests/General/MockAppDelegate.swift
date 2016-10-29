//
//  Helper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore
@testable import MemorizeItForever

class MockAppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //******** // should put whole block in main app delegate
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: Settings.wordSwitching.rawValue) == nil{
            defaults.setValue(true, forKey: Settings.wordSwitching.rawValue)
        }
        if defaults.object(forKey: Settings.newWordsCount.rawValue) == nil{
            defaults.setValue(10, forKey: Settings.newWordsCount.rawValue)
        }
        if defaults.object(forKey: Settings.judgeMyself.rawValue) == nil{
            defaults.setValue(true, forKey: Settings.judgeMyself.rawValue)
        }
        if defaults.colorForKey(Settings.phraseColor.rawValue) == nil {
            defaults.setColor(UIColor.black, forKey: Settings.phraseColor.rawValue)
        }
        if defaults.colorForKey(Settings.meaningColor.rawValue) == nil {
            defaults.setColor(UIColor.red, forKey: Settings.meaningColor.rawValue)
        }
        
        
        //******** //
        
        
        return true
    }
    
}


