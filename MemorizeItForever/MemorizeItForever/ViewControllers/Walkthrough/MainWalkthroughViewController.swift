//
//  MainWalkthroughViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 4/21/18.
//  Copyright © 2018 SomeSimpleSolutions. All rights reserved.
//

import UIKit

final class MainWalkthroughViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let subview = PartialOpaqueView(frame: self.view.frame, nonOpaqueFrame: CGRect(x: 85, y: 275, width: 200, height: 200))
        self.view.addSubview(subview)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawALine()
//        tesmp.animText = "This is a demo of a typing label animation..."
        tesmp.text = ""
    tesmp.animatetextas(fff: "This is a demo of a typing label animation...")
    }
    
    func drawALine() {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 525))
        
        path.addQuadCurve(to: CGPoint(x: 185, y: 480), controlPoint: CGPoint(x: 190, y: 510))
        
        path.move(to: CGPoint(x: 179, y: 488))
        path.addLine(to: CGPoint(x: 185, y: 480))
        
        path.addLine(to: CGPoint(x: 191, y: 488))
        
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 2
        layer.path = path.cgPath
        self.view.layer.addSublayer(layer)
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 1
        
        layer.add(anim, forKey: "position")
    }
    
    @IBOutlet weak var tesmp: testLabel!
}

