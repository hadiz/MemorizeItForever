//
//  SetManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/12/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

final public class SetManager: SetManagerProtocol {
    private var setDataAccess: SetDataAccessProtocol

    public init(dataAccess: SetDataAccessProtocol){
        setDataAccess = dataAccess
    }
    
    public func createDefaultSet() {
        do{
            if try setDataAccess.fetchSetNumber() == 0{
                var set = SetModel()
                set.name = "Default"
                try setDataAccess.save(set)
            }
        }
        catch{
            
        }
    }
    
    public func setUserDefaultSet() {
        setUserDefaultSet(force: false)
    }
    
    public func setUserDefaultSet(force: Bool) {
        do{
            
            let sets = try setDataAccess.fetchAll()
            if sets.count > 0{
                let defaults = UserDefaults.standard
                if defaults.object(forKey: Settings.defaultSet.rawValue) == nil || force{
                    changeSet(sets[0])
                }
            }
        }
        catch{
            
        }
    }
    
   public func save(_ setName: String){
        do{
            var set = SetModel()
            set.name = setName
            try setDataAccess.save(set)
        }
        catch{
            
        }
    }
    
   public func edit(_ setModel: SetModel, setName: String){
        do{
            var set = SetModel()
            set.name = setName
            set.setId = setModel.setId
            try setDataAccess.edit(set)
        }
        catch{
            
        }
    }
    
   public func delete(_ setModel: SetModel) -> Bool{
        do{
            if try ifSetIsdeletable(){
                try setDataAccess.delete(setModel)
                changeDefaultSetIfNeeded(setModel)
                return true
            }
            else{
                // TODO notify set is not deletable
                
            }
        }
        catch{
            
        }
        return false
    }
    
    public func get() -> [SetModel]{
        do{
           return try setDataAccess.fetchAll()
        }
        catch{
            
        }
        return []
    }
    
   public func ifSetIsdeletable() throws -> Bool{
        do{
          return try setDataAccess.fetchSetNumber() > 1
        }
        catch{
            throw error
        }
    }
    
    public func changeSet(_ setModel: SetModel){
        UserDefaults.standard.set(setModel.toDic(), forKey: Settings.defaultSet.rawValue)
        NotificationCenter.default.post(.setChanged, object: nil)
    }
    
    private func changeDefaultSetIfNeeded(_ set: SetModel){
        let defaults = UserDefaults.standard
        if let setModel = defaults.getDefaultSetModel(){
            if setModel.setId == set.setId{
                setUserDefaultSet(force: true)
            }
        }
    }
}
