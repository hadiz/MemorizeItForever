//
//  Word.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

struct WordModel: Equatable, MemorizeItModelProtocol {
    var wordId: UUID?
    var phrase: String?
    var meaning: String?
    var order: Int32?
    var setId: UUID?
    var status: Int16? = WordStatus.notStarted.rawValue
}

func ==(lhs: WordModel, rhs: WordModel) -> Bool {
    return lhs.wordId == rhs.wordId
}
