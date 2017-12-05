//
//  MISetView.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 11/6/16.
//  Copyright © 2016 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

@IBDesignable
final class MISetView: UIView {
    
    @IBInspectable
    var isCentered: Bool = false{
        didSet {
            if isCentered {
                textDirection = .center
            }
            else {
                textDirection = .leading
            }
        }
    }
    
    enum Direction{
        case leading
        case center
    }
    
    var textDirection: Direction = .leading
    private var didConstraintsSet = false
    
    private var setFixed: UILabel!
    private var set: UILabel!
    private var stackView: UIStackView!
    
    
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
    
    override func updateConstraints() {
        super.updateConstraints()
        guard !didConstraintsSet else {return}
        didConstraintsSet = true
        applyAutoLayout()
    }
    
    func setFontSize(_ size: CGFloat){
        setFixed.font = setFixed.font.withSize(size)
    }
    
    @objc func changeSet(){
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
        
        stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        setFixed = MILabel()
        setFixed.text = NSLocalizedString("Set:", comment: "Set:")
        setFixed.textColor = UIColor.gray
        setFixed.baselineAdjustment = .alignCenters
        
        set = MILabel()
        set.adjustsFontSizeToFitWidth = true
        set.textColor = UIColor.darkGray
        set.baselineAdjustment = .alignCenters
        set.minimumScaleFactor = 0.5
        set.numberOfLines = 1
        set.setContentCompressionResistancePriority(.init(749), for: .horizontal)
        changeSet()
        
    }
    
    private func addControls(){
        self.addSubview(stackView)
        stackView.addArrangedSubview(setFixed)
        stackView.addArrangedSubview(set)
    }
    
    private func applyAutoLayout(){
        
        var constraintList: [NSLayoutConstraint] = []
        
        switch textDirection {
        case .center:
            constraintList.append(stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        case .leading:
            constraintList.append(stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
            constraintList.append(stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor))
        }
        
        constraintList.append(stackView.topAnchor.constraint(equalTo: self.topAnchor))
        constraintList.append(stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        
        NSLayoutConstraint.activate(constraintList)
    }
}
