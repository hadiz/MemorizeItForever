//
//  PhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/3/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class PhraseViewController: VFLBasedViewController, UISearchResultsUpdating, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {
    
    // MARK: Constants
    
    private let wordStatusList = [WordStatus.notStarted, WordStatus.inProgress, WordStatus.done]
    private let offsetCount = 50
    
    // MARK: Controls
    var tableView: UITableView!
    var searchController: UISearchController!
    var dataSource: PhraseTableDataSourceProtocol?
    var wordManager: WordManagerProtocol?

    // MARK: Local Variables
    var skip = 0
    var take = 0
    
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phrase Management"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(PhraseViewController.doneBarButtonTapHandler))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func defineControls() {
        
        guard let dataSource = dataSource else {
            fatalError("dataSource is not initialized")
        }
        
        tableView = MITableView()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifierEnum: .phraseTableCellIdentifier)
        self.automaticallyAdjustsScrollViewInsets = false
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = getScopeTitles()
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
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
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let wordStatus = wordStatusList[searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, status: wordStatus)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let wordStatus = wordStatusList[searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchBar.text!, status: wordStatus)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: Internal Methods
    
    func doneBarButtonTapHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func filterContentForSearchText(searchText: String, status: WordStatus) {
        guard let wordManager = wordManager else {
            fatalError("wordManager is not initialized")
        }
        guard let dataSource = dataSource else {
            fatalError("dataSource is not initialized")
        }
        
        let wordList = wordManager.fetchWords(phrase: searchText, status: status, fetchLimit: 50, fetchOffset: 0)
        
        dataSource.setModels(wordList)
        tableView.reloadData()
    }
    
    // MARK: Private Methods
    
    private func getScopeTitles() -> [String]{
        var list: [String] = []
        
        for item in wordStatusList{
            list.append(item.getString())
        }
        return list
    }
    
    private func fetchData(){
        let wordStatus = wordStatusList[searchController.searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: "", status: wordStatus)
    }
    
    func loadMoreTableContent(){
        let wordStatus = wordStatusList[searchController.searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, status: wordStatus)
    }
    
}
