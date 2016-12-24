//
//  PhraseHistoryViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

class PhraseHistoryViewController: VFLBasedViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: Controls
    var tableView: UITableView!
    var dataSource: PhraseTableDataSourceProtocol?
    
    // MARK: Variables
    var wordModel: WordModel?
    
    // MARK: Field Injection
    var wordService: WordServiceProtocol?
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Phrase Failure History"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(PhraseHistoryViewController.closeBarButtonTapHandler))
        self.view.backgroundColor = ColorPicker.shared.backgroundView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func defineControls() {
        guard let dataSource = dataSource else {
            fatalError("dataSource is not initialized")
        }

        tableView = MITableView()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.registerClass(Value1UITableViewCell.self, forCellReuseIdentifierEnum: .phraseHistoryTableCellIdentifier)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func addControls() {
        self.view.addSubview(tableView)
    }
    
    override func applyAutoLayout() {
        var constraintList: [NSLayoutConstraint] = []
        
        viewDic["tableView"] = tableView
        
        let hTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: [], metrics: nil, views: viewDic)
        
        let vTableViewCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide]-[tableView]-[bottomLayoutGuide]", options: [], metrics: nil, views: viewDic)
        
        constraintList += hTableViewCnst
        constraintList += vTableViewCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Internal Methods
    
    func closeBarButtonTapHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private Methods
    
    private func setModel(wordHistoryModelList: [WordHistoryModel]){
        guard let dataSource = dataSource else {
            fatalError("dataSource is not initialized")
        }
        dataSource.setModels(wordHistoryModelList)
    }
    
    private func fetchData(){
        guard let wordService = wordService else {
            fatalError("wordService is not initialized")
        }
        guard let wordModel = wordModel else {
            return // TODO Notify Error
        }
        let list = wordService.fetchWordHistoryByWord(wordModel: wordModel)
        if list.count > 0{
            setModel(wordHistoryModelList: list)
        }
        else{
            var wordHistoryModel = WordHistoryModel()
            wordHistoryModel.word = wordModel
            setModel(wordHistoryModelList: [wordHistoryModel])
        }
        tableView.reloadData()
    }
}
