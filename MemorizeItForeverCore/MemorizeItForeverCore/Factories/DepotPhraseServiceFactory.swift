//
//  DepotPhraseServiceFactory.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/14/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

public final class DepotPhraseServiceFactory: ServiceFactoryProtocol {
    
    public init(){
    }
    
    public func create<T : ServiceProtocol>() -> T {
        return iocContainer.resolve(DepotPhraseServiceProtocol.self)! as! T
    }
}
