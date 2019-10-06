//
//  MILabel.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/26/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class MICardViewLabel: VerticallyCenteredTextView {
    
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
        self.textAlignment = .center
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        self.backgroundColor = .clear
        self.panGestureRecognizer.minimumNumberOfTouches = 2
        self.isEditable = false
    }
    
    func addDoubleTapGestureRecognizer(target: Any?, action: Selector?){
        let doubleTap = UITapGestureRecognizer(target: target, action: action)
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
}

// https://geek-is-stupid.github.io/2017-05-15-how-to-center-text-vertically-in-a-uitextview/
class VerticallyCenteredTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
        }
    }
}
