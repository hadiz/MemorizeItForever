//
//  UIViewExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/19/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

extension UIView{
    func makeAToast(color: UIColor, message: String, fastHiding: Bool = false){
        let toatsView = UIView(frame: CGRect(x: 0, y: self.layer.frame.height, width: self.frame.width, height: 70))
        toatsView.layer.cornerRadius = 10.0
        toatsView.clipsToBounds = true
        toatsView.backgroundColor = color
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: toatsView.frame.width, height: toatsView.frame.height))
        label.text = message
        label.textAlignment = .center
        toatsView.addSubview(label)
        self.addSubview(toatsView)
        
        UIView.animate(withDuration:0.5, delay: 0.0, options: [], animations: { () -> Void in
            
            toatsView.layer.frame.origin.y = self.layer.frame.height - 90
            
        }) { (finished) -> Void in
            
            let weakSelf = self
            let timerInterval: TimeInterval = fastHiding ? 0.1 : 1
            
            if #available(iOS 10.0, *) {
                let timer = Timer(timeInterval: timerInterval, repeats: false, block: {[weak weakSelf] (timer) in
                    if let weakSelf = weakSelf{
                        weakSelf.hideToastAction(toatsView: toatsView)
                    }
                    })
                RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            } else {
                Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(UIView.hideToast), userInfo: toatsView, repeats: false)
            }
        }
    }
    
    func makeASuccessToast(message: String){
        makeAToast(color: #colorLiteral(red: 0.08449555188, green: 0.7481188774, blue: 0.1858257651, alpha: 0.75), message: message)
    }
    
    func makeAFailureToast(message: String){
        makeAToast(color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.75), message: message)
    }
    
    func makeAMessageToast(message: String){
        makeAToast(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), message: message, fastHiding: true)
    }
    
    @objc func hideToast(timer: Timer){
        if let toatsView = timer.userInfo as? UIView{
            hideToastAction(toatsView: toatsView)
        }
    }
    
    private func hideToastAction(toatsView: UIView){
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: { () -> Void in
            toatsView.alpha = 0.0
            }, completion: { (finished: Bool) -> Void in
                toatsView.removeFromSuperview()
        })
    }
}
