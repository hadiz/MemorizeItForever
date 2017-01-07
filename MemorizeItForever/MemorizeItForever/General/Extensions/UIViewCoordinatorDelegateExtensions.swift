//
//  UIViewCoordinatorDelegateExtensions.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/7/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

extension UIViewCoordinatorDelegate{
    func applyViews(){
        defineControls()
        addControls()
        applyAutoLayout()
    }
}
