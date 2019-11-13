//
//  DepotPhraseDataAccessProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/8/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

public protocol DepotPhraseDataAccessProtocol {
    func fetchAll() throws -> [DepotPhraseModel]
    func save(depotPhraseModel: DepotPhraseModel) throws
    func delete(_ setModel: DepotPhraseModel) throws
}
