//
//  WordArchive.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/22/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

public struct WordHistoryModel: MemorizeItModelProtocol {
    public var word: WordModel?
    public var columnNo: Int16?
    public var failureCount: Int32?
    public var wordHistoryId: UUID?
}

func ==(lhs: WordHistoryModel, rhs: WordHistoryModel) -> Bool {
    return lhs.wordHistoryId == rhs.wordHistoryId
}
