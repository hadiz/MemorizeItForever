//
//  TakeTestViewCoordinator.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/10/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class TakeTestViewCoordinator: UIViewCoordinatorDelegate{
    
    weak var viewController: TakeTestViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController as? TakeTestViewController
    }
    
    func defineControls() {
        guard let viewController = viewController else { return }
        
        viewController.setText = MISetView()
        viewController.setText.setFontSize(12)
        
        viewController.columnCounter = MILabel()
        
        viewController.showAnswer = MIButton()
        viewController.showAnswer.setTitle("Show Answer", for: .normal)
        viewController.showAnswer.addTarget(viewController, action: #selector(TakeTestViewController.showAnswerTapHandler), for: .touchUpInside)
        
        viewController.firstCardView = MICardView().initialize(phrase: "", meaning: "")
        
        viewController.secondCardView = MICardView().initialize(phrase: "", meaning: "")
        
        viewController.cardViewsDic[.current] = viewController.firstCardView
        viewController.cardViewsDic[.next] = viewController.secondCardView
        
        viewController.correct = MIButton()
        viewController.correct.setTitle("Correct", for: .normal)
        viewController.correct.addTarget(viewController, action: #selector(TakeTestViewController.correctTapHandler), for: .touchUpInside)
        viewController.correct.buttonColor = viewController.green
        
        viewController.wrong = MIButton()
        viewController.wrong.setTitle("Wrong", for: .normal)
        viewController.wrong.addTarget(viewController, action: #selector(TakeTestViewController.wrongTapHandler), for: .touchUpInside)
        viewController.wrong.buttonColor = viewController.red
    }
    
    func addControls() {
        guard let viewController = viewController else { return }
        
        viewController.view.addSubview(viewController.setText)
        viewController.view.addSubview(viewController.columnCounter)
        viewController.view.addSubview(viewController.showAnswer)
        viewController.view.addSubview(viewController.firstCardView)
        viewController.view.addSubview(viewController.secondCardView)
        viewController.view.addSubview(viewController.correct)
        viewController.view.addSubview(viewController.wrong)
    }
    
    func applyAutoLayout() {
        guard let viewController = viewController else { return }
        
        var viewDict = viewController.getViewDict()
        
        var constraintList: [NSLayoutConstraint] = []
        
        viewDict["setText"] = viewController.setText
        viewDict["columnCounter"] = viewController.columnCounter
        viewDict["showAnswer"] = viewController.showAnswer
        viewDict["correct"] = viewController.correct
        viewDict["wrong"] = viewController.wrong
        
        let buttonSize: CGFloat = 84.0
        let metrics = ["buttonSize":buttonSize]
        
        let hSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[setText]", options: [], metrics: nil, views: viewDict)
        
        let vSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[setText(21.5)]-1-[showAnswer(buttonSize)]", options: [], metrics: metrics, views: viewDict)
        
        let vSetTextCnst1 = NSLayoutConstraint.constraints(withVisualFormat: "V:[correct(buttonSize)]-1-[bottomLayoutGuide]", options: [], metrics: metrics, views: viewDict)
        
        let hColumnCounterCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:[columnCounter]-|", options: [], metrics: nil, views: viewDict)
        let vColumnCounterCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[columnCounter(21.5)]", options: [], metrics: nil, views: viewDict)
        
        let vWrongCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[wrong(buttonSize)]-1-[bottomLayoutGuide]", options: [], metrics: metrics, views: viewDict)
        
        constraintList += hSetTextCnst
        constraintList += vSetTextCnst
        constraintList += hColumnCounterCnst
        constraintList += vColumnCounterCnst
        constraintList += vWrongCnst
        constraintList += vSetTextCnst1
        
        let hShowAnswerCnst = NSLayoutConstraint(item: viewController.showAnswer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hShowAnswerWidthCnst = NSLayoutConstraint(item: viewController.showAnswer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
        let vSecondCardViewTopCnst = NSLayoutConstraint(item: viewController.secondCardView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let hSecondCardViewWidthCnst = NSLayoutConstraint(item: viewController.secondCardView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        
        let vSecondCardViewHeightCnst = NSLayoutConstraint(item: viewController.secondCardView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: viewController.firstCardView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        
        let hCorrectCnst = NSLayoutConstraint(item: viewController.correct, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.centerX, multiplier: 3/2, constant: 0)
        
        let hCorrectWidthCnst = NSLayoutConstraint(item: viewController.correct, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
        let hWrongCnst = NSLayoutConstraint(item: viewController.wrong, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: viewController.view, attribute: NSLayoutAttribute.centerX, multiplier: 1/2, constant: 0)
        
        let hWrongWidthCnst = NSLayoutConstraint(item: viewController.wrong, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
        constraintList.append(hShowAnswerCnst)
        constraintList.append(hShowAnswerWidthCnst)
        constraintList.append(vSecondCardViewTopCnst)
        constraintList.append(hSecondCardViewWidthCnst)
        constraintList.append(vSecondCardViewHeightCnst)
        constraintList.append(hCorrectCnst)
        constraintList.append(hCorrectWidthCnst)
        constraintList.append(hWrongCnst)
        constraintList.append(hWrongWidthCnst)
        
        NSLayoutConstraint.activate(constraintList)
        
        viewController.updateConstraint()
    }

}
