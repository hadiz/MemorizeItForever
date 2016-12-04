//
//  WordStatusExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/4/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore

extension WordStatus{
    func getString() -> String{
        switch self {
        case .notStarted:
            return "Not Started"
        case .inProgress:
            return "In Progress"
        case .done:
            return "Done"
        }
    }
}

