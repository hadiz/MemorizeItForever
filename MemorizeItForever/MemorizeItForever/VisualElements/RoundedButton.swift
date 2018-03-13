//
//  RoundedButton.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/11/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    //TODO
    //    var colorPicker: ColorPickerProtocol!
    
    @IBInspectable
    var shadow: Bool = false {
        didSet {
            if shadow {
                applyShadow()
            }
        }
    }
    
    var buttonColor: UIColor?
    
    override func draw(_ rect: CGRect) {
        
        var width = bounds.width < bounds.height ? bounds.width : bounds.height
        if shadow {
            width -= 4
        }
        
        let newRect = CGRect(x: bounds.midX - width / 2, y: bounds.midY - width / 2, width: width, height: width)
        
        let path = UIBezierPath(ovalIn: newRect)
        buttonColor = buttonColor ?? ColorPicker.backgroundButton
        
        buttonColor!.setFill()
        
        path.fill()
        
        self.contentMode = UIViewContentMode.redraw
        
        self.setTitleColor(UIColor.white, for: UIControlState())
        
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.backgroundColor = buttonColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        self.backgroundColor = UIColor.clear
    }
    
    private func applyShadow(){
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
