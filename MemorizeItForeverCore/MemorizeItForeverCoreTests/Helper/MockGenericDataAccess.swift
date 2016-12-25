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
   
//    public func fetchEntity(predicate: PredicateProtocol?, sort: SortProtocol?, fetchLimit: Int?) throws -> [TEntity] {
//        return []
//    }

    typealias T = TEntity
    
    required init(context: ManagedObjectContextProtocol) {
        super.init(context: context)
    }
    
//    override func createNewInstance() throws -> TEntity {
//        return NSManagedObject() as! TEntity
//    }
//    
//    override func saveEntity(_ entity: TEntity) throws {
//        
//    }
//    
    func fetchEntity(withId id: UUID) throws -> TEntity? {
        return nil
    }
    
//    func fetchEntityCount(predicate: PredicateProtocol?) throws -> Int {
//        return 0
//    }
//    
//    func deleteEntity(_ entity: TEntity) throws {
//        
//    }
}
