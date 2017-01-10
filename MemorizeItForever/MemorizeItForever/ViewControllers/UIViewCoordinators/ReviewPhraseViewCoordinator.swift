//
//  ReviewPhraseViewCoordinator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/10/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class ReviewPhraseViewCoordinator: UIViewCoordinatorDelegate{
    
    weak var viewController: ReviewPhraseViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController as? ReviewPhraseViewController
    }
    
    func defineControls() {
        guard let viewController = viewController else { return }
        
        viewController.setText = MISetView()
        viewController.setText.setFontSize(12)
        
        viewController.counter = MILabel()
        
        viewController.switchText = MILabel()
        
        viewController.frontBackswitch = MISwitch()
        viewController.frontBackswitch.isOn = true
        viewController.frontBackswitch.addTarget(viewController, action: #selector(ReviewPhraseViewController.frontBackswitchAction), for: UIControlEvents.valueChanged)
        
        viewController.firstCardView = MICardView().initialize(phrase: "", meaning: "")
        viewController.secondCardView = MICardView().initialize(phrase: "", meaning: "")
        viewController.thidCardView = MICardView().initialize(phrase: "", meaning: "")
        
        viewController.cardViewsDic[.current] = viewController.firstCardView
        viewController.cardViewsDic[.next] = viewController.secondCardView
        viewController.cardViewsDic[.previous] = viewController.thidCardView
        
        viewController.flip = MIButton()
        viewController.flip.setTitle("Flip", for: .normal)
        viewController.flip.addTarget(viewController, action: #selector(ReviewPhraseViewController.flipTapHandler), for: .touchUpInside)
        
        viewController.done = MIButton()
        viewController.done.setTitle("Close", for: .normal)
        viewController.done.addTarget(viewController, action: #selector(ReviewPhraseViewController.doneTapHandler), for: .touchUpInside)
    }
    
    func addControls() {
        guard let viewController = viewController else { return }
        
        viewController.view.addSubview(viewController.setText)
        viewController.view.addSubview(viewController.firstCardView)
        viewController.view.addSubview(viewController.secondCardView)
        viewController.view.addSubview(viewController.thidCardView)
        viewController.view.addSubview(viewController.flip)
        viewController.view.addSubview(viewController.done)
        viewController.view.addSubview(viewController.counter)
        viewController.view.addSubview(viewController.switchText)
        viewController.view.addSubview(viewController.frontBackswitch)
    }
    
    func applyAutoLayout() {
        guard let viewController = viewController else { return }
        
        var constraintList: [NSLayoutConstraint] = []
        var viewDict = viewController.getViewDict()
        
        viewDict["switchText"] = viewController.switchText
        viewDict["frontBackswitch"] = viewController.frontBackswitch
        viewDict["counter"] = viewController.counter
        viewDict["flip"] = viewController.flip
        viewDict["done"] = viewController.done
        viewDict["currentCardView"] = viewController.firstCardView
        viewDict["setText"] = viewController.setText
        
        let buttonSize: CGFloat = 70.0
        
        let metrics = ["buttonSize":buttonSize]
        
        let hSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[setText]", options: [], metrics: nil, views: viewDict)
        
        let vSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[setText(21.5)]", options: [], metrics: nil, views: viewDict)
        
        let hCardViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:[flip(buttonSize)]-|", options: [], metrics: metrics, views: viewDict)
        let vCardViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[counter(21.5)]-[currentCardView]-[done(buttonSize)]-[bottomLayoutGuide]", options: [], metrics: metrics, views: viewDict)
        
        let vFlipCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[flip(buttonSize)]", options: [], metrics: metrics, views: viewDict)
        
        constraintList += hCardViewCnst
        constraintList += vCardViewCnst
        constraintList += vFlipCnst
        constraintList += hSetTextCnst
        constraintList += vSetTextCnst
        
        let hCounterCnst = NSLayoutConstraint(item: viewController.counter, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hDoneCnst = NSLayoutConstraint(item: viewController.done, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hDoneWidthCnst = NSLayoutConstraint(item: viewController.done, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
        let hFrontBackswitchCnst = NSLayoutConstraint(item: viewController.frontBackswitch, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: viewController.flip, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hSwitchTextCnst = NSLayoutConstraint(item: viewController.switchText, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: viewController.frontBackswitch, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let vSwitchTextCnst = NSLayoutConstraint(item: viewController.switchText, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -15)
        
        let vFrontBackswitchCnst = NSLayoutConstraint(item: viewController.frontBackswitch, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 15)
        
        let vSecondCardViewTopCnst = NSLayoutConstraint(item: viewController.secondCardView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let hSecondCardViewWidthCnst = NSLayoutConstraint(item: viewController.secondCardView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        
        let vSecondCardViewHeightCnst = NSLayoutConstraint(item: viewController.secondCardView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        
        let vThirdCardViewTopCnst = NSLayoutConstraint(item: viewController.thidCardView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let hThirdCardViewWidthCnst = NSLayoutConstraint(item: viewController.thidCardView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        
        let vThirdCardViewHeightCnst = NSLayoutConstraint(item: viewController.thidCardView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        
        viewController.nextCardLeadingCnst = NSLayoutConstraint(item: viewController.secondCardView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        viewController.previousCardTrailingCnst = NSLayoutConstraint(item: viewController.thidCardView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        
        viewController.currentCardLeadingCnst = NSLayoutConstraint(item: viewController.firstCardView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 8)
        
        viewController.currentCardTrailingCnst = NSLayoutConstraint(item: viewController.firstCardView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: viewController.flip, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -8)
        
        constraintList.append(hCounterCnst)
        constraintList.append(hDoneCnst)
        constraintList.append(hDoneWidthCnst)
        constraintList.append(hFrontBackswitchCnst)
        constraintList.append(hSwitchTextCnst)
        constraintList.append(vSwitchTextCnst)
        constraintList.append(vFrontBackswitchCnst)
        constraintList.append(vSecondCardViewTopCnst)
        constraintList.append(hSecondCardViewWidthCnst)
        constraintList.append(vSecondCardViewHeightCnst)
        constraintList.append(vThirdCardViewTopCnst)
        constraintList.append(hThirdCardViewWidthCnst)
        constraintList.append(vThirdCardViewHeightCnst)
        constraintList.append(viewController.nextCardLeadingCnst)
        constraintList.append(viewController.previousCardTrailingCnst)
        constraintList.append(viewController.currentCardLeadingCnst)
        constraintList.append(viewController.currentCardTrailingCnst)
        
        NSLayoutConstraint.activate(constraintList)
    }
    
}
