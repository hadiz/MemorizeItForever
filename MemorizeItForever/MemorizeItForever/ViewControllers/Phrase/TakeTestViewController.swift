//
//  TakeTestViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/21/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class TakeTestViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    
    // MARK: Field injection
    
    var wordFlowService: WordFlowServiceProtocol!
    var notificationFeedback: NotificationFeedbackProtocol?
    
    // MARK: Local Variables
    
    private var cardViewCenter: CGPoint?
    private var showAnswerFlag = true
    private var panningGesture: UIPanGestureRecognizer!
    private var listIndex = 0
    private var dicIndex: Int16 = 5
    private var columnDic: Dictionary<Int16,[WordInProgressModel]> = [:]
    private var isTaskDone = false
    private var currentWordInProgressModel: WordInProgressModel!
    
    // MARK: Variables
    
    var cardViewsDic: Dictionary<CardViewPosition, MICardView> = [:]
    
    // MARK: Constants
    private let showAnswerLocalized = NSLocalizedString("Show Answer", comment: "Show Answer")
    private let cardViewsDicFatalError = "CardViewsDic does not have all card situation"
    private let changeTextTransition = "ChangeTextTransition"
    let green = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
    let red = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        let closeTitle = NSLocalizedString("Close", comment: "Close")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: closeTitle, style: .plain, target: self, action: #selector(TakeTestViewController.doneBarButtonTapHandler))
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
        var title = showAnswerLocalized
        if showAnswerFlag{
            title = NSLocalizedString("Show Question", comment: "Show Question")
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
        answerCorrect()
        swipeCard(direction: .up)
    }
    func wrongTapHandler(){
        answerWrong()
        swipeCard(direction: .down)
    }
    
    func panningHandler(recognizer: UIPanGestureRecognizer){
        if !isTaskDone{
            panning(recognizer: recognizer)
        }
    }
    
    func updateConstraint(){
        clearConstraint()
        appendConstraint()
    }
    
    // MARK: Private Methods
    
    private func initialize(){
        
        setText.setFontSize(12)
        setText.textDirextion = .leading
        
        showAnswer.setTitle(showAnswerLocalized, for: .normal)
        
        firstCardView.initialize(phrase: "", meaning: "")
        cardViewsDic[.current] = firstCardView
        
        secondCardView.initialize(phrase: "", meaning: "")
        cardViewsDic[.next] = secondCardView
        
        let correctTitle = NSLocalizedString("Correct", comment: "Correct")
        correct.setTitle(correctTitle, for: .normal)
        correct.buttonColor = green
        
        let wrongTitle = NSLocalizedString("Wrong", comment: "Wrong")
        wrong.setTitle(wrongTitle, for: .normal)
        wrong.buttonColor = red
        
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.prepare()
        }
    }
    
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
        answerCorrect()
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
        answerWrong()
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
        
        assignWordToCard()
        
        animate(){
            current.center.x = self.cardViewCenter!.x
            self.view.backgroundColor = UIColor.clear
        }
        updateConstraint()
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
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            do{
                let wordInProgressList = try self.wordFlowService.fetchWordsToExamin()
//                            var wordInProgressList: [WordInProgressModel] = []
//                            for i in 0..<10{
//                                var word = WordModel()
//                                word.meaning = "developer"
//                                word.phrase = "Entwickler"
//                                var win = WordInProgressModel()
//                                win.column = Int16(i / 2)
//                                win.date = Date()
//                                win.word = word
//                                wordInProgressList.append(win)
//                            }
                
                for i: Int16 in 0...5{
                    self.columnDic[i] = wordInProgressList.filter(){$0.column == i}
                }
                if wordInProgressList.count > 0{
                    DispatchQueue.main.async {
                        self.assignWordToCard()
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.taskDoneView()
                    }
                }
            }
            catch{
                
            }
        })
    }
    
    private func assignWordToCard(){
        guard let current = cardViewsDic[.current] else {
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
        
        let inColumnLocalized = NSLocalizedString("in Column", comment: "in Column")
        columnCounter.text = "\(listIndex + 1) / \(list.count) \(inColumnLocalized) \(dicIndex)"
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
        
        var constraintList: [NSLayoutConstraint] = []
        
       constraintList.append(taskDoneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor))
        constraintList.append(taskDoneView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor))
        constraintList.append(taskDoneView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor))
        constraintList.append(taskDoneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    private func answerCorrect(){
        wordFlowService.answerCorrectly(currentWordInProgressModel)
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.notificationOccurred(.success)
        }
        
    }
    private func answerWrong(){
        wordFlowService.answerWrongly(currentWordInProgressModel)
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.notificationOccurred(.error)
        }
    }
    
    // MARK: Controls and Actions
    @IBOutlet weak var setText: MISetView!
    @IBOutlet weak var columnCounter: UILabel!
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var firstCardView: MICardView!
    @IBOutlet weak var secondCardView: MICardView!
    @IBOutlet weak var correct: RoundedButton!
    @IBOutlet weak var wrong: RoundedButton!
    @IBOutlet weak var nextCardLeadingCnst: NSLayoutConstraint!
    @IBOutlet weak var currentCardTopCnst: NSLayoutConstraint!
    @IBOutlet weak var currentCardBottomCnst: NSLayoutConstraint!
    @IBOutlet weak var currentCardLeadingCnst: NSLayoutConstraint!
    @IBOutlet weak var currentCardTrailingCnst: NSLayoutConstraint!
    @IBAction func showAnswerTapped(_ sender: UIButton) {
        showAnswerTapHandler()
    }
    @IBAction func correctTapped(_ sender: UIButton) {
        correctTapHandler()
    }
    @IBAction func wrongTapped(_ sender: UIButton) {
        wrongTapHandler()
    }
    
}
