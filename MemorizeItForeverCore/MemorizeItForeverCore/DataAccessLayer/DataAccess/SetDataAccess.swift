//
//  SetDataAccess.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/23/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//
import Foundation
import BaseLocalDataAccess

public class SetDataAccess: BaseDataAccess<SetEntity>, SetDataAccessProtocol  {
     public func fetchSetNumber() throws -> Int {
        
        do{
            return try dataAccess.fetchEntityCount()
        }
        catch{
            throw EntityCRUDError.failFetchEntityCount(getEntityName())
        }
    }
    
    public func save(_ setModel: SetModel) throws{
        do{
            let setEntity = try dataAccess.createNewInstance()
            setEntity.id = generateId()
            setEntity.name = setModel.name
            
            try dataAccess.saveEntity(setEntity)
        }
        catch EntityCRUDError.failNewEntity(let entityName){
            throw EntityCRUDError.failNewEntity(entityName)
        }
        catch{
            throw EntityCRUDError.failSaveEntity(getEntityName())
        }
    }
    
    public func edit(_ setModel: SetModel) throws{
        do{
            guard let id = setModel.setId else{
                throw EntityCRUDError.failEditEntity(getEntityName())
            }
            
            if let setEntity = try fetchEntity(withId: id){
                setEntity.name = setModel.name
                try dataAccess.saveEntity(setEntity)
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
                throw EntityCRUDError.failDeleteEntity(getEntityName())
            }
            
            if let setEntity = try fetchEntity(withId: id){
                try dataAccess.deleteEntity(setEntity)
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
            return try fetchModels(predicate: nil, sort: nil)
        }
        catch let error as NSError{
            throw  DataAccessError.failFetchData(error.localizedDescription)
        }
    }
    
//    func fetch(_ id: UUID) throws -> SetModel? {
//        do{
//            if let set = try fetchEntity(withId: id){
//                return try set.toModel() as? SetModel
//            }
//            return nil
//        }
//        catch ModelError.failCreateModel(let model){
//            throw ModelError.failCreateModel(model)
//        }
//        catch let error as NSError{
//            throw  DataAccessError.failFetchData(error.localizedDescription)
//        }
//    }
    
}
