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
    
    var setService: SetServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultName = NSLocalizedString("Default", comment: "Default")
        setService.createDefaultSet(name: defaultName)
        setService.setUserDefaultSet()
        self.viewControllers?[0].tabBarItem.image = UIImage(named: "brain-deactive")
        if #available(iOS 13.0, *) {
            self.viewControllers?[1].tabBarItem.image = UIImage(systemName: "square.stack.3d.up")
        } else {
            // Fallback on earlier versions
        }
        self.viewControllers?[2].tabBarItem.image = UIImage(named: "settings-deactive")
        self.tabBar.tintColor = ColorPicker.backgroundView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
