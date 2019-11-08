//
//  PhraseTableDataSourceProtocol.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/3/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

protocol PhraseTableDataSourceProtocol: MemorizeItTableDataSourceProtocol {
    var handleTap: TypealiasHelper.handleTapClosure? { get set}
    init(wordService: WordServiceProtocol?)
}
