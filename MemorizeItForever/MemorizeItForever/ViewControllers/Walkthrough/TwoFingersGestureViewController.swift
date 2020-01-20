//
//  TwoFingersGestureViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 1/19/20.
//  Copyright © 2020 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore

final class TwoFingersGestureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = NSLocalizedString("Close", comment: "Close")
        doneButton.setTitle(title, for: .normal)
        doneButton.tintColor = ColorPicker.backgroundView
        
        let descText = NSLocalizedString("walkthroughDesc", comment: "Drag Up & Down to Scroll the Text")
        walkthroughDesc.text = descText
        walkthroughDesc.lineBreakMode = .byWordWrapping
        walkthroughDesc.numberOfLines = 0
        walkthroughDesc.textAlignment = .center
        
        var text = NSLocalizedString("WalkthroughText", comment: "This is a multiline text: 1 to 100")
        for i in 1...100 {
            text += "\n\(i)"
        }
        
        cardView.initialize(phrase: text, meaning: text, addGesture: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 4, delay: 0.2, options: [.curveEaseInOut, .repeat, .autoreverse], animations: { [weak self] in
            self?.cardView.setContentOffset(y: 500.0)
            self?.twoFingersIcon.frame.origin.y = 0
        }, completion: nil)
    }
    
    internal static func presentMe(sourceViewController vc: UIViewController){
        let alreadyShown = UserDefaults.standard.object(forKey: Settings.twoFingersWalkthrough.rawValue) as? Bool

        if alreadyShown ?? false{
            return
        }
        
        UserDefaults.standard.setValue(true, forKey: Settings.twoFingersWalkthrough.rawValue)
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Walkthrough",bundle: nil)
        let twoFingersGestureVC = storyboard.instantiateViewController(withIdentifier: "TwoFingersGestureViewController") as! TwoFingersGestureViewController        
        vc.present(twoFingersGestureVC, animated: true, completion: nil)
    }
    
    private func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var cardView: MICardView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var walkthroughDesc: UILabel!
    @IBOutlet weak var twoFingersIcon: UIImageView!
    @IBAction func done(_ sender: UIButton) {
        dismiss()
    }
}
