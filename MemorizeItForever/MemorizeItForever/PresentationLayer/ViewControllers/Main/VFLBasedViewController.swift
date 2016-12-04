//
//  VFLBasedViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/8/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit

class VFLBasedViewController: UIViewController {
    
    var viewDic: Dictionary<String,Any> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDic["topLayoutGuide"] = topLayoutGuide
        viewDic["bottomLayoutGuide"] = bottomLayoutGuide
        
        loadViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func defineControls(){
    }
    
    func addControls(){
    }
    
    func applyAutoLayout(){
        
    }
    
    private func loadViews() {
        defineControls()
        addControls()
        applyAutoLayout()
    }
}
