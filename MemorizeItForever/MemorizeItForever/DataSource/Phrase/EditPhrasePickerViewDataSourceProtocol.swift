//
//  EditPhrasePickerViewDataSourceProtocol.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/5/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

protocol EditPhrasePickerViewDataSourceProtocol: UIPickerViewDataSource, UIPickerViewDelegate {
    func setModels(_ models: [MemorizeItModelProtocol])
    var handleTap: TypealiasHelper.handleTapClosure? { get set}
}
