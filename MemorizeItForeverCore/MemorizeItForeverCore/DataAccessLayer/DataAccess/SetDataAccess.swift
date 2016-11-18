//
//  SetDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/23/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//
import Foundation
import BaseLocalDataAccess

public class SetDataAccess: SetDataAccessProtocol  {
    
    private var genericDataAccess: GenericDataAccess<SetEntity>!
    
    public init(genericDataAccess: GenericDataAccess<SetEntity>) {
        self.genericDataAccess = genericDataAccess
    }
    
     public func fetchSetNumber() throws -> Int {
        
        do{
            return try genericDataAccess.fetchEntityCount()
        }
        catch{
            throw EntityCRUDError.failFetchEntityCount(genericDataAccess.getEntityName())
        }
    }
    
    public func save(_ setModel: SetModel) throws{
        do{
            let setEntity = try genericDataAccess.createNewInstance()
            setEntity.id = genericDataAccess.generateId()
            setEntity.name = setModel.name
            
            try genericDataAccess.saveEntity(setEntity)
        }
        catch EntityCRUDError.failNewEntity(let entityName){
            throw EntityCRUDError.failNewEntity(entityName)
        }
        catch{
            throw EntityCRUDError.failSaveEntity(genericDataAccess.getEntityName())
        }
    }
    
    public func edit(_ setModel: SetModel) throws{
        do{
            guard let id = setModel.setId else{
                throw EntityCRUDError.failEditEntity(genericDataAccess.getEntityName())
            }
            
            if let setEntity = try genericDataAccess.fetchEntity(withId: id){
                setEntity.name = setModel.name
                try genericDataAccess.saveEntity(setEntity)
            }
            else{
                throw DataAccessError.failFetchData("There is no Set entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.failEditData(error.localizedDescription)
        }
    }
    
    public func delete(_ setModel: SetModel) throws{
        do{
            guard let id = setModel.setId else{
                throw EntityCRUDError.failDeleteEntity(genericDataAccess.getEntityName())
            }
            
            if let setEntity = try genericDataAccess.fetchEntity(withId: id){
                try genericDataAccess.deleteEntity(setEntity)
            }
            else{
                throw DataAccessError.failFetchData("There is no Set entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.failDeleteData(error.localizedDescription)
        }
    }
    
    public func fetchAll() throws -> [SetModel] {
        do{
            return try genericDataAccess.fetchModels(predicate: nil, sort: nil)
        }
        catch let error as NSError{
            throw  DataAccessError.failFetchData(error.localizedDescription)
        }
    }
}
