//
//  DepotTableDataSourceProtocol.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

protocol DepotTableDataSourceProtocol: MemorizeItTableDataSourceProtocol {
    var rowActionHandler: MITypealiasHelper.RowActionClosure? { get set}
}
