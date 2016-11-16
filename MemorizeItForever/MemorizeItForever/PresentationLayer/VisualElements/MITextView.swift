//
//  MITextView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class MITextView: UITextView, ValidatableProtocol {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 18.0
        self.text = " "
        addBorder()
    }
    
    func applyError(){
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 3.0
    }
    func clearError(){
        addBorder()
    }
    
    private func addBorder(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
    }
}
