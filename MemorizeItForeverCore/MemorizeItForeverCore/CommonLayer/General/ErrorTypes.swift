//
//  ErrorTypes.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/20/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//


enum WordManagementFlowError: Error{
    case wordModelIsNull(String)
    case progressWord(String)
    case newWordsCount(String)
    case wordInProgressIsNull(String)
}

enum ContextErrors: Error{
    case creation(String)
}
