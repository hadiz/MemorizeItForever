//
//  BaseDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/30/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import BaseLocalDataAccess
import CoreData


public class BaseDataAccess<T> where T: EntityProtocol, T: AnyObject, T: NSFetchRequestResult {
    var genericDataAccess: GenericDataAccess<T>
    
    public required init(genericDataAccess: GenericDataAccess<T>){
        self.genericDataAccess = genericDataAccess
    }
}
