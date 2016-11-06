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
    
    public init?(dictionary: Dictionary<String, Any>) {
        guard let id = dictionary["setId"] as? String, let name = dictionary["name"] as? String else{
            return nil
        }
        self.setId = UUID(uuidString: id)
        self.name = name
    }
    
    public func toDic() -> Dictionary<String, Any>{
        var dic: Dictionary<String, Any> = [:]
        dic["setId"] = setId?.uuidString
        dic["name"] = name
        return dic
    }
}

func ==(lhs: SetModel, rhs: SetModel) -> Bool {
    return lhs.setId == rhs.setId
}
