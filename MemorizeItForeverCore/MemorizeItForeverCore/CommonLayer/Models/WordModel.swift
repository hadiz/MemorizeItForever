//
//  Word.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/21/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

public struct WordModel: Equatable, MemorizeItModelProtocol {
    public var wordId: UUID?
    public var phrase: String?
    public var meaning: String?
    public var order: Int32?
    public var setId: UUID?
    public var status: Int16? = WordStatus.notStarted.rawValue
    
    public init(){
        // TODO: Delete
    }
}

public func ==(lhs: WordModel, rhs: WordModel) -> Bool {
    return lhs.wordId == rhs.wordId
}
