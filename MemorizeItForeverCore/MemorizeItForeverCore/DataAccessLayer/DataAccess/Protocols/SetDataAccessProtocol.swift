//
//  SetDataAccessProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import BaseLocalDataAccess

public protocol SetDataAccessProtocol {
//    init(genericDataAccess: GenericDataAccess<SetEntity>)
    func fetchSetNumber() throws -> Int
    func save(_ setModel: SetModel) throws
    func edit(_ setModel: SetModel) throws
    func delete(_ setModel: SetModel) throws
    func fetchAll() throws -> [SetModel] 
}
