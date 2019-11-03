//
//  DepotViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/10/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import Firebase

final class DepotViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Fields
    private let segueIdentifier = "ShowTemporaryPhraseList"
    fileprivate var recognizedTexts: [String] = []
    var imagePicker: UIImagePickerController!
    var textRecognizer: VisionTextRecognizer!
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            if let nc = segue.destination as? UINavigationController, nc.childViewControllers.count > 0,  let vc = nc.childViewControllers[0] as? TemporaryPhraseListViewController{
                vc.recognizedTexts = recognizedTexts
            }
        }
    }
    
    // MARK: Methods
    fileprivate func processImage(image: UIImage) {
        
        guard let newImage = image.fixedOrientation() else {
            print("No!!!!!")
            return
        }
        
        let vImage = VisionImage(image: newImage)
        
        textRecognizer.process(vImage) { [weak self] (result, error) in
            guard let strongSelf = self else { return }
            
            guard error == nil, let result = result else {
                // ...
                return
            }
            
            for block in result.blocks {
                for line in block.lines {
                    strongSelf.recognizedTexts.append(line.text)
                    
                    print(line.text)
                }
            }
            
            strongSelf.performSegue(withIdentifier: strongSelf.segueIdentifier, sender: nil)
        }
    }
    
    // MARK: IBAction
    @IBAction func openCamera(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: extension DepotViewController
extension DepotViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let test = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        picker.dismiss(animated: true, completion: nil)
        processImage(image: test)
    }
}
