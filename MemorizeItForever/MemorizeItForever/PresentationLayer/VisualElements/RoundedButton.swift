//
//  RoundedButton.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/11/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

final class RoundedButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        
        let newRect = CGRect(x: bounds.midX - width / 2, y: bounds.midY - width / 2, width: width, height: width)
        
        let path = UIBezierPath(ovalIn: newRect)
        let buttonColor = UIColor(red: 10, green: 106, blue: 184)
        
        buttonColor.setFill()
        
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
        self.backgroundColor = ColorPicker().backgroundView
    }
}
