//
//  Validator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/14/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class Validator: ValidatorProtocol {
    
    func validate(_ validatable: ValidatableProtocol, errorMessage: String, by validate: MITypealiasHelper.validationClosure) -> Bool {
      
        let result = validate(validatable)
        
        if result{
            clearError(validatable: validatable)
        }
        else{
            applyError(validatable: validatable, errorMessage: errorMessage)
        }
        return result
    }
    
    func clear(validatable: ValidatableProtocol) {
        clearError(validatable: validatable)
    }
    
    private func clearError(validatable: ValidatableProtocol){
        validatable.clearError()
        if let validatable = validatable as? UIView, let superView = validatable.superview{
            for item in superView.subviews{
                if item.tag == Int.max{
                    item.removeFromSuperview()
                }
            }
        }
    }
    
    private func applyError(validatable: ValidatableProtocol, errorMessage: String){
        validatable.applyError()
        
        if let validatable = validatable as? UIView{
            shake(validatable)
            
            if let superView = validatable.superview{
                let label = UILabel()
                label.text =  " \(errorMessage) "
                label.textColor = UIColor.red
                label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
                label.layer.cornerRadius = 5.0
                label.layer.borderColor = UIColor.gray.cgColor
                label.layer.borderWidth = 0.5
                label.tag = Int.max
                label.clipsToBounds = true
                label.frame = CGRect(x: validatable.layer.frame.origin.x + 3, y: validatable.layer.frame.origin.y - 21, width: validatable.layer.frame.width, height: 21)
                superView.addSubview(label)
                label.sizeToFit()
            }
        }

    }
    
    private func shake(_ view: UIView){
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.y");
        rotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            self.toRadian($0)
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = 0.6
        view.layer.add(shakeGroup, forKey: "shakeIt")
    }
    
    private func toRadian(_ value: Int) -> CGFloat {
        return CGFloat(Double(value) / 180.0 * .pi)
    }
}
