//
//  ServiceFactoryProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 12/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

public protocol ServiceFactoryProtocol {
    func create<T: ServiceProtocol>() -> T
}
