//
//  ContextHelper.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 12/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import CoreData

public final class ContextHelper {
    public static let shared = ContextHelper()
    
    private var context: NSManagedObjectContext?
    
    private init(){
    }
    
    public func setContext(context: NSManagedObjectContext){
        self.context = context
    }
    
    public func getContext() -> NSManagedObjectContext{
        guard let context = context else {
            fatalError("context is nil")
        }
        return context
    }
}
