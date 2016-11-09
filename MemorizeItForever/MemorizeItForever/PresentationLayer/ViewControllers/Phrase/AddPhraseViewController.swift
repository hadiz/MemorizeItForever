//
//  AddPhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class AddPhraseViewController: VFLBasedViewController, UIPopoverPresentationControllerDelegate {

    var desc: UILabel!
    var phrase: MITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Phrase"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddPhraseViewController.doneBarButtonTapHandler))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(AddPhraseViewController.nextBarButtonTapHandler))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func doneBarButtonTapHandler(){
        
    }
    
    func nextBarButtonTapHandler(){
       let result = phrase.validate { () -> Bool in
            !phrase.text.isEmpty
        }
        print(result)
    }
    
    override func defineControls(){
        desc = MILabel()
        desc.text = "Write the Phrase here"
        
        phrase = MITextView()
        phrase.layer.borderColor = UIColor.lightGray.cgColor
        phrase.layer.borderWidth = 1.0
        phrase.layer.cornerRadius = 20.0
        phrase.alpha = 0.7
    }
    
     override func addControls(){
        self.view.addSubview(desc)
        self.view.addSubview(phrase)
    }
    
    override func applyAutoLayout(){
        var constraintList: [NSLayoutConstraint] = []
        
        viewDic["desc"] = desc
        viewDic["phrase"] = phrase
        
        let hDescCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[desc]", options: [], metrics: nil, views: viewDic)
        let vDescCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[desc(21.5)]-[phrase]-30-[bottomLayoutGuide]", options: [], metrics: nil, views: viewDic)
        
        let hPhraseCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[phrase]-|", options: [], metrics: nil, views: viewDic)


        constraintList += hDescCnst
        constraintList += vDescCnst
        
        constraintList += hPhraseCnst
        
         NSLayoutConstraint.activate(constraintList)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

