//
//  WordDataAccessProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import BaseLocalDataAccess

public protocol WordDataAccessProtocol {
    func save(_ wordModel: WordModel) throws
    func edit(_ wordModel: WordModel) throws
    func delete(_ wordModel: WordModel) throws
    func fetchWithNotStartedStatus(fetchLimit: Int) throws -> [WordModel]
    func fetchLast(_ wordStatus: WordStatus) throws -> WordModel?
    func fetchAll(fetchLimit: Int?) throws -> [WordModel]
    func fetchWords(status: WordStatus, fetchLimit: Int) throws -> [WordModel]
    func fetchWords(phrase: String, status: WordStatus, fetchLimit: Int) throws -> [WordModel]
}
