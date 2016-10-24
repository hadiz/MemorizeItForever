//
//  FakeSetTableDataSource.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/24/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import MemorizeItForeverCore
@testable import MemorizeItForever

class FakeSetTableDataSource: NSObject, MemorizeItTableDataSourceProtocol{
    
    var handleTap: TypealiasHelper.handleTapClosure?
    
    func setModels(_ models: [MemorizeItModelProtocol]) {
        
    }
    
    required init(handleTap: TypealiasHelper.handleTapClosure?) {
        self.handleTap = handleTap
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleTap!(SetModel(setId: UUID(), name: "Default"))
    }
    
}

