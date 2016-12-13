//
//  MITableView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/7/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class MITableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


