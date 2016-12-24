//
//  SetManagerProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

public protocol SetServiceProtocol: ServiceProtocol {
    func delete(_ setModel: SetModel) -> Bool
    func get() -> [SetModel]
    func createDefaultSet()
    func setUserDefaultSet()
    func setUserDefaultSet(force: Bool)
    func save(_ setName: String)
    func edit(_ setModel: SetModel, setName: String)
    func changeSet(_ setModel: SetModel)
}
