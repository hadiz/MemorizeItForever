//
//  EditTemporaryPhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class EditTemporaryPhraseViewController: UIViewController {
    
    // MARK: Fields
    var phrase: String?
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreateToolbarButtons()
        
        textView.text = phrase
    }
    
    //MARK: Private Methods
    private func CreateToolbarButtons() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(Self.saveAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(Self.cancelAction))
        self.navigationItem.rightBarButtonItem?.tintColor = ColorPicker.backgroundView
        self.navigationItem.leftBarButtonItem?.tintColor = ColorPicker.backgroundView
    }
    
    @objc
    private func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func saveAction(){
        let dict: Dictionary<TempPhrase, String?> = [TempPhrase.original: phrase, TempPhrase.edited:  textView.text]
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(.temporaryPhraseList, object: dict)
    }
    
    // MARK: Controls
    @IBOutlet weak var textView: UITextView!
}
