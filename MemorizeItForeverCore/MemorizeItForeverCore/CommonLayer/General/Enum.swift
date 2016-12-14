//
//  Enum.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/25/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//


enum Entities: String{
    case setEntity = "SetEntity"
    case wordEntity = "WordEntity"
    case wordInProgressEntity = "WordInProgressEntity"
    case wordHistoryEntity = "WordHistoryEntity"
}
enum Models: String{
    case setModel
    case wordModel
    case wordHistoryModel
    case wordInProgressModel
}

public enum Settings: String{
    case wordSwitching
    case newWordsCount
    case judgeMyself
    case phraseColor
    case meaningColor
    case defaultSet
}
enum MemorizeColumns: Int16 {
    case pre = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    case fifth = 5
}
public enum WordStatus: Int16{
    case notStarted = 0
    case inProgress = 1
    case done = 2
}
public enum NotificationEnum: String{
    case setViewControllerReload
    case setChanged
    case setDeleted
}
