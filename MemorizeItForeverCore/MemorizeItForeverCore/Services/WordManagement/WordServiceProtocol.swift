//
//  WordManagerProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

public protocol WordServiceProtocol: ServiceProtocol {
    func save(_ phrase: String, meaninig: String, setId: UUID) throws
    func edit(_ wordModel: WordModel, phrase: String, meaninig: String, setId: UUID?)
    func delete(_ wordModel: WordModel) -> Bool
    func fetchWords(phrase: String, status: WordStatus, fetchLimit: Int, fetchOffset: Int) -> [WordModel]
    func fetchWordHistoryByWord(wordModel: WordModel) -> [WordHistoryModel]
}
