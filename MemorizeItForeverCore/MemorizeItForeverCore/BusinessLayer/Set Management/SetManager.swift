//
//  SetManager.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/12/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

public class SetManager {
    
    private var _dataAccess: SetDataAccess?
    private var setDataAccess: SetDataAccess{
        guard let dataAccess = _dataAccess else{
            _dataAccess = SetDataAccess()
            return _dataAccess!
        }
        return dataAccess
    }
    
    public init(){
        _dataAccess = nil
    }
    
    init(dataAccess: SetDataAccess){
        _dataAccess = dataAccess
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
          return  try  setDataAccess.fetchSetNumber() > 1
        }
        catch{
            throw error
        }
    }
    
}
