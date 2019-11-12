//
//  WordInProgress.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

public struct WordInProgressModel: MemorizeItModelProtocol {
   public var word: WordModel?
   public var date: Date?
   public var column: Int16?
   public var wordInProgressId: UUID?
//   public init() {
//        
//    }
}

public func ==(lhs: WordInProgressModel, rhs: WordInProgressModel) -> Bool {
    return lhs.wordInProgressId == rhs.wordInProgressId
}
