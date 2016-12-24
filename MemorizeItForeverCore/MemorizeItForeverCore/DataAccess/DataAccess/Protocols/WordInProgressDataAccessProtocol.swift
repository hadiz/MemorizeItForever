//
//  WordInProgressDataAccessProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import BaseLocalDataAccess

protocol WordInProgressDataAccessProtocol {
    func save(_ wordInProgressModel: WordInProgressModel) throws
    func fetchByDateAndColumn(_ wordInProgressModel: WordInProgressModel, set: SetModel) throws -> [WordInProgressModel]
    func fetchByDateAndOlder(_ wordInProgressModel: WordInProgressModel, set: SetModel) throws -> [WordInProgressModel]
    func edit(_ wordInProgressModel: WordInProgressModel) throws
    func delete(_ wordInProgressModel: WordInProgressModel) throws
    func fetchByWordId(_ wordInProgressModel: WordInProgressModel) throws -> WordInProgressModel?
    func fetchAll() throws -> [WordInProgressModel]
}
