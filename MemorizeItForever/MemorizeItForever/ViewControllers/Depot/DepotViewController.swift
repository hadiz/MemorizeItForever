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
import AVFoundation

final class DepotViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Fields
    private let segueIdentifier = "ShowTemporaryPhraseList"
    private var depotModelList = [DepotPhraseModel]()
    fileprivate var recognizedTexts =  [String]()
    var imagePicker: UIImagePickerController!
    var textRecognizer: VisionTextRecognizer!
    var dataSource: DepotTableDataSourceProtocol!
    var service: DepotPhraseServiceProtocol!
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PrepareControls()
        initializeVision()
        initializeDataSource()
        fetchDataAndSetDataSource()
        registerNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkAuthorizationStatus()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            if let nc = segue.destination as? UINavigationController, nc.childViewControllers.count > 0,  let vc = nc.childViewControllers[0] as? TemporaryPhraseListViewController{
                vc.recognizedTexts = recognizedTexts
            }
        }
    }
    
    // MARK: Private Methods
    private func processImage(image: UIImage) {
        
        guard let newImage = image.fixedOrientation() else {
            return
        }
        
        recognizedTexts = []
        
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
    
    @objc
    private func fetchDataAndSetDataSource() {
        depotModelList = service.get()
        dataSource.setModels(depotModelList)
        tableView.reloadData()
    }
    
    private func initializeDataSource() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        dataSource.rowActionHandler = rowActionHandler
    }
    
    private func initializeVision() {
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
    }
    
    private func rowActionHandler(model: MemorizeItModelProtocol, action: TableRowAction) {
        switch action {
        case .add:
            addModel(model)
            break
        case .edit:
            break
        case .delete:
            deleteModel(model)
            break
        }
    }
    
    private func deleteModel(_ model: MemorizeItModelProtocol) {
        guard let depotPhrase = model as? DepotPhraseModel else { return }
        if let index = depotModelList.index(of: depotPhrase) {
            depotModelList.remove(at: index)
            _ = service.delete(depotPhrase)
        }
    }
    
    private func addModel(_ model: MemorizeItModelProtocol) {
        guard let depotPhrase = model as? DepotPhraseModel else { return }
        if let index = depotModelList.index(of: depotPhrase) {
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Phrase",bundle: nil)
            let addPhraseViewController = storyboard.instantiateViewController(withIdentifier: "AddPhraseViewController")
            if let vc = addPhraseViewController as? AddPhraseViewController {
                vc.depotPhraseModelList = Array(depotModelList[index..<depotModelList.count])
            }
            
            let contentSize = CGSize(width: self.view.frame.width - 20, height: self.view.frame.height - 20)
            self.presentingPopover(addPhraseViewController, sourceView: tableView!, popoverArrowDirection: UIPopoverArrowDirection(rawValue: 0), contentSize: contentSize)
            
            
        }
    }
    
    @objc
    private func depotPharseDone(notification: NSNotification) {
        guard let wrapper = notification.object as? Wrapper<Any>, let model = wrapper.getValue() as? DepotPhraseModel else
        {
            return
        }
        
        deleteModel(model)
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(Self.fetchDataAndSetDataSource), notificationNameEnum: NotificationEnum.depotList, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Self.depotPharseDone), notificationNameEnum: NotificationEnum.depotDone, object: nil)
    }
    
    private func goToSettings(){
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    private func PrepareControls() {
        camera.tintColor = ColorPicker.backgroundView
        let title = NSLocalizedString("AllowAccessToCamera", comment: "Allow Access to Camera")
        cameraIsDenied.setTitle(title, for: .normal)
    }
    
    private func checkAuthorizationStatus() {
           switch AVCaptureDevice.authorizationStatus(for: .video) {
           case .denied, .restricted:
               tableView.isHidden = true
               cameraIsDenied.isHidden = false
           default:
               tableView.isHidden = false
               cameraIsDenied.isHidden = true
               break
           }
       }
    
    // MARK: IBAction
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBAction func openCamera(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraIsDenied: UIButton!
    @IBAction func goToSettings(_ sender: Any) {
        goToSettings()
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
