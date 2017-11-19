//
//  PhraseHistoryViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class PhraseHistoryViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: Variables
    var wordModel: WordModel?
    
    // MARK: Field Injection
    var wordService: WordServiceProtocol!
    var dataSource: PhraseTableDataSourceProtocol!

    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        let closeTitle = NSLocalizedString("Close", comment: "Close")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: closeTitle, style: .plain, target: self, action: #selector(PhraseHistoryViewController.closeBarButtonTapHandler))
        self.view.backgroundColor = ColorPicker.backgroundView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Internal Methods
    
    @objc func closeBarButtonTapHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private Methods
    
    private func initialize(){
        self.title = NSLocalizedString("Phrase Failure History", comment: "Phrase Failure History")
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.registerClass(Value1UITableViewCell.self, forCellReuseIdentifierEnum: .phraseHistoryTableCellIdentifier)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setModel(wordHistoryModelList: [WordHistoryModel]){
        
        dataSource.setModels(wordHistoryModelList)
    }
    
    private func fetchData(){
        
        guard let wordModel = wordModel else {
            return // TODO Notify Error
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let list = self.wordService.fetchWordHistoryByWord(wordModel: wordModel)
            if list.count > 0{
                self.setModel(wordHistoryModelList: list)
            }
            else{
                var wordHistoryModel = WordHistoryModel()
                wordHistoryModel.word = wordModel
                self.setModel(wordHistoryModelList: [wordHistoryModel])
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: Controls and Actions
    @IBOutlet weak var tableView: UITableView!
}
