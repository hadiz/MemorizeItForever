//
//  Set.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/27/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

public struct SetModel: MemorizeItModelProtocol {
    public var setId: UUID?
    public var name: String?
    
    public init(){
        
    }
    
    public init(setId: UUID, name: String) {
        self.setId = setId
        self.name = name
    }
}

func ==(lhs: SetModel, rhs: SetModel) -> Bool {
    return lhs.setId == rhs.setId
}
