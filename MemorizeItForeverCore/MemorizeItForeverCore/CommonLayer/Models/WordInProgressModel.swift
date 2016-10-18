//
//  WordInProgress.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

struct WordInProgressModel: MemorizeItModelProtocol {
    var word: WordModel?
    var date: Date?
    var column: Int16?
    var wordInProgressId: UUID?
}

func ==(lhs: WordInProgressModel, rhs: WordInProgressModel) -> Bool {
    return lhs.wordInProgressId == rhs.wordInProgressId
}
