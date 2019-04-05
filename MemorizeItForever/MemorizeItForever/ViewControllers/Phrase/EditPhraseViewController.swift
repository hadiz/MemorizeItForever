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
    
    // MARK: UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorPicker.backgroundView
        setList.delegate = self
        setList.tintColor = UIColor.clear
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(EditPhraseViewController.updatePhrase))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(EditPhraseViewController.cancel))
        
        let weakSelf = self
        
        pickerDataSource.handleTap = {[weak weakSelf] (memorizeItModel) in
            if let weakSelf = weakSelf, let setModel = memorizeItModel as? SetModel {
                weakSelf.setList.text = setModel.name
                weakSelf.setId = setModel.setId
            }
        }
        
        fillForm()
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
        
        setList.text = setModelList.filter{$0.setId == wordModel.setId}.first?.name
        
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
        
        cancel()
    }
    
    @objc
    private func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Controls
    @IBOutlet weak var phrase: MITextView!
    @IBOutlet weak var meaning: MITextView!
    @IBOutlet weak var setText: UILabel!
    @IBOutlet weak var phraseText: UILabel!
    @IBOutlet weak var meaningText: UILabel!
    @IBOutlet weak var setList: UITextField!
    
}

extension EditPhraseViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
