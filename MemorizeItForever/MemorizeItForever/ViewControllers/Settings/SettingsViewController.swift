//
//  SettingsViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/6/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let switching =  defaults.object(forKey: Settings.wordSwitching.rawValue) as? Bool{
            wordSwitching.isOn = switching
        }
        
        if let wordsCount =  defaults.object(forKey: Settings.newWordsCount.rawValue) as? Int{
            stepper.value = Double(wordsCount)
            newWordsCount.text = "\(wordsCount)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func wordSwitchingTapped(_ sender: UISwitch){
         UserDefaults.standard.setValue(sender.isOn, forKey: Settings.wordSwitching.rawValue)
    }
    
    private func stepActionTapped(_ sender: UIStepper){
        if sender.value < 1{
            sender.value = 1
        }
        let value = Int(sender.value)
        newWordsCount.text = "\(value)"
        UserDefaults.standard.setValue(value, forKey: Settings.newWordsCount.rawValue)
    }

    // MARK: Controls and Actions
    @IBOutlet var tableView1: UITableView!
    @IBOutlet weak var wordSwitching: UISwitch!
    @IBOutlet weak var newWordsCount: UILabel!
    @IBAction func stepAction(_ sender: UIStepper) {
        stepActionTapped(sender)
    }
    @IBAction func wordSwitchingAction(_ sender: UISwitch) {
        wordSwitchingTapped(sender)
    }
    @IBOutlet weak var stepper: UIStepper!
}
