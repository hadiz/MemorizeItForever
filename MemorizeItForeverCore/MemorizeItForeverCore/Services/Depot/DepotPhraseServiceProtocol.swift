//
//  DepotPhraseServiceProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/14/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

public protocol DepotPhraseServiceProtocol: ServiceProtocol {
    func get() -> [DepotPhraseModel]
    func save(_ phrase: String)
    func delete(_ model: DepotPhraseModel) -> Bool
}
