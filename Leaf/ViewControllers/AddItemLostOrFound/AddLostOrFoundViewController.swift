//
//  FoundViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-08.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import FirebaseAuth

class AddLostOrFoundViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    //Outlets
    @IBOutlet weak var txfLostItemName: UITextField!
    @IBOutlet weak var txfLostItemLocation: UITextField!
    @IBOutlet weak var imgItemPhoto: UIImageView!
    @IBOutlet weak var txfCategory: UITextField!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var txvDescription: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //Reward Pop up
    @IBOutlet weak var rewardPopUpView: UIView!
    @IBOutlet weak var txfReward: UITextField!
    
    
    let imagePickerController = UIImagePickerController()
    let pickerView = UIPickerView()
    var selected = "none"
    var reward = Double()
    let appManager = AppManager()
    let apiManager = ApiManager()
    let cameraHandler = CameraHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Post"
        
        self.btnAddImage.layer.borderWidth = 2
        self.btnAddImage.layer.borderColor = UIColor(red: 70, green: 205, blue: 70, alpha: 1).cgColor
        
        self.txfCategory.inputView = self.pickerView
        self.imagePickerController.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
    }
    
    //img picker controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgItemPhoto.contentMode = .scaleAspectFit
            self.imgItemPhoto.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //img picker controller cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addLostItem(reward: String){
        //unwrap textfields
               guard let itemName = txfLostItemName.text, let category = txfCategory.text, let location = txfLostItemLocation.text, let description = txvDescription.text else {return}
               //verify if the fields are empty
               if itemName != "" && category != "", location != "" && description != "" {
                   //Register new item
                let userID = Auth.auth().currentUser?.uid
                apiManager.addLostItem(userID: userID, itemName: txfLostItemName.text!, category: txfCategory.text!, location: txfLostItemLocation.text!, description: txvDescription.text!, reward: reward, itemPicture: imgItemPhoto!)
               }else{
                   let alert = UIAlertController(title: "Field empty?", message: "If you want to find your item you have to be sure all the fields are not empty", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                       print("Cancel pressed")
                   }))
                   self.present(alert, animated: true, completion: nil)
               }
    }
    
    func addFoundItem(){
        guard let itemName = txfLostItemName.text, let category = txfCategory.text, let location = txfLostItemLocation.text, let description = txvDescription.text else {return}
        //verify if fields are empty
        if itemName != "" && category != "" && location != "" && description != "" {
            apiManager.addFoundItem(itemName: itemName, category: category, location: location, description: description, itemPicture: imgItemPhoto)
        }else {
            let alert = UIAlertController(title: "Field empty?", message: "If you want to find your item you have to be sure all the fields are not empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                print("Cancel pressed")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func cleanActivity(){
        txfCategory.text = ""
        txfLostItemName.text = ""
        txvDescription.text = ""
        txfLostItemLocation.text = ""
        imgItemPhoto.image = UIImage(named: "imageIcon")
        AppManager().showToast(message: "\(selected) item posted successfully",view: view!)
        self.view.reloadInputViews()
        
    }
    
    //Buttons
    
    @IBAction func btnAddImageClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.cameraHandler.openCamera(imagePickerController: self.imagePickerController, viewController: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Galery", style: .default, handler: { _ in
            self.cameraHandler.openGallery(imagePickerController: self.imagePickerController, viewController: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func btnSegmentedControlClicked(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            //Set up lost
            self.selected = "Found"
            print(selected)
        case 1:
            //set up found
            self.selected = "Lost"
            print(selected)
        default:
            break
        }
    }
    
    //Post Lost Item
    @IBAction func btnPostClicked(_ sender: UIButton) {
        if self.selected == "Lost"{
            self.rewardPopUpView.isHidden = false
        }else{
            self.addFoundItem()
            self.cleanActivity()
            performSegue(withIdentifier: "userListSegue", sender: self)
        }
    }
    
    //Reward Buttons
    
    @IBAction func btnAddRewardClicked(_ sender: UIButton) {
        if txfReward.text != ""{
            self.addLostItem(reward: txfReward.text ?? "")
            self.cleanActivity()
            performSegue(withIdentifier: "userListSegue", sender: self)
        }else{
            self.addLostItem(reward: "0.00")
            self.cleanActivity()
            performSegue(withIdentifier: "userListSegue", sender: self)
        }
        
    }
    
    @IBAction func btnDontAddRewardClicked(_ sender: UIButton) {
    }
    

}

extension AddLostOrFoundViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.appManager.filterOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.appManager.filterOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //do something
        self.txfCategory.text = appManager.filterOptions[row]
    }
    
    
}

