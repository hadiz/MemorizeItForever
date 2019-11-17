//
//  FakeDepotPhraseDataAccess.swift
//  MemorizeItForeverCoreTests
//
//  Created by Hadi Zamani on 11/14/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import BaseLocalDataAccess
@testable import MemorizeItForeverCore

class FakeDepotPhraseDataAccess: DepotPhraseDataAccessProtocol {
    func save(depotPhraseModels: [DepotPhraseModel]) throws {
        for model in depotPhraseModels {
            guard let name = model.phrase, !name.trim().isEmpty else {
                return
            }
        }
        objc_setAssociatedObject(self, &resultKey, FakeDepotPhraseDataAccessEnum.save, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func fetchAll() throws -> [DepotPhraseModel] {
        return []
    }
    
    func save(depotPhraseModel: DepotPhraseModel) throws {
        guard let name = depotPhraseModel.phrase, !name.trim().isEmpty else {
            return
        }
        objc_setAssociatedObject(self, &resultKey, FakeDepotPhraseDataAccessEnum.save, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func delete(_ setModel: DepotPhraseModel) throws {
        objc_setAssociatedObject(self, &resultKey, FakeDepotPhraseDataAccessEnum.delete, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
