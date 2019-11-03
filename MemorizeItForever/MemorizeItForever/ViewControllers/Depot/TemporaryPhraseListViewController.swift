//
//  TemporaryPhraseListViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/1/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

class TemporaryPhraseListViewController: UIViewController {

    // MARK: Variables
    var recognizedTexts = [String]()
    var dataSource: MemorizeItTableDataSourceProtocol!
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
    }
    
    // MARK: Private Methods
    private func initializeViewController(){
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        setDataSourceModel()
    }
    
    private func setDataSourceModel(){
        var temporaryPhraseModelList = [TemporaryPhraseModel]()
        for item in recognizedTexts {
            temporaryPhraseModelList.append(TemporaryPhraseModel(phrase: item))
        }
        dataSource.setModels(temporaryPhraseModelList)
    }
    
    // MARK: Controls
    @IBOutlet weak var tableView: UITableView!

}

public struct TemporaryPhraseModel:  MemorizeItModelProtocol{
    var phrase: String
}
