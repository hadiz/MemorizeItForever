//
//  ClosureHelper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/14/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore

final class MITypealiasHelper{
    typealias validationClosure = (ValidatableProtocol) -> Bool
    typealias RowActionClosure = (_ model: MemorizeItModelProtocol, _ rowAction: TableRowAction) -> Void
}
