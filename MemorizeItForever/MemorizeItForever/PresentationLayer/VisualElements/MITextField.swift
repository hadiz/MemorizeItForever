//
//  MITextField.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/26/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class MITextField: UITextField, ValidatableProtocol {
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
        self.borderStyle = .roundedRect
        self.clearButtonMode = .whileEditing
    }
    
    // MARK: ValidatableProtocol
    
    func applyError(){
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 3.0
    }
    
    func clearError(){
        self.borderStyle = .roundedRect
    }
}
