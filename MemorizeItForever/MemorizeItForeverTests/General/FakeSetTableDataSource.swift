//
//  FakeSetTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore
@testable import MemorizeItForever

class FakeSetTableDataSource: NSObject, SetTableDataSourceProtocol{
    
    var handleTap: TypealiasHelper.handleTapClosure?
    var setService: SetServiceProtocol?
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        
    }
    
    required init(setService: SetServiceProtocol?) {
        self.setService = setService
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var setModel = SetModel()
        setModel.setId = UUID()
        setModel.name = "Default"
        handleTap!(setModel)
    }
    
}

