//
//  WordManagerProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/10/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

public protocol WordManagerProtocol {
    func saveWord(_ phrase: String, meaninig: String, setId: UUID) throws
    func editWord(_ wordModel: WordModel, phrase: String, meaninig: String)
    func deleteWord(_ wordModel: WordModel)
    func fetchWords(phrase: String, status: WordStatus, fetchLimit: Int) -> [WordModel]
}
