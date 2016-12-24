//
//  WordServiceFactory.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 12/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

public final class WordServiceFactory: ServiceFactoryProtocol {
    public init(){
        
    }
    
    public func create<T : ServiceProtocol>() -> T {
        return iocContainer.resolve(WordServiceProtocol.self)! as! T
    }
}
