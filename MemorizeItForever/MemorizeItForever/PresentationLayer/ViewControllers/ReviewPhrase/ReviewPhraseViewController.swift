//
//  ReviewPhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/25/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class ReviewPhraseViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var phrase: UILabel?
    var meaning: UILabel?
    var cardView: UIView?
    var flip: UIButton?
    var done: UIButton?
    
    private var showingPhrase = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Review Phrases"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(ReviewPhraseViewController.previousbarButtonTapHandler))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(ReviewPhraseViewController.nextbarButtonTapHandler))
        
        defineControls()
        addControls()
        applyAutoLayout()
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ReviewPhraseViewController.flipAction))
        doubleTap.numberOfTapsRequired = 2
        cardView?.addGestureRecognizer(doubleTap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func previousbarButtonTapHandler(){
        
    }
    
    func nextbarButtonTapHandler(){
        
    }
    
    func flipTapHandler(){
        flipAction()
    }
    
    func doneTapHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func flipAction(){
        if(showingPhrase){
            UIView.transition(from: phrase!, to: meaning!, duration: 1, options: [.transitionFlipFromRight ,.showHideTransitionViews], completion: nil)
            showingPhrase = false
        }
        else{
            UIView.transition(from: meaning!, to: phrase!, duration: 1, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            showingPhrase = true
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    private func defineControls(){
        cardView = MIView()
        cardView?.isUserInteractionEnabled = true
        cardView?.backgroundColor = ColorPicker().backgroundView.withAlphaComponent(0.5)
        cardView?.layer.cornerRadius = 20.0
        cardView?.clipsToBounds = true
        
        phrase = MILabel()
        phrase?.text = "phrase"
        
        meaning = MILabel()
        meaning?.text = "meaning"
        meaning?.isHidden = true
        
        flip = MIButton()
        flip?.setTitle("Flip!", for: .normal)
        flip?.addTarget(self, action: #selector(ReviewPhraseViewController.flipTapHandler), for: .touchUpInside)
        
        done = MIButton()
        done?.setTitle("Done", for: .normal)
        done?.addTarget(self, action: #selector(ReviewPhraseViewController.doneTapHandler), for: .touchUpInside)
    }
    
    private func addControls(){
        cardView?.addSubview(phrase!)
        cardView?.addSubview(meaning!)
        self.view.addSubview(cardView!)
        self.view.addSubview(flip!)
        self.view.addSubview(done!)
    }
    
    private func applyAutoLayout(){
        var viewDic: Dictionary<String,Any> = [:]
        viewDic["phrase"] = phrase!
        viewDic["meaning"] = meaning!
        viewDic["flip"] = flip!
        viewDic["done"] = done!
        viewDic["topLayoutGuide"] = topLayoutGuide
        viewDic["bottomLayoutGuide"] = bottomLayoutGuide
        viewDic["cardView"] = cardView!
        
        let buttonSize: CGFloat = 70.0
        
        let metrics = ["buttonSize":buttonSize]
        
        var constraintList: [NSLayoutConstraint] = []
        
        let hCardViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cardView]-[flip(buttonSize)]-|", options: [], metrics: metrics, views: viewDic)
        let vCardViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[cardView]-[done(buttonSize)]-[bottomLayoutGuide]", options: [], metrics: metrics, views: viewDic)
        
        let vFlipCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[flip(buttonSize)]", options: [], metrics: metrics, views: viewDic)
        
        let hPhraseCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|[phrase]|", options: [], metrics: nil, views: viewDic)
        let vPhraseCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:|[phrase]|", options: [], metrics: nil, views: viewDic)
        
        let hMeaningCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|[meaning]|", options: [], metrics: nil, views: viewDic)
        let vMeaningCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:|[meaning]|", options: [], metrics: nil, views: viewDic)
        
        constraintList += hCardViewCnst
        constraintList += vCardViewCnst
        constraintList += vFlipCnst
        constraintList += hPhraseCnst
        constraintList += vPhraseCnst
        constraintList += hMeaningCnst
        constraintList += vMeaningCnst
        
        
        self.view.addConstraint(NSLayoutConstraint(item: done!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view!, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: done!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize))
        
        
        NSLayoutConstraint.activate(constraintList)
    }
}
