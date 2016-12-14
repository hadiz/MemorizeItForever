//
//  UITableViewExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 12/5/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

extension UITableView{

    func registerClass(_ cellClass: AnyClass?, forCellReuseIdentifierEnum identifier: CellReuseIdentifier){
        register(cellClass, forCellReuseIdentifier: identifier.rawValue)
    }
    
    func dequeueReusableCellWithIdentifier(_ identifierEnum: CellReuseIdentifier, forIndexPath: IndexPath) -> UITableViewCell{
        return dequeueReusableCell(withIdentifier: identifierEnum.rawValue, for: forIndexPath)
    }
    
}
