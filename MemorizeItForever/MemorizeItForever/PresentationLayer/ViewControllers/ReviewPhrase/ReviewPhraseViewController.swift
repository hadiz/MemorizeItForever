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
    var labelHolder: UIView?
    var flip: UIButton?
    var done: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Review Phrases"
            
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(ReviewPhraseViewController.previousbarButtonTapHandler))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(ReviewPhraseViewController.nextbarButtonTapHandler))
        
        defineControls()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ReviewPhraseViewController.doubleTap))
        doubleTap.numberOfTapsRequired = 2
        labelHolder?.addGestureRecognizer(doubleTap)
        labelHolder?.backgroundColor = UIColor.yellow 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    func previousbarButtonTapHandler(){
    
    }
    
    func nextbarButtonTapHandler(){
        
    }
    
    func flipTapHandler(){
        
    }
    
    func doneTapHandler(){
        
    }
    
    func doubleTap(){
      UIView.transition(from: phrase!, to: meaning!, duration: 1, options: .transitionFlipFromRight, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    private func defineControls(){
        phrase = UILabel()
        phrase?.lineBreakMode = .byWordWrapping
        phrase?.numberOfLines = 0
        phrase?.textAlignment = .center
        phrase?.clipsToBounds = true
        phrase?.text = "phrase"
        
        meaning = UILabel()
        meaning?.lineBreakMode = .byWordWrapping
        meaning?.numberOfLines = 0
        meaning?.textAlignment = .center
        meaning?.text = "meaning"
        
        flip = MIButton()
        flip?.setTitle("Flip!", for: .normal)
        flip?.addTarget(self, action: #selector(ReviewPhraseViewController.flipTapHandler), for: .touchUpInside)
        
        done = MIButton()
        done?.setTitle("Done", for: .normal)
        done?.addTarget(self, action: #selector(ReviewPhraseViewController.doneTapHandler), for: .touchUpInside)
        
        labelHolder = MIView()
        labelHolder?.isUserInteractionEnabled = true
    }
}
