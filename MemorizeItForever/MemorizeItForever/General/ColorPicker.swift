//
//  Helper.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/26/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class ColorPicker: ColorPickerProtocol {
    
    // TODO, Until Swinject support UIView injection, I decided to make it singleton
    
    static let shared = ColorPicker()
    
    private init(){
        
    }
    
    lazy var backgroundView: UIColor = {
       return UIColor(red: 245, green: 149, blue: 71)
    }()
    
    lazy var backgroundButton: UIColor = {
        return UIColor(red: 10, green: 106, blue: 184)
    }()
    
}
