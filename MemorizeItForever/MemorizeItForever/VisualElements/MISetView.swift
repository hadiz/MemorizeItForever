//
//  MISetView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/6/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class MISetView: UIView {
    
    enum Direction{
        case leading
        case center
    }
    
    var textDirextion: Direction = .center
    
    private var containerView: UIView!
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
    
    override func layoutSubviews() {
        applyAutoLayout()
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setFontSize(_ size: CGFloat){
        setFixed.font = setFixed.font.withSize(size)
    }
    
    func changeSet(){
        if let setDic = UserDefaults.standard.object(forKey: Settings.defaultSet.rawValue) as? Dictionary<String, Any>,
            let setModel = SetModel(dictionary: setDic) {
            set.text = setModel.name
        }
        else{
            set.text = NSLocalizedString("Not Specified", comment: "Not Specified") 
            set.textColor = UIColor.red
        }
    }
    
    private func initialize(){
        defineControls()
        addControls()
        NotificationCenter.default.addObserver(self, selector: #selector(MISetView.changeSet), notificationNameEnum: .setChanged, object: nil)
    }
    
    private func defineControls(){
        self.clipsToBounds = true
        
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        setFixed = MILabel()
        setFixed.text = NSLocalizedString("Set:", comment: "Set:")
        setFixed.textColor = UIColor.gray
        setFixed.baselineAdjustment = .alignCenters
        
        set = MILabel()
        set.adjustsFontSizeToFitWidth = true
        set.textColor = UIColor.darkGray
        set.baselineAdjustment = .alignCenters
        changeSet()

    }
    
    private func addControls(){
        self.addSubview(containerView)
        containerView.addSubview(setFixed)
        containerView.addSubview(set)
    }
    
    private func applyAutoLayout(){
        let setWidth = self.frame.width - 8 - 30

        var constraintList: [NSLayoutConstraint] = []
        
        switch textDirextion {
        case .center:
            constraintList.append(containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        case .leading:
             constraintList.append(containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        }
        
        constraintList.append(containerView.heightAnchor.constraint(equalTo: self.heightAnchor))
        constraintList.append(containerView.topAnchor.constraint(equalTo: self.topAnchor))
        
        constraintList.append(setFixed.leadingAnchor.constraint(equalTo: containerView.leadingAnchor))
        constraintList.append(setFixed.heightAnchor.constraint(equalTo: containerView.heightAnchor))
        constraintList.append(setFixed.topAnchor.constraint(equalTo: containerView.topAnchor))
        
        constraintList.append(set.leadingAnchor.constraint(equalTo: setFixed.trailingAnchor, constant: 8))
        constraintList.append(set.trailingAnchor.constraint(equalTo: containerView.trailingAnchor))
        constraintList.append(set.widthAnchor.constraint(equalToConstant: setWidth))
        constraintList.append(set.heightAnchor.constraint(equalTo: containerView.heightAnchor))
        constraintList.append(set.topAnchor.constraint(equalTo: containerView.topAnchor))
        
        
        NSLayoutConstraint.activate(constraintList)
    }
}
