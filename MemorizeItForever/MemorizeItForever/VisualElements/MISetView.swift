//
//  MISetView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/6/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class MISetView: MIView {
    private var setFixed: UILabel!
    private var set: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setFontSize(_ size: CGFloat){
        setFixed.font = setFixed.font.withSize(size)
        set.font = set.font.withSize(size)
    }
    
    func changeSet(){
        if let setDic = UserDefaults.standard.object(forKey: Settings.defaultSet.rawValue) as? Dictionary<String, Any>,
            let setModel = SetModel(dictionary: setDic) {
            set.text = setModel.name
        }
        else{
            set.text = "Not Specified"
            set.textColor = UIColor.red
        }
    }
    
    private func initialize(){
        defineControls()
        addControls()
        applyAutoLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(MISetView.changeSet), notificationNameEnum: .setChanged, object: nil)
    }
    
    private func defineControls(){
        setFixed = MILabel()
        setFixed.text = "set:"
        setFixed.textColor = UIColor.gray
        
        set = MILabel()
        set.textColor = UIColor.darkGray
        changeSet()

    }
    
    private func addControls(){
        self.addSubview(setFixed)
        self.addSubview(set)
    }
    
    private func applyAutoLayout(){
        var viewDic: Dictionary<String,Any> = [:]
        var constraintList: [NSLayoutConstraint] = []
        
        viewDic["setFixed"] = setFixed
        viewDic["set"] = set
        
        let hSetFixedCnst = NSLayoutConstraint.constraints(withVisualFormat: "H:|[setFixed]-[set]|", options: [], metrics: nil, views: viewDic)
        let vSetFixedCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:|[setFixed]|", options: [], metrics: nil, views: viewDic)
        
        let vSetCnst = NSLayoutConstraint.constraints(withVisualFormat: "V:|[set]|", options: [], metrics: nil, views: viewDic)
        
        constraintList += hSetFixedCnst
        constraintList += vSetFixedCnst
        constraintList += vSetCnst
        
        NSLayoutConstraint.activate(constraintList)
    }
}
