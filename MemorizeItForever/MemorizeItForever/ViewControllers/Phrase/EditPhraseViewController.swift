//
//  EditPhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 3/31/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class EditPhraseViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    // MARK: Variables
    private var setModelList: [SetModel] = []
    private var setId: UUID?
    var wordModel: WordModel?
    var wordService: WordServiceProtocol!
    var setService: SetServiceProtocol!
    var pickerDataSource: EditPhrasePickerViewDataSourceProtocol!
    var notificationFeedback: NotificationFeedbackProtocol?
    
    // MARK: UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorPicker.backgroundView
        setList.delegate = self
        setList.tintColor = UIColor.clear
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(EditPhraseViewController.updatePhrase))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(EditPhraseViewController.cancel))
        
        self.navigationItem.leftBarButtonItem?.tintColor = ColorPicker.backgroundView
        self.navigationItem.rightBarButtonItem?.tintColor = ColorPicker.backgroundView
        
        let weakSelf = self
        
        pickerDataSource.handleTap = {[weak weakSelf] (memorizeItModel) in
            if let weakSelf = weakSelf, let setModel = memorizeItModel as? SetModel {
//                weakSelf.setList.text = setModel.name
                weakSelf.setName.text = setModel.name
                weakSelf.setId = setModel.setId
            }
        }
        
        meaning.delegate = self
        
        self.addDoneButtonOnKeyboard()

        initialize()
        
        fillForm()
        
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.prepare()
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .formSheet
    }
    
    // MARK: Private Methods
    private func fillForm(){
        guard let wordModel = wordModel else { return }
        createSetPicker()
        createToolbar()
        fillSetList()
        fillPhrase(wordModel: wordModel)
    }
    
    var setPicker: UIPickerView!
    
    private func fillSetList(){
        setModelList = setService?.get() ?? []
        pickerDataSource.setModels(setModelList)
    }
    
    private func createSetPicker(){
    
        setPicker = UIPickerView()
        setPicker.delegate = pickerDataSource
        setPicker.dataSource = pickerDataSource
        
        setList.inputView = setPicker
    }

    private func fillPhrase(wordModel: WordModel){
        phrase.text = wordModel.phrase
        meaning.text = wordModel.meaning
        setId = wordModel.setId
        
        setName.text = setModelList.filter{$0.setId == wordModel.setId}.first?.name
        
       let row =  setModelList.firstIndex{$0.setId == wordModel.setId} ?? 0
        
        setPicker.selectRow(row , inComponent: 0, animated: false)
    }
    
    private func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBUtton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(EditPhraseViewController.dismissKeyboard))
        
        toolbar.setItems([doneBUtton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        setList.inputAccessoryView = toolbar
    }

    @objc
    private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc
    private func updatePhrase(){
        guard let wordModel = wordModel else { return }
        
        wordService.edit(wordModel, phrase: phrase.text, meaninig: meaning.text, setId: setId)
        
        if let notificationFeedback = notificationFeedback{
            notificationFeedback.notificationOccurred(.success)
        }
        
        cancel()
    }
    
    @objc
    private func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initialize(){
        setText.text = NSLocalizedString("Set:", comment: "Set:")
        phraseText.text = NSLocalizedString("Phrase:", comment: "Phrase:")
        meaningText.text = NSLocalizedString("Meaning:", comment: "Meaning:")
        let buttonText = NSLocalizedString("Change", comment: "Change")
        change.setTitle(buttonText, for: .normal)
    }
    
    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        meaning.inputAccessoryView = doneToolbar
        phrase.inputAccessoryView = doneToolbar
    }

    @objc
    func doneButtonAction(){
        meaning.resignFirstResponder()
        phrase.resignFirstResponder()
    }
    
    // MARK: Controls
    @IBOutlet weak var phrase: MITextView!
    @IBOutlet weak var meaning: MITextView!
    @IBOutlet weak var setText: UILabel!
    @IBOutlet weak var phraseText: UILabel!
    @IBOutlet weak var meaningText: UILabel!
    @IBOutlet weak var setList: UITextField!
    @IBOutlet weak var setName: UILabel!
    @IBOutlet weak var change: UIButton!
    @IBAction func changeAction(_ sender: Any) {
        setList.becomeFirstResponder()
    }
    
}

extension EditPhraseViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension EditPhraseViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.animate(withDuration: 0.3) {[unowned self] in
                self.view.frame.origin.y -= self.view.frame.height / 2 - 50
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.animate(withDuration: 0.3) {[unowned self] in
                self.view.frame.origin.y += self.view.frame.height / 2 - 50
            }
        }
    }
}


