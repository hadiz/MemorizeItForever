//
//  SetManagerProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

public protocol SetManagerProtocol {
    func delete(_ setModel: SetModel) -> Bool
    func get() -> [SetModel]
    func createDefaultSet()
    func setUserDefaultSet()
    func save(_ setName: String)
    func edit(_ setModel: SetModel, setName: String)
}
