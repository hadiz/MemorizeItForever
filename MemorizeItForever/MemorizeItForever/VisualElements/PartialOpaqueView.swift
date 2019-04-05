//
//  PartialOpaqueView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/6/18.
//  Copyright © 2018 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class PartialOpaqueView: UIView {
    
    init(frame: CGRect, nonOpaqueFrame: CGRect) {
        super.init(frame: frame)
        make(nonOpaqueFrame: nonOpaqueFrame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func make(nonOpaqueFrame: CGRect) {
        self.addSubview(leadingView(nonOpaqueFrame:nonOpaqueFrame))
        self.addSubview(topView(nonOpaqueFrame: nonOpaqueFrame))
        self.addSubview(trailingView(nonOpaqueFrame: nonOpaqueFrame))
        self.addSubview(bottomView(nonOpaqueFrame: nonOpaqueFrame))
    }
    
    func leadingView(nonOpaqueFrame: CGRect) -> UIView {
        let view = OpaqueView()
        view.frame = CGRect(x: 0, y: 0, width: nonOpaqueFrame.origin.x, height: self.frame.height)
        return view
    }
    
    func topView(nonOpaqueFrame: CGRect) -> UIView {
        let width = self.frame.width - nonOpaqueFrame.origin.x
        let view = OpaqueView()
        view.frame = CGRect(x: nonOpaqueFrame.origin.x, y: 0, width: width, height: nonOpaqueFrame.origin.y)
        return view
    }
    
    func trailingView(nonOpaqueFrame: CGRect) -> UIView {
        let x = nonOpaqueFrame.origin.x + nonOpaqueFrame.width
        let y = nonOpaqueFrame.origin.y
        let width = self.frame.width - x
        let height = self.frame.height - y
        let view = OpaqueView()
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        return view
    }
    
    func bottomView(nonOpaqueFrame: CGRect) -> UIView {
        let x = nonOpaqueFrame.origin.x
        let y = nonOpaqueFrame.origin.y + nonOpaqueFrame.height
        let width = nonOpaqueFrame.width
        let height = self.frame.height - y
        let view = OpaqueView()
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        return view
    }
}

final class OpaqueView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.7)
        self.isOpaque = false
    }
}


class testLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.font = UIFont(name: "Marker Felt", size: self.font.pointSize)
    }
    
    var animText: String? {
        get {
            return text
        }
        set {
            guard let value = newValue else {
                return
            }
            animatetextas(fff: value)
        }
    }
    
    
    func animatetextas(fff: String) {
        guard !fff.isEmpty else {
            return
        }
        var ttt = fff
        let i = ttt.removeFirst()
        DispatchQueue.main.async {
            self.text = "\(self.text ?? "")\(i)"
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            self.animatetextas(fff: ttt)
        }
       
//        DispatchQueue.main.async {
//
//            self.text = ""
//
//            for (index, character) in fff.characters.enumerated() {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 * Double(index)) {
//                    self.text?.append(character)
//                }
//            }
//        }
    }
}


@IBDesignable open class CLTypingLabel: UILabel {
    /*
     Set interval time between each characters
     */
    @IBInspectable open var charInterval: Double = 0.1
    
    /*
     If text is always centered during typing
     */
    @IBInspectable open var centerText: Bool = true
    
    private var typingStopped: Bool = false
    private var typingOver: Bool = true
    private var stoppedSubstring: String?
    private var attributes: [NSAttributedStringKey: Any]?
    private var currentDispatchID: Int = 320
    private let dispatchSerialQ = DispatchQueue(label: "CLTypingLableQueue")
    /*
     Setting the text will trigger animation automatically
     */
    override open var text: String! {
        get {
            return super.text
        }
        
        set {
            if charInterval < 0 {
                charInterval = -charInterval
            }
            
            currentDispatchID += 1
            typingStopped = false
            typingOver = false
            stoppedSubstring = nil
            
            attributes = nil
            setTextWithTypingAnimation(newValue, attributes,charInterval, true, currentDispatchID)
        }
    }
    
    /*
     Setting attributed text will trigger animation automatically
     */
    override open var attributedText: NSAttributedString! {
        get {
            return super.attributedText
        }
        
        set {
            if charInterval < 0 {
                charInterval = -charInterval
            }
            
            currentDispatchID += 1
            typingStopped = false
            typingOver = false
            stoppedSubstring = nil
            
            attributes = newValue.attributes(at: 0, effectiveRange: nil)
            setTextWithTypingAnimation(newValue.string, attributes,charInterval, true, currentDispatchID)
        }
    }
    
    // MARK: -
    // MARK: Stop Typing Animation
    
    open func pauseTyping() {
        if typingOver == false {
            typingStopped = true
        }
    }
    
    // MARK: -
    // MARK: Continue Typing Animation
    
    open func continueTyping() {
        
        guard typingOver == false else {
            print("CLTypingLabel: Animation is already over")
            return
        }
        
        guard typingStopped == true else {
            print("CLTypingLabel: Animation is not stopped")
            return
        }
        guard let stoppedSubstring = stoppedSubstring else {
            return
        }
        
        typingStopped = false
        setTextWithTypingAnimation(stoppedSubstring, attributes ,charInterval, false, currentDispatchID)
    }
    
    // MARK: -
    // MARK: Set Text Typing Recursive Loop
    
    private func setTextWithTypingAnimation(_ typedText: String, _ attributes: Dictionary<NSAttributedStringKey, Any>?, _ charInterval: TimeInterval, _ initial: Bool, _ dispatchID: Int) {
        
        guard typedText.characters.count > 0 && currentDispatchID == dispatchID else {
            typingOver = true
            typingStopped = false
            return
        }
        
        guard typingStopped == false else {
            stoppedSubstring = typedText
            return
        }
        
        if initial == true {
            super.text = ""
        }
        
        let firstCharIndex = typedText.characters.index(typedText.startIndex, offsetBy: 1)
        
        DispatchQueue.main.async {
            if let attributes = attributes {
                super.attributedText = NSAttributedString(string: super.attributedText!.string +  String(typedText[..<firstCharIndex]),
                                                          attributes: attributes)
            } else {
                super.text = super.text! + String(typedText[..<firstCharIndex])
            }
            
            if self.centerText == true {
                self.sizeToFit()
            }
            self.dispatchSerialQ.asyncAfter(deadline: .now() + charInterval) { [weak self] in
                let nextString = String(typedText[firstCharIndex...])
                
                self?.setTextWithTypingAnimation(nextString, attributes, charInterval, false, dispatchID)
            }
        }
        
    }
}

