//
//  AddPhraseViewCoordinator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/7/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class AddPhraseViewCoordinator: UIViewCoordinatorDelegate {
    
    weak var viewController: AddPhraseViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController as? AddPhraseViewController
    }
    
    func defineControls() {
        guard let viewController = viewController else {return}
        
        viewController.setText = MISetView()
        viewController.setText.setFontSize(12)
        
        viewController.desc = MILabel()
        viewController.desc.text = "Write the Phrase here"
        
        viewController.phrase = MITextView()
        viewController.phrase.font = viewController.phrase.font?.withSize(20)
        viewController.phrase.alpha = 0.7
        
        viewController.meaning = MITextView()
        viewController.meaning.isHidden = true
        viewController.meaning.font = viewController.meaning.font?.withSize(20)
        viewController.meaning.alpha = 0.7
    }
    
    func addControls() {
        guard let viewController = viewController else {return}
        
        viewController.view.addSubview(viewController.setText)
        viewController.view.addSubview(viewController.desc)
        viewController.view.addSubview(viewController.phrase)
        viewController.view.addSubview(viewController.meaning)
    }
    
    func applyAutoLayout() {
        guard let viewController = viewController else {return}
        
        var constraintList: [NSLayoutConstraint] = []
        var viewDict = viewController.getViewDict()
        viewDict["desc"] = viewController.desc
        viewDict["phrase"] = viewController.phrase
        viewDict["meaning"] = viewController.meaning
        viewDict["setText"] = viewController.setText
        
        let hDescCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[desc]", options: [], metrics: nil, views: viewDict)
        let vDescCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[desc(21.5)]-[phrase]-30-[bottomLayoutGuide]", options: [], metrics: nil, views: viewDict)
        
        let hPhraseCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[phrase]-|", options: [], metrics: nil, views: viewDict)
        
        let hMeaningCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[meaning]-|", options: [], metrics: nil, views: viewDict)
        
        let hSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:[setText]-|", options: [], metrics: nil, views: viewDict)
        let vSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[setText(21.5)]", options: [], metrics: nil, views: viewDict)
        
        constraintList += hDescCnst
        constraintList += vDescCnst
        constraintList += hPhraseCnst
        constraintList += hMeaningCnst
        constraintList += hSetTextCnst
        constraintList += vSetTextCnst
        
        let meaningTopCnst = NSLayoutConstraint(item: viewController.meaning, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: viewController.phrase, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let meaningBottomCnst = NSLayoutConstraint(item: viewController.meaning, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: viewController.phrase, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        
        constraintList.append(meaningTopCnst)
        constraintList.append(meaningBottomCnst)
        
        NSLayoutConstraint.activate(constraintList)
    }
    
}
