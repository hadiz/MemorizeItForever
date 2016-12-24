//
//  TabBarController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/11/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class TabBarController: UITabBarController {
    
    var setService: SetServiceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let setService = setService else {
            fatalError("setService is not initialiazed")
        }
        setService.createDefaultSet()
        setService.setUserDefaultSet()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
