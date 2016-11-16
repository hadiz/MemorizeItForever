//
//  WordFlowManagerProtocol.swift
//  MemorizeItForeverCore
//
//  Created by Hadi Zamani on 11/16/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

protocol WordFlowManagerProtocol {
    func putWordInPreColumn(_ wordModel: WordModel) throws
    func answerCorrectly(_ wordInProgressModel: WordInProgressModel)
    func answerWrongly(_ wordInProgressModel: WordInProgressModel)
    func fetchNewWordsToPutInPreColumn() throws
    func fetchWordsForReview() throws -> [WordModel]
    func fetchWordsToExamin() throws -> [WordInProgressModel]
}
