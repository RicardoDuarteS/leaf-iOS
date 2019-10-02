//
//  FoundViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-08.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class AddLostOrFoundViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //Lost Outlets
    @IBOutlet weak var txfLostItemCategory: UITextField!
    @IBOutlet weak var txfLostItemLocation: UITextField!
    @IBOutlet weak var imgItemPhoto: UIImageView!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var constImgConstraint: NSLayoutConstraint!
    
    let imagePickerController = UIImagePickerController()
    var selected = "none"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Post"
        
        self.btnAddImage.layer.borderWidth = 2
        self.btnAddImage.layer.borderColor = UIColor(red: 70, green: 205, blue: 70, alpha: 1).cgColor
        self.imagePickerController.delegate = self
        self.constImgConstraint.constant = 120
        
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
    
    @IBAction func btnAddImageClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galery", style: .default, handler: { _ in
            self.openGallery()
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
    
    //Camera and library actions
    func openCamera(){
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            self.imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            self.imagePickerController.allowsEditing = true
            self.present(self.imagePickerController, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Warning", message: "You can't use your camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        self.imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.imagePickerController.allowsEditing = true
        self.present(self.imagePickerController, animated: true, completion: nil)
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
    @IBAction func btnPostLostItemClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Reward?", message: "You can pay reward for people for finding your missing item if you want", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            //Add item to the API
            
            self.performSegue(withIdentifier: "userListSegue", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

