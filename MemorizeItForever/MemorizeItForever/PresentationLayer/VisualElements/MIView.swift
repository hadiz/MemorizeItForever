//
//  MIView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/29/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class MIView: UIView {
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
