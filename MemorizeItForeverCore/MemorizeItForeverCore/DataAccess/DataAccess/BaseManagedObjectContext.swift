//
//  BaseManagedObjectContext.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/30/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import CoreData
import BaseLocalDataAccess

final public class BaseManagedObjectContext: ManagedObjectContextProtocol {
    var context: NSManagedObjectContext!
    
    public init(context: NSManagedObjectContext){
        self.context = context
    }

    public func get() -> NSManagedObjectContext{
        return context
    }
}
