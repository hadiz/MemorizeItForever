//
//  UITableViewCellExtension.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/27/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit

extension UITableViewCell{
    convenience init(style: UITableViewCellStyle, reuseIdentifierEnum: CellReuseIdentifier){
        self.init(style: style, reuseIdentifier: reuseIdentifierEnum.rawValue)
    }
}
