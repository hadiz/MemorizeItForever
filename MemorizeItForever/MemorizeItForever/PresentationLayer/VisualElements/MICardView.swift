//
//  CardView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/31/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class MICardView: MIView {
    private var phrase: UILabel!
    private var meaning: UILabel!
    private var showingPhrase = true
    
    // TODO
    //    var colorPicker: ColorPickerProtocol?
    
    func initialize(phrase: String, meaning: String, addGesture: Bool = true) -> MICardView{
        initSelf(addGesture: addGesture)
        defineControls(phraseText: phrase, meaningText: meaning)
        addControls()
        applyAutoLayout()
        
        return self
    }
    
    func flip(){
        if(showingPhrase){
            UIView.transition(from: phrase, to: meaning, duration: 1, options: [.transitionFlipFromRight ,.showHideTransitionViews], completion: nil)
            showingPhrase = false
        }
        else{
            UIView.transition(from: meaning, to: phrase, duration: 1, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            showingPhrase = true
        }
    }
    
    func updateText(phrase: String, meaning: String){
        self.phrase.text = phrase
        self.meaning.text = meaning
    }
    
    func changeFrontIfNeeded(showingPhrase: Bool){
        if self.showingPhrase != showingPhrase{
            if showingPhrase {
                phrase.isHidden = false
                meaning.isHidden = true
            }
            else{
                phrase.isHidden = true
                meaning.isHidden = false
            }
            self.showingPhrase = showingPhrase
        }
    }
    
    func flipIfNeeded(showingPhrase: Bool){
        if self.showingPhrase != showingPhrase{
            flip()
        }
    }
    
    private func initSelf(addGesture: Bool){
        if addGesture{
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(MICardView.flip))
            doubleTap.numberOfTapsRequired = 2
            self.addGestureRecognizer(doubleTap)
        }
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = ColorPicker.shared.backgroundView.withAlphaComponent(0.7)
        self.layer.cornerRadius = 20.0
        self.clipsToBounds = true
    }
    
    private func defineControls(phraseText: String, meaningText: String){
        phrase = MICardViewLabel()
        phrase.text = phraseText
        
        meaning = MICardViewLabel()
        meaning.text = meaningText
        meaning.isHidden = true
    }
    
    private func addControls(){
        self.addSubview(phrase)
        self.addSubview(meaning)
    }
    
    private func applyAutoLayout(){
        var viewDic: Dictionary<String,Any> = [:]
        var constraintList: [NSLayoutConstraint] = []
        
        viewDic["phrase"] = phrase
        viewDic["meaning"] = meaning
        
        let hPhraseCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|[phrase]|", options: [], metrics: nil, views: viewDic)
        let vPhraseCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:|[phrase]|", options: [], metrics: nil, views: viewDic)
        
        let hMeaningCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|[meaning]|", options: [], metrics: nil, views: viewDic)
        let vMeaningCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:|[meaning]|", options: [], metrics: nil, views: viewDic)
        
        constraintList += hPhraseCnst
        constraintList += vPhraseCnst
        constraintList += hMeaningCnst
        constraintList += vMeaningCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
    
}
