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
    
    func save(depotPhraseModel: DepotPhraseModel) throws {
        
    }
    
    func fetchAll() throws -> [DepotPhraseModel] {
        return []
    }
    
    
}
