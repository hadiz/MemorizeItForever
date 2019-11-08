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
    var dataSource: DepotTableDataSourceProtocol!
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
    }
    
    // MARK: Private Methods
    private func initializeViewController(){
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        setDataSourceProperties()
    }
    
    private func setDataSourceProperties(){
        var temporaryPhraseModelList = [TemporaryPhraseModel]()
        for item in recognizedTexts {
            temporaryPhraseModelList.append(TemporaryPhraseModel(phrase: item))
        }
        dataSource.setModels(temporaryPhraseModelList)
        
        dataSource.rowActionHandler = rowActionHandler
    }
    
    private func rowActionHandler(model: MemorizeItModelProtocol, action: TableRowAction) {
        switch action {
        case .add:
            break
        case .edit:
            break
        case .delete:
            
            break
        }
    }
    
    private func deleteModel(_ model: MemorizeItModelProtocol) {
        guard let tmpPhrase = model as? TemporaryPhraseModel else { return }
        if let index = recognizedTexts.index(of: tmpPhrase.phrase) {
            recognizedTexts.remove(at: index)
        }
    }
    
    // MARK: Controls
    @IBOutlet weak var tableView: UITableView!
    
}

public struct TemporaryPhraseModel:  MemorizeItModelProtocol{
    var phrase: String
}
