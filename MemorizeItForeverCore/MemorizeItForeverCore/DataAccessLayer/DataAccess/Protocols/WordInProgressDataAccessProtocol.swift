//
//  WordInProgressDataAccessProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

protocol WordInProgressDataAccessProtocol {
    func save(_ wordInProgressModel: WordInProgressModel) throws
    func fetchByDateAndColumn(_ wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel]
    func fetchByDateAndOlder(_ wordInProgressModel: WordInProgressModel) throws -> [WordInProgressModel]
    func edit(_ wordInProgressModel: WordInProgressModel) throws
    func delete(_ wordInProgressModel: WordInProgressModel) throws
    func fetchByWordId(_ wordInProgressModel: WordInProgressModel) throws -> WordInProgressModel?
}
