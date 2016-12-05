//
//  TakeTestViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/21/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

class TakeTestViewController: VFLBasedViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: Controls
    
    var setText: MISetView!
    var columnCounter: UILabel!
    var showAnswer: UIButton!
    var firstCardView: MICardView!
    var secondCardView: MICardView!
    var correct: MIButton!
    var wrong: MIButton!
    
    // MARK: Field injection
    
    var wordFlowManager: WordFlowManagerProtocol?
    
    // MARK: Local Variables
    
    private var nextCardLeadingCnst: NSLayoutConstraint!
    private var currentCardTopCnst: NSLayoutConstraint!
    private var currentCardBottomCnst: NSLayoutConstraint!
    private var currentCardLeadingCnst: NSLayoutConstraint!
    private var currentCardTrailingCnst: NSLayoutConstraint!
    private var cardViewsDic: Dictionary<CardViewPosition, MICardView> = [:]
    private var cardViewCenter: CGPoint?
    private var showAnswerFlag = true
    private var panningGesture: UIPanGestureRecognizer!
    private var listIndex = 0
    private var dicIndex: Int16 = 5
    private var columnDic: Dictionary<Int16,[WordInProgressModel]> = [:]
    private var isTaskDone = false
    private var currentWordInProgressModel: WordInProgressModel!
    
    // MARK: Constants
    
    private let cardViewsDicFatalError = "CardViewsDic does not have all card situation"
    private let changeTextTransition = "ChangeTextTransition"
    private let green = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
    private let red = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Take a Test"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(TakeTestViewController.doneBarButtonTapHandler))
        panningGesture = UIPanGestureRecognizer(target: self, action: #selector(TakeTestViewController.panningHandler))
        self.view.addGestureRecognizer(panningGesture!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        cardViewCenter = current.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.clear
        self.removeTaskDoneView()
        isTaskDone = false
        listIndex = 0
        dicIndex = 5
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func defineControls() {
        setText = MISetView()
        setText.setFontSize(12)
        
        columnCounter = MILabel()
        
        showAnswer = MIButton()
        showAnswer.setTitle("Show Answer", for: .normal)
        showAnswer.addTarget(self, action: #selector(TakeTestViewController.showAnswerTapHandler), for: .touchUpInside)
        
        firstCardView = MICardView().initialize(phrase: "", meaning: "")
        
        secondCardView = MICardView().initialize(phrase: "", meaning: "")
        
        cardViewsDic[.current] = firstCardView
        cardViewsDic[.next] = secondCardView
        
        correct = MIButton()
        correct.setTitle("Correct", for: .normal)
        correct.addTarget(self, action: #selector(TakeTestViewController.correctTapHandler), for: .touchUpInside)
        correct.buttonColor = green
        
        wrong = MIButton()
        wrong.setTitle("Wrong", for: .normal)
        wrong.addTarget(self, action: #selector(TakeTestViewController.wrongTapHandler), for: .touchUpInside)
        wrong.buttonColor = red
        
    }
    
    override func addControls() {
        self.view.addSubview(setText)
        self.view.addSubview(columnCounter)
        self.view.addSubview(showAnswer)
        self.view.addSubview(firstCardView)
        self.view.addSubview(secondCardView)
        self.view.addSubview(correct)
        self.view.addSubview(wrong)
    }
    
    override func applyAutoLayout() {
        var constraintList: [NSLayoutConstraint] = []
        
        viewDic["setText"] = setText
        viewDic["columnCounter"] = columnCounter
        viewDic["showAnswer"] = showAnswer
        viewDic["correct"] = correct
        viewDic["wrong"] = wrong
        
        let buttonSize: CGFloat = 84.0
        let metrics = ["buttonSize":buttonSize]
        
        let hSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[setText]", options: [], metrics: nil, views: viewDic)
        
        let vSetTextCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[setText(21.5)]-1-[showAnswer(buttonSize)]", options: [], metrics: metrics, views: viewDic)
        
        let vSetTextCnst1 = NSLayoutConstraint.constraints(withVisualFormat: "V:[correct(buttonSize)]-1-[bottomLayoutGuide]", options: [], metrics: metrics, views: viewDic)
        
        let hColumnCounterCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:[columnCounter]-|", options: [], metrics: nil, views: viewDic)
        let vColumnCounterCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[columnCounter(21.5)]", options: [], metrics: nil, views: viewDic)
        
        let vWrongCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[wrong(buttonSize)]-1-[bottomLayoutGuide]", options: [], metrics: metrics, views: viewDic)
        
        constraintList += hSetTextCnst
        constraintList += vSetTextCnst
        constraintList += hColumnCounterCnst
        constraintList += vColumnCounterCnst
        constraintList += vWrongCnst
        constraintList += vSetTextCnst1
        
        let hShowAnswerCnst = NSLayoutConstraint(item: showAnswer, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        
        let hShowAnswerWidthCnst = NSLayoutConstraint(item: showAnswer, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
        let vSecondCardViewTopCnst = NSLayoutConstraint(item: secondCardView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        
        let hSecondCardViewWidthCnst = NSLayoutConstraint(item: secondCardView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        
        let vSecondCardViewHeightCnst = NSLayoutConstraint(item: secondCardView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: firstCardView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        
        let hCorrectCnst = NSLayoutConstraint(item: correct, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 3/2, constant: 0)
        
        let hCorrectWidthCnst = NSLayoutConstraint(item: correct, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
        let hWrongCnst = NSLayoutConstraint(item: wrong, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1/2, constant: 0)
        
        let hWrongWidthCnst = NSLayoutConstraint(item: wrong, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: buttonSize)
        
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
        
        updateConstraint()
    }
    
    // MARK: Internal Methods
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func doneBarButtonTapHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAnswerTapHandler(){
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        current.flip()
        var title = "Show Answer"
        if showAnswerFlag{
            title = "Show Question"
        }
        
        animate(animations: {
            self.showAnswer.titleLabel?.alpha = 0
        }) {
            self.showAnswer.setTitle(title, for: UIControlState.normal)
            self.showAnswer.titleLabel?.alpha = 1
        }
        showAnswerFlag = !showAnswerFlag
    }
    
    func correctTapHandler(){
        guard let wordFlowManager = wordFlowManager else{
            fatalError("wordFlowManager is not initialized")
        }
            wordFlowManager.answerCorrectly(currentWordInProgressModel)
            swipeCard(direction: .up)
    }
    func wrongTapHandler(){
        guard let wordFlowManager = wordFlowManager else{
            fatalError("wordFlowManager is not initialized")
        }
            wordFlowManager.answerWrongly(currentWordInProgressModel)
            swipeCard(direction: .down)
    }
    
    func panningHandler(recognizer: UIPanGestureRecognizer){
        if !isTaskDone{
            panning(recognizer: recognizer)
        }
    }
    
    // MARK: Private Methods
    
    private func pan(){
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        if current.center.y > self.view.layer.frame.height{
            swipeCard(direction: .down)
        }
        else if current.center.y < setText.layer.frame.origin.y{
            self.swipeCard(direction: .up)
        }
        else{
            animate(){
                current.center.y = self.cardViewCenter!.y
                self.view.backgroundColor = UIColor.clear
            }
        }
    }
    
    private func animate(animations: @escaping () -> Swift.Void){
        
        animate(animations: {
            animations()
        }) {
        }
    }
    
    private func animate(animations: @escaping () -> Swift.Void, completion: @escaping () -> Swift.Void){
        UIView.animate(withDuration: 0.2, animations: {
            animations()
        }) { (complete) in
            completion()
        }
    }
    
    private func changeColor(distance: CGFloat){
        if  distance > 0{
            self.view.backgroundColor = green.withAlphaComponent(distance / 100)
        }
        else{
            self.view.backgroundColor = red.withAlphaComponent((-1 * distance) / 100)
        }
    }
    
    private func swipe(speed: CGFloat){
        if speed > 0{
            swipeCard(direction: .down)
        }
        else{
            swipeCard(direction: .up)
        }
    }
    
    private func swipeCard(direction: SwipeDirection){
        switch direction {
        case .up:
            swipeCardUp()
        case .down:
            swipeCardDown()
        default:
            break
        }
        if !showAnswerFlag{
            showAnswerTapHandler()
        }
    }
    
    private func swipeCardUp(){
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        
        animate(animations: {
            current.layer.frame.origin.y = -current.layer.frame.height
            self.view.backgroundColor = self.green
            
        }) {
            self.swipeCardLeft()
        }
        
    }
    
    private func swipeCardDown(){
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        animate(animations: {
            current.layer.frame.origin.y = self.view.layer.frame.height
            self.view.backgroundColor = self.red
            
        }) {
            self.swipeCardLeft()
        }
        
    }
    
    private func swipeCardLeft(){
        
        let tempCardView = cardViewsDic[.current]
        cardViewsDic[.current] = cardViewsDic[.next]
        cardViewsDic[.next] = tempCardView
        
        guard let current = cardViewsDic[.current] else {
            fatalError(cardViewsDicFatalError)
        }
        
        //        next.updateText(phrase: list[index + 1]![0], meaning: list[index + 1]![1])
        assignWordToCard()
        
        animate(){
            current.center.x = self.cardViewCenter!.x
            self.view.backgroundColor = UIColor.clear
        }
        updateConstraint()
    }
    
    private func updateConstraint(){
        clearConstraint()
        appendConstraint()
    }
    
    private func clearConstraint(){
        guard nextCardLeadingCnst != nil && currentCardLeadingCnst != nil && currentCardTrailingCnst != nil && currentCardTopCnst != nil && currentCardBottomCnst != nil else {
            return
        }
        self.view.removeConstraint(nextCardLeadingCnst)
        self.view.removeConstraint(currentCardLeadingCnst)
        self.view.removeConstraint(currentCardTrailingCnst)
        self.view.removeConstraint(currentCardTopCnst)
        self.view.removeConstraint(currentCardBottomCnst)
    }
    
    private func appendConstraint(){
        guard let current = cardViewsDic[.current], let next = cardViewsDic[.next] else {
            fatalError(cardViewsDicFatalError)
        }
        
        var constraintList: [NSLayoutConstraint] = []
        
        nextCardLeadingCnst = NSLayoutConstraint(item: next, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        currentCardLeadingCnst = NSLayoutConstraint(item: current, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 8)
        
        currentCardTrailingCnst = NSLayoutConstraint(item: current, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -8)
        
        currentCardTopCnst = NSLayoutConstraint(item: current, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: showAnswer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 1)
        
        currentCardBottomCnst = NSLayoutConstraint(item: current, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: correct, attribute: NSLayoutAttribute.top, multiplier: 1, constant: -1)
        
        constraintList.append(nextCardLeadingCnst)
        constraintList.append(currentCardLeadingCnst)
        constraintList.append(currentCardTrailingCnst)
        constraintList.append(currentCardTopCnst)
        constraintList.append(currentCardBottomCnst)
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    private func fetchData(){
        guard let wordFlowManager = wordFlowManager else{
            fatalError("wordFlowManager is not initialized")
        }
        do{
            let wordInProgressList = try wordFlowManager.fetchWordsToExamin()
            //            var wordInProgressList: [WordInProgressModel] = []
            //            for i in 0..<10{
            //                var word = WordModel()
            //                word.meaning = "Meaning \(i)"
            //                word.phrase = "Phrase \(i)"
            //                var win = WordInProgressModel()
            //                win.column = Int16(i / 2)
            //                win.date = Date()
            //                win.word = word
            //                wordInProgressList.append(win)
            //            }
            
            for i: Int16 in 0...5{
                columnDic[i] = wordInProgressList.filter(){$0.column == i}
            }
            if wordInProgressList.count > 0{
                assignWordToCard()
            }
            else{
                taskDoneView()
            }
        }
        catch{
            
        }
    }
    
    private func assignWordToCard(){
        guard let current = cardViewsDic[.current]else {
            fatalError(cardViewsDicFatalError)
        }
        
        if dicIndex >= 0 {
            let list = columnDic[dicIndex]
            if listIndex < list!.count{
                let wordInProgress = list![listIndex]
                currentWordInProgressModel = wordInProgress
                current.updateText(phrase: wordInProgress.word!.phrase!, meaning: wordInProgress.word!.meaning!)
                updateColumnCounter()
                changeCardViewFront(cardView: current)
                listIndex += 1
            }
            else{
                dicIndex -= 1
                listIndex = 0
                assignWordToCard()
            }
        }
        else{
            taskDoneView()
        }
    }
    
    private func updateColumnCounter(){
        guard let list = columnDic[dicIndex] else {
            return
        }
        columnCounter.text = "\(listIndex + 1) / \(list.count) in Column \(dicIndex)"
    }
    
    private func changeCardViewFront(cardView: MICardView){
        let wordSwitching = (UserDefaults.standard.object(forKey: Settings.wordSwitching.rawValue) as? Bool) ?? false
        var showingPhrase = true
        
        if wordSwitching && dicIndex % 2 != 0{
            showingPhrase = false
        }
        
        cardView.changeFrontIfNeeded(showingPhrase: showingPhrase)
    }
    
    func panning(recognizer: UIPanGestureRecognizer){
        guard let current = cardViewsDic[.current]else {
            fatalError(cardViewsDicFatalError)
        }
        
        if recognizer.state == .changed{
            let translation = recognizer.translation(in: recognizer.view?.superview)
            current.center.y += translation.y
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view?.superview)
            
            let distance = cardViewCenter!.y - current.center.y
            changeColor(distance: distance)
        }
        else if recognizer.state == .ended{
            let speed = recognizer.velocity(in: recognizer.view?.superview).y
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
        
        let vTaskDoneViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide][taskDoneView]|", options: [], metrics: nil, views: viewDic)
        
        
        var constraintList: [NSLayoutConstraint] = []
        
        constraintList += hTaskDoneViewCnst
        constraintList += vTaskDoneViewCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
}
