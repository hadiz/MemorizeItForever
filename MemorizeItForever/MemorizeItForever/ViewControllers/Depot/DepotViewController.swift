//
//  DepotViewController.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 10/10/19.
//  Copyright © 2019 SomeSimpleSolutions. All rights reserved.
//

import UIKit
import MemorizeItForeverCore
import Firebase

final class DepotViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Fields
    private let segueIdentifier = "ShowTemporaryPhraseList"
    fileprivate var recognizedTexts: [String] = []
    var imagePicker: UIImagePickerController!
    var textRecognizer: VisionTextRecognizer!
    var dataSource: DepotTableDataSourceProtocol!
    var service: DepotPhraseServiceProtocol!
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVision()
        initializeDataSource()
        fetchDataAndSetDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Self.fetchDataAndSetDataSource), notificationNameEnum: NotificationEnum.depotList, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
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
    
    // MARK: Private Methods
    @objc
    private func fetchDataAndSetDataSource() {
        dataSource.setModels(service.get())
        tableView.reloadData()
    }
    
    private func initializeDataSource() {
           tableView.dataSource = dataSource
           tableView.delegate = dataSource
       }
       
       private func initializeVision() {
           let vision = Vision.vision()
           textRecognizer = vision.onDeviceTextRecognizer()
       }
    
    // MARK: IBAction
    @IBAction func openCamera(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
}

// MARK: extension DepotViewController
extension DepotViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let test = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        picker.dismiss(animated: true, completion: nil)
        processImage(image: test)
    }
}
