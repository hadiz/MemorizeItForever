//
//  EditPhrasePickerViewDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/5/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class EditPhrasePickerViewDataSource: NSObject, EditPhrasePickerViewDataSourceProtocol{
    
    var handleTap: TypealiasHelper.handleTapClosure?
    
    private var setModelList: [SetModel] = []
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        setModelList = models as! [SetModel]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return setModelList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return setModelList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        setList.text = setModelList[row].name
//        setId = setModelList[row].setId
        handleTap?(setModelList[row])
    }
}
