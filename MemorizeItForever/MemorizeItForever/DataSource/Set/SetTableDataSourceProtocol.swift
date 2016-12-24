//
//  SetTableDataSourceProtocol.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/13/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

protocol SetTableDataSourceProtocol: MemorizeItTableDataSourceProtocol {
    var handleTap: TypealiasHelper.handleTapClosure? { get set}
    init(setService: SetServiceProtocol?)
}
