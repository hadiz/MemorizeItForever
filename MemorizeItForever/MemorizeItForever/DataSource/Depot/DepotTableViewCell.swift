//
//  DepotTableViewCell.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/21/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class DepotTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        add.tintColor = ColorPicker.backgroundView
    }

    @IBOutlet weak var phrase: UILabel!
    @IBOutlet weak var add: UIButton!
    
}
