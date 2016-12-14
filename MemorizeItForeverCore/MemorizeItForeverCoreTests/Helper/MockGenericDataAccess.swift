//
//  MockGenericDataAccess.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import BaseLocalDataAccess
import CoreData


class MockGenericDataAccess<TEntity>: GenericDataAccess<TEntity> where TEntity: EntityProtocol, TEntity: AnyObject, TEntity: NSFetchRequestResult {
    
}
