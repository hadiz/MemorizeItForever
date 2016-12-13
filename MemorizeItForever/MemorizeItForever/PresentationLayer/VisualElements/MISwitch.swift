//
//  MISwitch.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/5/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class MISwitch: UISwitch {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
