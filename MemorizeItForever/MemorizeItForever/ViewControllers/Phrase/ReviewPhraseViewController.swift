//
//  ReviewPhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/25/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class ReviewPhraseViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIGestureRecognizerDelegate {
    
    // MARK: Constant
    private let changeTextTransition = "ChangeTextTransition"
    private let cardViewsDicFatalError = "CardViewsDic does not have all card situation"
    
    // MARK: Private Variables
    private var panningGesture: UIPanGestureRecognizer!
    private var list: [WordModel] = []
    private var index = 0
    private var showFront = true
    private var cardViewCenter: CGFloat?
    private var isTaskDone = false
    
    // MARK: Field injection
    var wordFlowService: WordFlowServiceProtocol!
    
    // MARK: Variables
    var cardViewsDic: Dictionary<CardViewPosition, MICardView> = [:]
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
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
        removeTaskDoneView()
        isTaskDone = false
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Internal Methods
    @objc func previousbarButtonTapHandler(){
        if !isTaskDone{
            swapCards(direction: .right)
        }
    }
    
    @objc func nextbarButtonTapHandler(){
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
    
    @objc func panningHandler(recognizer: UIPanGestureRecognizer){
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
    
    private func initialize(){
        
        let doneTitle = NSLocalizedString("Close", comment: "Close")
        done.setTitle(doneTitle, for: .normal)
        
        let flipTitle = NSLocalizedString("Flip", comment: "Flip")
        flip.setTitle(flipTitle, for: .normal)
        
        setText.setFontSize(12)
        setText.textDirextion = .leading
        
        frontBackswitch.isOn = true
        
        firstCardView.initialize(phrase: "", meaning: "")
        secondCardView.initialize(phrase: "", meaning: "")
        thidCardView.initialize(phrase: "", meaning: "")
        
        cardViewsDic[.current] = firstCardView
        cardViewsDic[.next] = secondCardView
        cardViewsDic[.previous] = thidCardView
        
        self.view.removeConstraint(nextCardLeadingCnst)
        self.view.removeConstraint(previousCardTrailingCnst)
        
        nextCardLeadingCnst = secondCardView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        previousCardTrailingCnst = thidCardView.trailingAnchor.constraint(equalTo: self.view.leadingAnchor)
        
        nextCardLeadingCnst.isActive = true
        previousCardTrailingCnst.isActive = true
        
        let previousTitle = NSLocalizedString("Previous", comment: "Previous")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: previousTitle, style: .plain, target: self, action: #selector(ReviewPhraseViewController.previousbarButtonTapHandler))
        
        let nextTitle = NSLocalizedString("Next", comment: "Next")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nextTitle, style: .plain, target: self, action: #selector(ReviewPhraseViewController.nextbarButtonTapHandler))
        
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
            animate(){ [unowned self] in
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
        
        animate(){ [unowned self] in
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
        
        animate(){ [unowned self] in
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
        
        nextCardLeadingCnst = next.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        previousCardTrailingCnst = previous.trailingAnchor.constraint(equalTo: self.view.leadingAnchor)
        currentCardLeadingCnst = current.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8)
        currentCardTrailingCnst = current.trailingAnchor.constraint(equalTo: flip.leadingAnchor, constant: -8)
        
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
            switchText.text = NSLocalizedString("Show back", comment: "Show back label")
        }
        else{
            switchText.text = NSLocalizedString("Show front", comment: "Show front label")
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
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: { [unowned self] in
            do{
                try self.wordFlowService.fetchNewWordsToPutInPreColumn()
//                self.list = try self.wordFlowService.fetchWordsForReview()
                                        for i in 1...10{
                                            var word = WordModel()
                                            word.meaning = "Meaning \(i)"
                                            word.phrase = "Phrase \(i)"
                                            self.list.append(word)
                                        }
                if self.list.count > 0{
                    DispatchQueue.main.async { [unowned self] in
                        self.assignWordToCard()
                        self.updateCounter()
                    }
                }
                else{
                    DispatchQueue.main.async { [unowned self] in
                        self.taskDoneView()
                    }
                }
            }
            catch{
                
            }
        })
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

        var constraintList: [NSLayoutConstraint] = []
        constraintList.append(taskDoneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraintList.append(taskDoneView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraintList.append(taskDoneView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor))
        constraintList.append(taskDoneView.bottomAnchor.constraint(equalTo: done.topAnchor, constant: -8))
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    // MARK: Controls and Actions
    @IBOutlet weak var setText: MISetView!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var switchText: UILabel!
    @IBOutlet weak var frontBackswitch: UISwitch!
    @IBOutlet weak var firstCardView: MICardView!
    @IBOutlet weak var secondCardView: MICardView!
    @IBOutlet weak var thidCardView: MICardView!
    @IBOutlet weak var flip: UIButton!
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var nextCardLeadingCnst: NSLayoutConstraint!
    
    @IBOutlet weak var previousCardTrailingCnst: NSLayoutConstraint!
    @IBOutlet weak var currentCardLeadingCnst: NSLayoutConstraint!
    @IBOutlet weak var currentCardTrailingCnst: NSLayoutConstraint!
    @IBAction func frontBackChanged(_ sender: UISwitch) {
        frontBackswitchAction(sender)
    }
    @IBAction func flipTapped(_ sender: Any) {
        flipTapHandler()
    }
    @IBAction func doneTapped(_ sender: Any) {
        doneTapHandler()
    }
}
