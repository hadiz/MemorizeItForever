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
    
    // MARK: Controls
    
    var desc: UILabel!
    var phrase: MITextView!
    var meaning: MITextView!
    var setText: MISetView!
    
    // MARK: Field injection
    
    var validator: ValidatorProtocol!
    var wordService: WordServiceProtocol!
    var coordinatorDelegate: UIViewCoordinatorDelegate!
    
    // MARK: Local variables
    
    var doneBarButtonItem: UIBarButtonItem!
    var nextBarButtonItem: UIBarButtonItem!
    var saveBarButtonItem: UIBarButtonItem!
    var previousBarButtonItem: UIBarButtonItem!
    
    // MARK: Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Phrase"
        coordinatorDelegate.applyViews()
        
        doneBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(AddPhraseViewController.doneBarButtonTapHandler))
        nextBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(AddPhraseViewController.nextBarButtonTapHandler))
        saveBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(AddPhraseViewController.saveBarButtonTapHandler))
        previousBarButtonItem = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(AddPhraseViewController.previousBarButtonTapHandler))
        
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
    
    func doneBarButtonTapHandler(){
        validator.clear(validatable: phrase)
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextBarButtonTapHandler(){
        let result = validator.validate(phrase, errorMessage: "Phrase should not be empty") {
            !($0 as! MITextView).text.trim().isEmpty
        }
        
        if result{
            updateDescText(showPhrase: false)
            
            self.navigationItem.rightBarButtonItem = saveBarButtonItem
            self.navigationItem.leftBarButtonItem = previousBarButtonItem
            
            UIView.transition(from: phrase, to: meaning, duration: 1, options: [.transitionFlipFromRight ,.showHideTransitionViews], completion: nil)
            meaning.becomeFirstResponder()
        }
    }
    
    func saveBarButtonTapHandler(){
        let result = validator.validate(meaning, errorMessage: "Meaning should not be empty") {
            !($0 as! MITextView).text.trim().isEmpty
        }
        
        if result{
            savePhrase()
        }
    }
    
    func previousBarButtonTapHandler(){
        validator.clear(validatable: meaning)
        goPrevious()
        
    }
    
    func copyBarButtonTapHandler(){
        var text = meaning.text
        if meaning.isHidden{
            text = phrase.text
        }
        UIPasteboard.general.string = text
    }
    
    func pasteBarButtonTapHandler(){
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
            desc.text = "Write the Phrase here"
        }
        else{
            desc.text = "Write the Meaning here"
        }
    }
    
    private func savePhrase(){
        guard let setModel = UserDefaults.standard.getDefaultSetModel(), let setId = setModel.setId else{
            saveWasFailed(message: "Choos a default 'Set'")
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
        
        UIView.transition(from: meaning, to: phrase , duration: 1, options: [.transitionFlipFromLeft ,.showHideTransitionViews], completion: nil)
        phrase.becomeFirstResponder()
    }
    private func saveWasSuccessful(){
        goPrevious()
        phrase.text = ""
        meaning.text = ""
        self.view.makeASuccessToast(message: "Save was successful")
    }
    private func saveWasFailed(message: String){
        self.view.makeAFailureToast(message: message)
    }
    
}

