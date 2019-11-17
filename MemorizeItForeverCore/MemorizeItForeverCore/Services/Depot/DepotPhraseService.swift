//
//  DepotPhraseService.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/14/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

final public class DepotPhraseService: DepotPhraseServiceProtocol {
    private var dataAccess: DepotPhraseDataAccessProtocol
    
    init(dataAccess: DepotPhraseDataAccessProtocol){
        self.dataAccess = dataAccess
    }
    
    public func save(_ phrase: String){
        do{
            var depot = DepotPhraseModel()
            depot.phrase = phrase
            try dataAccess.save(depotPhraseModel: depot)
        }
        catch{
            
        }
    }
    
    public func save(_ phrases: [String]){
        do{
            var depots = [DepotPhraseModel]()
            for phrase in phrases {
                var depot = DepotPhraseModel()
                depot.phrase = phrase
                depots.append(depot)
            }
            try dataAccess.save(depotPhraseModels: depots)
        }
        catch{
            
        }
    }
    
    public func delete(_ model: DepotPhraseModel) -> Bool{
        do{
            try dataAccess.delete(model)
            return true
        }
        catch{
            
        }
        return false
    }
    
    public func get() -> [DepotPhraseModel]{
        do{
            return try dataAccess.fetchAll()
        }
        catch{
            
        }
        return []
    }
}
