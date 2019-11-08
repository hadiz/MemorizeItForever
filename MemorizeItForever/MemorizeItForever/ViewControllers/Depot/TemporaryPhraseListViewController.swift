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
    
    // MARK: Fields
    private let segueIdentifier = "ShowEditTemporaryPhrase"
    var recognizedTexts = [String]()
    var dataSource: DepotTableDataSourceProtocol!
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(Self.reloadData), notificationNameEnum: NotificationEnum.temporaryPhraseList, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            if let nc = segue.destination as? UINavigationController, nc.childViewControllers.count > 0,  let vc = nc.childViewControllers[0] as? EditTemporaryPhraseViewController{
                vc.phrase = sender as? String
            }
        }
    }
    
    // MARK: Private Methods
    private func initializeViewController(){
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        setDataSourceProperties()
    }
    
    private func setDataSourceProperties(){
        setDataSourceModel()
        
        dataSource.rowActionHandler = rowActionHandler
    }
    
    private func setDataSourceModel(){
        var temporaryPhraseModelList = [TemporaryPhraseModel]()
        for item in recognizedTexts {
            temporaryPhraseModelList.append(TemporaryPhraseModel(phrase: item))
        }
        dataSource.setModels(temporaryPhraseModelList)
    }
    
    private func rowActionHandler(model: MemorizeItModelProtocol, action: TableRowAction) {
        switch action {
        case .add:
            break
        case .edit:
            presentEditTemporaryPhraseViewController(model: model)
            break
        case .delete:
            deleteModel(model)
            break
        }
    }
    
    private func deleteModel(_ model: MemorizeItModelProtocol) {
        guard let tmpPhrase = model as? TemporaryPhraseModel else { return }
        if let index = recognizedTexts.index(of: tmpPhrase.phrase) {
            recognizedTexts.remove(at: index)
        }
    }
    
    private func presentEditTemporaryPhraseViewController(model: MemorizeItModelProtocol){
        guard let tmpPhrase = model as? TemporaryPhraseModel else { return }
        
        performSegue(withIdentifier: "ShowEditTemporaryPhrase", sender: tmpPhrase.phrase)
    }
    
    @objc
    private func reloadData(notification: NSNotification) {
        guard let wrapper = notification.object as? Wrapper<Any>, let dict = wrapper.getValue() as? Dictionary<TempPhrase, String?> else { return }
        
        if let original = dict[TempPhrase.original] as? String, let index = recognizedTexts.index(of: original) {
            
            recognizedTexts[index] = dict[TempPhrase.edited] as? String ?? "!!!!"
            
            setDataSourceModel()
            
            tableView.reloadData()
        }
    }
    
    // MARK: Controls
    @IBOutlet weak var tableView: UITableView!
    
}

public struct TemporaryPhraseModel:  MemorizeItModelProtocol{
    var phrase: String
}
