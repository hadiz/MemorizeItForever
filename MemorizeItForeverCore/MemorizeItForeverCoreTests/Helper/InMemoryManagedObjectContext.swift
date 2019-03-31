//
//  InMemoryManagedObjectContext.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 10/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import CoreData
import BaseLocalDataAccess

class InMemoryManagedObjectContext: ManagedObjectContextProtocol  {
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        return setUpInMemoryManagedObjectContext()
    }()
    
    public init(){
    }
    
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext{
        let memorizeItForeverCoreBundle = Bundle(identifier: "org.somesimplesolutions.MemorizeItForeverCore")
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [memorizeItForeverCoreBundle!])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do{
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        }
        catch{
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }
}
