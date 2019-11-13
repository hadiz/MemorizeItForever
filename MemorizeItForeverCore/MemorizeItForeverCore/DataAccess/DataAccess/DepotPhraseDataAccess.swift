//
//  DepotPhraseDataAccess.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/8/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import BaseLocalDataAccess

class DepotPhraseDataAccess: DepotPhraseDataAccessProtocol {
    
    private var genericDataAccess: GenericDataAccess<DepotPhraseEntity>!
    
    init(genericDataAccess: GenericDataAccess<DepotPhraseEntity>) {
        self.genericDataAccess = genericDataAccess
    }
    
    func save(depotPhraseModel: DepotPhraseModel) throws {
        do{
            let depotPhraseEntity = try genericDataAccess.createNewInstance()
            depotPhraseEntity.id = genericDataAccess.generateId()
            depotPhraseEntity.phrase = depotPhraseModel.phrase
            
            try genericDataAccess.saveEntity(depotPhraseEntity)
        }
        catch EntityCRUDError.failNewEntity(let entityName){
            throw EntityCRUDError.failNewEntity(entityName)
        }
        catch{
            throw EntityCRUDError.failSaveEntity(genericDataAccess.getEntityName())
        }
    }
    
    func fetchAll() throws -> [DepotPhraseModel] {
        do{
            return try genericDataAccess.fetchModels(predicate: nil, sort: nil)
        }
        catch let error as NSError{
            throw  DataAccessError.failFetchData(error.localizedDescription)
        }
    }
    
    func delete(_ depotPhraseModel: DepotPhraseModel) throws{
        do{
            guard let id = depotPhraseModel.id else{
                throw EntityCRUDError.failDeleteEntity(genericDataAccess.getEntityName())
            }
            
            if let depotPhraseEntity = try genericDataAccess.fetchEntity(withId: id){
                try genericDataAccess.deleteEntity(depotPhraseEntity)
            }
            else{
                throw DataAccessError.failFetchData("There is no depotPhrase entity with id: \(id)")
            }
        }
        catch let error as NSError{
            throw DataAccessError.failDeleteData(error.localizedDescription)
        }
    }
    
}
