//
//  ReviewPhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/25/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class ReviewPhraseViewController: VFLBasedViewController, UIPopoverPresentationControllerDelegate, UIGestureRecognizerDelegate {
    
    // MARK: Constant
    
    private let changeTextTransition = "ChangeTextTransition"
    private let cardViewsDicFatalError = "CardViewsDic does not have all card situation"
    
    // MARK: Controls
    
    var setText: MISetView!
    var counter: UILabel!
    var switchText: UILabel!
    var frontBackswitch: UISwitch!
    var firstCardView: MICardView!
    var secondCardView: MICardView!
    var thidCardView: MICardView!
    var flip: UIButton!
    var done: UIButton!
    
    // MARK: Private Variables
    
    private var nextCardLeadingCnst: NSLayoutConstraint!
    private var previousCardTrailingCnst: NSLayoutConstraint!
    private var currentCardLeadingCnst: NSLayoutConstraint!
    private var currentCardTrailingCnst: NSLayoutConstraint!
    private var panningGesture: UIPanGestureRecognizer!
    private var list: [WordModel] = []
    private var index = 0
    private var showFront = true
    private var cardViewsDic: Dictionary<CardViewPosition, MICardView> = [:]
    private var cardViewCenter: CGFloat?
    private var isTaskDone = false
    
    // MARK: Field injection
    
    var wordFlowManager: WordFlowManagerProtocol?
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initial()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        cardViewCenter = current.center.x
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.removeTaskDoneView()
        isTaskDone = false
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func defineControls(){
        
        setText = MISetView()
        setText.setFontSize(12)
        
        counter = MILabel()
        
        switchText = MILabel()
        
        frontBackswitch = MISwitch()
        frontBackswitch.isOn = true
        frontBackswitch.addTarget(self, action: #selector(ReviewPhraseViewController.frontBackswitchAction), for: UIControlEvents.valueChanged)
        
        firstCardView = MICardView().initialize(phrase: "", meaning: "")
        secondCardView = MICardView().initialize(phrase: "", meaning: "")
        thidCardView = MICardView().initialize(phrase: "", meaning: "")
        
        cardViewsDic[.current] = firstCardView
        cardViewsDic[.next] = secondCardView
        cardViewsDic[.previous] = thidCardView
        
        flip = MIButton()
        flip.setTitle("Flip", for: .normal)
        flip.addTarget(self, action: #selector(ReviewPhraseViewController.flipTapHandler), for: .touchUpInside)
        
        done = MIButton()
        done.setTitle("Done", for: .normal)
        done.addTarget(self, action: #selector(ReviewPhraseViewController.doneTapHandler), for: .touchUpInside)
    }
    
    override func addControls(){
        self.view.addSubview(setText)
        self.view.addSubview(firstCardView)
        self.view.addSubview(secondCardView)
        self.view.addSubview(thidCardView)
        self.view.addSubview(flip)
        self.view.addSubview(done)
        self.view.addSubview(counter)
        self.view.addSubview(switchText)
        self.view.addSubview(frontBackswitch)
    }
    
    override func applyAutoLayout(){
        var constraintList: [NSLayoutConstraint] = []
        
        viewDic["switchText"] = switchText
        viewDic["frontBackswitch"] = frontBackswitch
        viewDic["counter"] = counter
        viewDic["flip"] = flip
        viewDic["done"] = done
        viewDic["currentCardView"] = firstCardView
        viewDic["setText"] = setText
        
        let buttonSize: CGFloat = 70.0
        
        let metrics = ["buttonSize":buttonSize]
        
        let hSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[setText]", options: [], metrics: nil, views: viewDic)
        
        let vSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[setText(21.5)]", options: [], metrics: nil, views: viewDic)
        
        let hCardViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:[flip(buttonSize)]-|", options: [], metrics: metrics, views: viewDic)
        let vCardViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[counter(21.5)]-[currentCardView]-[done(buttonSize)]-[bottomLayoutGuide]", options: [], metrics: metrics, views: viewDic)
        
        let vFlipCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[flip(buttonSize)]", options: [], metrics: metrics, views: viewDic)
        
        constraintList += hCardViewCnst
        constraintList += vCardViewCnst
        constraintList += vFlipCnst
        constraintList += hSetTextCnst
        constraintList += vSetTextCnst
        
        let hCounterCnst = NSLayoutConstraint(item: counter, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hDoneCnst = NSLayoutConstraint(item: done, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hDoneWidthCnst = NSLayoutConstraint(item: done, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
        let hFrontBackswitchCnst = NSLayoutConstraint(item: frontBackswitch, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: flip, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hSwitchTextCnst = NSLayoutConstraint(item: switchText, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: frontBackswitch, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let vSwitchTextCnst = NSLayoutConstraint(item: switchText, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: -15)
        
        let vFrontBackswitchCnst = NSLayoutConstraint(item: frontBackswitch, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 15)
        
        let vSecondCardViewTopCnst = NSLayoutConstraint(item: secondCardView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let hSecondCardViewWidthCnst = NSLayoutConstraint(item: secondCardView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        
        let vSecondCardViewHeightCnst = NSLayoutConstraint(item: secondCardView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        
        let vThirdCardViewTopCnst = NSLayoutConstraint(item: thidCardView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let hThirdCardViewWidthCnst = NSLayoutConstraint(item: thidCardView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        
        let vThirdCardViewHeightCnst = NSLayoutConstraint(item: thidCardView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        
        nextCardLeadingCnst = NSLayoutConstraint(item: secondCardView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        previousCardTrailingCnst = NSLayoutConstraint(item: thidCardView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        
        currentCardLeadingCnst = NSLayoutConstraint(item: firstCardView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 8)
        
        currentCardTrailingCnst = NSLayoutConstraint(item: firstCardView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: flip, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -8)
        
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
        constraintList.append(nextCardLeadingCnst)
        constraintList.append(previousCardTrailingCnst)
        constraintList.append(currentCardLeadingCnst)
        constraintList.append(currentCardTrailingCnst)
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    // MARK: Internal Methods
    
    func previousbarButtonTapHandler(){
        if !isTaskDone{
            swapCards(direction: .right)
        }
    }
    
    func nextbarButtonTapHandler(){
        if !isTaskDone{
            swapCards(direction: .left)
        }
    }
    
    func flipTapHandler(){
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        current.flip()
    }
    
    func doneTapHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func panningHandler(recognizer: UIPanGestureRecognizer){
        if !isTaskDone{
            panning(recognizer: recognizer)
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func frontBackswitchAction(_ sender: UISwitch){
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        showFront = sender.isOn
        updateAnimation()
        updateSwitchText()
        current.flipIfNeeded(showingPhrase: showFront)
    }
    
    // MARK: Private Methods
    
    private func initial(){
        self.title = "Review Phrases"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(ReviewPhraseViewController.previousbarButtonTapHandler))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(ReviewPhraseViewController.nextbarButtonTapHandler))
        
        panningGesture = UIPanGestureRecognizer(target: self, action: #selector(ReviewPhraseViewController.panningHandler))
        self.view.addGestureRecognizer(panningGesture!)
        updateSwitchText()
        self.view.sendSubview(toBack: switchText)
    }
    
    private func swipe(speed: CGFloat){
        if speed > 0{
            swapCards(direction: .right)
        }
        else{
            swapCards(direction: .left)
        }
    }
    
    private func pan(){
        guard let current = cardViewsDic[.current], let previous = cardViewsDic[.previous], let next = cardViewsDic[.next] else {
            fatalError(cardViewsDicFatalError)
        }
        if current.center.x > self.view.layer.frame.width{
            swapCards(direction: .right)
        }
        else if current.center.x < 0{
            self.swapCards(direction: .left)
        }
        else{
            animate(){
                current.center.x = self.cardViewCenter!
                next.layer.frame.origin.x = self.view.layer.frame.width
                previous.layer.frame.origin.x = -1 * current.layer.frame.width
            }
        }
    }
    
    private func swapCards(direction: SwipeDirection){
        switch direction {
        case .left:
            swipeCardLeft()
        case .right:
            swipeCardRight()
        default:
            break
        }
        
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        updateCounter()
        current.changeFrontIfNeeded(showingPhrase: showFront)
        updateConstraint()
    }
    
    private func swipeCardLeft(){
        updateIndex(incremental: true)
        
        let tempCardView = cardViewsDic[.current]
        cardViewsDic[.current] = cardViewsDic[.next]
        cardViewsDic[.next] = cardViewsDic[.previous]
        cardViewsDic[.previous] = tempCardView
        
        guard let current = cardViewsDic[.current], let previous = cardViewsDic[.previous], let next = cardViewsDic[.next] else {
            fatalError(cardViewsDicFatalError)
        }
        
        let nextIndex = getNextIndex()
        next.updateText(phrase: list[nextIndex].phrase!, meaning: list[nextIndex].meaning!)
        
        animate(){
            current.center.x = self.cardViewCenter!
            previous.layer.frame.origin.x = -1 * current.layer.frame.width
        }
    }
    
    private func swipeCardRight(){
        updateIndex(incremental: false)
        
        let tempCardView = cardViewsDic[.current]
        cardViewsDic[.current] = cardViewsDic[.previous]
        cardViewsDic[.previous] = cardViewsDic[.next]
        cardViewsDic[.next] = tempCardView
        
        guard let current = cardViewsDic[.current], let previous = cardViewsDic[.previous], let next = cardViewsDic[.next] else {
            fatalError(cardViewsDicFatalError)
        }
        
        let nextIndex = getPreviousIndex()
        previous.updateText(phrase: list[nextIndex].phrase!, meaning: list[nextIndex].meaning!)
        
        animate(){
            current.center.x = self.cardViewCenter!
            next.layer.frame.origin.x = self.view.layer.frame.width
        }
    }
    
    private func updateConstraint(){
        guard let current = cardViewsDic[.current], let previous = cardViewsDic[.previous], let next = cardViewsDic[.next] else {
            fatalError(cardViewsDicFatalError)
        }
        var constraintList: [NSLayoutConstraint] = []
        
        self.view.removeConstraint(nextCardLeadingCnst)
        self.view.removeConstraint(previousCardTrailingCnst)
        self.view.removeConstraint(currentCardLeadingCnst)
        self.view.removeConstraint(currentCardTrailingCnst)
        
        nextCardLeadingCnst = NSLayoutConstraint(item: next, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        previousCardTrailingCnst = NSLayoutConstraint(item: previous, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        
        currentCardLeadingCnst = NSLayoutConstraint(item: current, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 8)
        
        currentCardTrailingCnst = NSLayoutConstraint(item: current, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: flip, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: -8)
        
        constraintList.append(nextCardLeadingCnst)
        constraintList.append(previousCardTrailingCnst)
        constraintList.append(currentCardLeadingCnst)
        constraintList.append(currentCardTrailingCnst)
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    private func animate(animations: @escaping () -> Swift.Void){
        UIView.animate(withDuration: 0.2){
            animations()
        }
    }
    
    private func updateIndex(incremental: Bool){
        if incremental{
            index += 1
            if index > list.count - 1{
                index = 0
            }
        }
        else{
            index -= 1
            if index < 0{
                index = list.count - 1
            }
        }
    }
    
    private func updateCounter(){
        counter.text = "\(index + 1) / \(list.count)"
    }
    
    private func updateSwitchText(){
        if showFront{
            switchText.text = "Show back"
        }
        else{
            switchText.text = "Show front"
        }
    }
    
    private func updateAnimation(){
        switchText.layer.removeAnimation(forKey: changeTextTransition)
        let animation = CATransition()
        animation.duration = 0.5
        animation.type = kCATransitionPush
        animation.subtype = showFront ? kCATransitionFromLeft : kCATransitionFromRight
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        switchText.layer.add(animation, forKey: changeTextTransition)
    }
    
    private func getNextIndex() -> Int{
        return index + 1 > list.count - 1 ?  0 : index + 1
    }
    
    private func getPreviousIndex() -> Int{
        return index - 1 < 0 ?  list.count - 1 : index - 1
    }
    
    private func fetchData(){
        guard let wordFlowManager = wordFlowManager else{
            fatalError("wordFlowManager is not initialized")
        }
        do{
            try wordFlowManager.fetchNewWordsToPutInPreColumn()
            list = try wordFlowManager.fetchWordsForReview()
//                        for i in 1...10{
//                            var word = WordModel()
//                            word.meaning = "Meaning \(i)"
//                            word.phrase = "Phrase \(i)"
//                            list.append(word)
//                        }
            if list.count > 0{
                assignWordToCard()
                updateCounter()
            }
            else{
                taskDoneView()
            }
        }
        catch{
            
        }
    }
    
    private func assignWordToCard(){
        guard let current = cardViewsDic[.current], let previous = cardViewsDic[.previous], let next = cardViewsDic[.next] else {
            fatalError(cardViewsDicFatalError)
        }
        
        current.updateText(phrase: list[index].phrase!, meaning: list[index].meaning!)
        let nextIndex = getNextIndex()
        next.updateText(phrase: list[nextIndex].phrase!, meaning: list[nextIndex].meaning!)
        let previousIndex = getPreviousIndex()
        previous.updateText(phrase: list[previousIndex].phrase!, meaning: list[previousIndex].meaning!)
    }
    
    private func panning(recognizer: UIPanGestureRecognizer){
        guard let current = cardViewsDic[.current], let previous = cardViewsDic[.previous], let next = cardViewsDic[.next] else {
            fatalError(cardViewsDicFatalError)
        }
        
        if recognizer.state == .changed{
            let translation = recognizer.translation(in: recognizer.view?.superview)
            current.center.x += translation.x
            previous.center.x += translation.x
            next.center.x += translation.x
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view?.superview)
        }
        else if recognizer.state == .ended{
            let speed = recognizer.velocity(in: recognizer.view?.superview).x
            if speed > 50 || speed < -50{
                swipe(speed: speed)
            }
            else{
                pan()
            }
        }
    }
    
    private func taskDoneView(){
        isTaskDone = true
        let taskDoneView = self.addTaskDoneView()
        
        viewDic["taskDoneView"] = taskDoneView
        
        
        let hTaskDoneViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|[taskDoneView]|", options: [], metrics: nil, views: viewDic)
        
        let vTaskDoneViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide][taskDoneView]-[done]", options: [], metrics: nil, views: viewDic)
        
        
        var constraintList: [NSLayoutConstraint] = []
        
        constraintList += hTaskDoneViewCnst
        constraintList += vTaskDoneViewCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
}
