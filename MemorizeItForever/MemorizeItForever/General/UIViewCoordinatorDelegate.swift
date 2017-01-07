//
//  UIViewCoordinatorDelegate.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/7/17.
//  Copyright © 2017 SomeSimpleSolutions. All rights reserved.
//

import UIKit

protocol UIViewCoordinatorDelegate {
     init(viewController: UIViewController)
     func defineControls()
     func addControls()
     func applyAutoLayout()
}
