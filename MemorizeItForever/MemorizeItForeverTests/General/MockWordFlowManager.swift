//
//  MockWordFlowService.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/21/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore

class MockWordFlowService: WordFlowServiceProtocol {
    func putWordInPreColumn(_ wordModel: WordModel) throws {
        
    }
    func answerWrongly(_ wordInProgressModel: WordInProgressModel) {
        
    }
    func answerCorrectly(_ wordInProgressModel: WordInProgressModel) {
        
    }
    func fetchNewWordsToPutInPreColumn() throws {
        
    }
    func fetchWordsForReview() throws -> [WordModel] {
        return []
    }
    func fetchWordsToExamin() throws -> [WordInProgressModel] {
        return []
    }
}
