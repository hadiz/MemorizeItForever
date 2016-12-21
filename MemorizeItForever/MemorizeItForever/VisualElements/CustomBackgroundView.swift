//
//  CustomBackgroundView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/17/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class CustomBackgroundView: UIView {
    //TODO
//    var colorPicker: ColorPickerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
//        guard let colorPicker = colorPicker else {
//            fatalError("colorPicker is not initialized")
//        }
        self.backgroundColor = ColorPicker.shared.backgroundView
    }
}
