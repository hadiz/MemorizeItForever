//
//  PhraseViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/3/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class PhraseViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {
    
    // MARK: Constants
    
    let wordStatusList = [WordStatus.notStarted, WordStatus.inProgress, WordStatus.done]
    private let offsetCount = 50
    
    // MARK: Controls
    
    var searchController: UISearchController!
    
    // MARK: Field Injection
    var dataSource: PhraseTableDataSourceProtocol!
    var wordService: WordServiceProtocol!
    
    
    // MARK: Local Variables
    var skip = 0
    var take = 0
    
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        let weakSelf = self
        
        dataSource.handleTap = {[weak weakSelf] (memorizeItModel) in
            if let weakSelf = weakSelf{
                weakSelf.didSelectSet(memorizeItModel)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @objc func doneBarButtonTapHandler() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func filterContentForSearchText(searchText: String, status: WordStatus) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            let wordList = self.wordService.fetchWords(phrase: searchText, status: status, fetchLimit: 50, fetchOffset: 0)
            
            self.dataSource.setModels(wordList)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: Private Methods
    
    private func initialize(){
        self.title =  NSLocalizedString("Phrase Management", comment: "Phrase Management")
        
        tableView.registerClass(SubtitleUITableViewCell.self, forCellReuseIdentifierEnum: .phraseTableCellIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = getScopeTitles()
        searchController.searchBar.delegate = self
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        
        let closeTitle = NSLocalizedString("Close", comment: "Close")
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: closeTitle, style: .plain, target: self, action: #selector(PhraseViewController.doneBarButtonTapHandler))
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.definesPresentationContext = true
    }
    
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
    
    private func didSelectSet(_ model: MemorizeItModelProtocol?){
        presentEditPhraseViewController(wordModel: model as? WordModel)
        //EditPhraseViewController
    }
    
//    private func presentPhraseHistoryViewController(wordModel: WordModel? = nil){
//        let storyboard : UIStoryboard = UIStoryboard(name: "Phrase",bundle: nil)
//        let phraseHistoryViewController = storyboard.instantiateViewController(withIdentifier: "PhraseHistoryViewController") as! PhraseHistoryViewController
//
//        phraseHistoryViewController.wordModel  = wordModel
//
//        let size = CGSize(width: self.view.frame.width  , height: self.view.frame.height * 2 / 3)
//        self.presentingPopover(phraseHistoryViewController, sourceView: self.tableView, popoverArrowDirection: UIPopoverArrowDirection(rawValue: 0), contentSize: size)
//
//    }
    
    private func presentEditPhraseViewController(wordModel: WordModel? = nil){
        let storyboard : UIStoryboard = UIStoryboard(name: "Phrase",bundle: nil)
        let editPhraseViewController = storyboard.instantiateViewController(withIdentifier: "EditPhraseViewController") as! EditPhraseViewController
        
        editPhraseViewController.wordModel  = wordModel
        
        let size = CGSize(width: self.view.frame.width  , height: self.view.frame.height * 2 / 3)
        self.presentingPopover(editPhraseViewController, sourceView: self.tableView, popoverArrowDirection: UIPopoverArrowDirection(rawValue: 0), contentSize: size)
        
    }
    
    // MARK: Controls and Actions
    @IBOutlet weak var tableView: UITableView!
}
