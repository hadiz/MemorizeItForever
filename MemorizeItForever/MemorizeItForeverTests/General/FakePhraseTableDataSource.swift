//
//  FakePhraseTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/3/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore
@testable import MemorizeItForever

class FakePhraseTableDataSource: NSObject, PhraseTableDataSourceProtocol{
    
    var handleTap: TypealiasHelper.handleTapClosure?
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
    }
    
    required init(wordManager: WordManagerProtocol?) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var setModel = SetModel()
//        setModel.setId = UUID()
//        setModel.name = "Default"
//        handleTap!(setModel)
    }
    
}
