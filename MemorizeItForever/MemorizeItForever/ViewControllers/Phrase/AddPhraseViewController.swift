//
//  AddPhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class AddPhraseViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    // MARK: Constants
    
    private let writePhrase = NSLocalizedString("Write the Phrase here", comment: "Write the phrase here label")
    
    // MARK: Field injection
    var validator: ValidatorProtocol!
    var wordService: WordServiceProtocol!
    var notificationFeedback: NotificationFeedbackProtocol?
    
    // MARK: Local variables
    
    var doneBarButtonItem: UIBarButtonItem!
    var nextBarButtonItem: UIBarButtonItem!
    var saveBarButtonItem: UIBarButtonItem!
    var previousBarButtonItem: UIBarButtonItem!
    
    // MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setText.setFontSize(12)
        desc.text = writePhrase
        
        phrase.font = phrase.font?.withSize(20)
        phrase.alpha = 0.7
        
        meaning.isHidden = true
        meaning.font = meaning.font?.withSize(20)
        meaning.alpha = 0.7
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.prepare()
        }
        
        let close = NSLocalizedString("Close", comment: "Close bar button item")
        let next = NSLocalizedString("Next", comment: "Next bar button item")
        let save = NSLocalizedString("Save", comment: "Save bar button item")
        let previous = NSLocalizedString("Previous", comment: "Previous bar button item")
        doneBarButtonItem = UIBarButtonItem(title: close, style: .plain, target: self, action: #selector(AddPhraseViewController.doneBarButtonTapHandler))
        nextBarButtonItem = UIBarButtonItem(title: next, style: .plain, target: self, action: #selector(AddPhraseViewController.nextBarButtonTapHandler))
        saveBarButtonItem = UIBarButtonItem(title: save, style: .plain, target: self, action: #selector(AddPhraseViewController.saveBarButtonTapHandler))
        previousBarButtonItem = UIBarButtonItem(title: previous, style: .plain, target: self, action: #selector(AddPhraseViewController.previousBarButtonTapHandler))
        
        let copyBarButton = UIBarButtonItem(image: UIImage(named: "Copy"), style: .plain, target: self, action: #selector(AddPhraseViewController.copyBarButtonTapHandler))
        let pasteBarButton = UIBarButtonItem(image: UIImage(named: "Paste"), style: .plain, target: self, action: #selector(AddPhraseViewController.pasteBarButtonTapHandler))
        
        //        self.navigationItem.leftBarButtonItem = doneBarButtonItem
        self.navigationItem.rightBarButtonItem = nextBarButtonItem
        
        self.navigationItem.leftBarButtonItems = [doneBarButtonItem, copyBarButton, pasteBarButton]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: Internal methods
    
    @objc func doneBarButtonTapHandler(){
        validator.clear(validatable: phrase)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func nextBarButtonTapHandler(){
        let errorMessage = NSLocalizedString("Phrase should not be empty", comment: "Phrase should not be empty message")
        let result = validator.validate(phrase, errorMessage: errorMessage) {
            !($0 as! MITextView).text.trim().isEmpty
        }
        
        if result{
            updateDescText(showPhrase: false)
            
            self.navigationItem.rightBarButtonItem = saveBarButtonItem
            self.navigationItem.leftBarButtonItem = previousBarButtonItem
            
            UIView.transition(from: phrase, to: meaning, duration: 0.5, options: [.transitionFlipFromRight ,.showHideTransitionViews], completion: nil)
            meaning.becomeFirstResponder()
        }
    }
    
    @objc func saveBarButtonTapHandler(){
        let errorMessage = NSLocalizedString("Meaning should not be empty", comment: "Meaning should not be empty message")
        let result = validator.validate(meaning, errorMessage: errorMessage) {
            !($0 as! MITextView).text.trim().isEmpty
        }
        
        if result{
            savePhrase()
        }
    }
    
    @objc func previousBarButtonTapHandler(){
        validator.clear(validatable: meaning)
        goPrevious()
        
    }
    
    @objc func copyBarButtonTapHandler(){
        var text = meaning.text
        if meaning.isHidden{
            text = phrase.text
        }
        UIPasteboard.general.string = text
    }
    
    @objc func pasteBarButtonTapHandler(){
        if phrase.isHidden{
           meaning.text = UIPasteboard.general.string
        }
        else{
            phrase.text = UIPasteboard.general.string
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Private methods
    
    private func updateDescText(showPhrase: Bool){
        if showPhrase{
            desc.text = writePhrase
        }
        else{
            desc.text = NSLocalizedString("Write the Meaning here", comment: "Write the Meaning here label")
        }
    }
    
    private func savePhrase(){
        guard let setModel = UserDefaults.standard.getDefaultSetModel(), let setId = setModel.setId else{
            let message = NSLocalizedString("Choos a default 'Set'", comment: "Choos a default 'Set' message")
            saveWasFailed(message: message)
            return
        }
        do{
            try wordService.save(phrase.text.trim(), meaninig: meaning.text.trim(), setId: setId)
            saveWasSuccessful()
        }
        catch{
            saveWasFailed(message: error.localizedDescription)
        }
        
    }
    
    private func goPrevious(){
        updateDescText(showPhrase: true)
        
        self.navigationItem.rightBarButtonItem = nextBarButtonItem
        self.navigationItem.leftBarButtonItem = doneBarButtonItem
        
        UIView.transition(from: meaning, to: phrase , duration: 0.5, options: [.transitionFlipFromLeft ,.showHideTransitionViews], completion: nil)
        phrase.becomeFirstResponder()
    }
    private func saveWasSuccessful(){
        goPrevious()
        phrase.text = ""
        meaning.text = ""
        let message = NSLocalizedString("Save was successful", comment: "Save was successful message")
        self.view.makeASuccessToast(message: message)
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.notificationOccurred(.success)
        }
    }
    private func saveWasFailed(message: String){
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.notificationOccurred(.error)
        }
        self.view.makeAFailureToast(message: message)
    }
    
    // MARK: Controls and Actions
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var phrase: MITextView!
    @IBOutlet weak var meaning: MITextView!
    @IBOutlet weak var setText: MISetView!
}

