//
//  WordHistoryDataAccessProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import BaseLocalDataAccess

protocol WordHistoryDataAccessProtocol {
    func fetchByWordId(_ wordHistoryModel: WordHistoryModel) throws ->  [WordHistoryModel]
    func countByWordId(_ wordHistoryModel: WordHistoryModel) throws -> Int
    func saveOrUpdate(_ wordHistoryModel: WordHistoryModel) throws
}
