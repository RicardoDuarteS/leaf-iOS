//
//  SignUpViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-25.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate {

    //Sign up
    @IBOutlet weak var imgUserProfilePhoto: UIImageView!
    @IBOutlet weak var txfUsername: UITextField!
    @IBOutlet weak var txfEmail: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var txfConfirmPassword: UITextField!
    @IBOutlet weak var txfPhoneNumber: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    //popUp
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var txfConfirmationCode: UITextField!
    
    //Variables and constants
    var showPopUp = true
    let imagePickerController = UIImagePickerController()
    
    //handler
    let cameraHandler = CameraHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.handleSelectProfileImage()
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tap:)))
        self.imgUserProfilePhoto.isUserInteractionEnabled = true
        self.imgUserProfilePhoto.addGestureRecognizer(tap)
    }
    
    @objc func imageTapped(tap: UITapGestureRecognizer){
        let tappedImage = tap.view as! UIImageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func popUpAction(){
        if (self.txfUsername.text != "" || self.txfEmail.text != "" || self.txfPassword.text != "" || self.txfConfirmPassword.text != "" || self.txfPhoneNumber.text != "") || (self.txfConfirmPassword != self.txfPassword){
            self.viewPopUp.isHidden = !showPopUp
            showPopUp = !showPopUp
            print("Pop up opened")
        }else{
            txfUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            txfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            txfEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            txfConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            txfPhoneNumber.attributedPlaceholder = NSAttributedString(string: "txfPhoneNumber", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
    }
    
    //img picker controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgUserProfilePhoto.contentMode = .scaleAspectFit
            self.imgUserProfilePhoto.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //img picker controller cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addProfilePictureClicked(_ sender: UIButton) {
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
    
    
    //Login action
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
//        popUpAction()
        //make sure the text fields aren't empty and the password is the same as the confirm password
        if (txfEmail.text != "" && txfPassword.text != "" && txfConfirmPassword.text != "") && (txfPassword.text == txfConfirmPassword.text){
        //Auth firebase
            guard let email = txfEmail.text, let password = txfPassword.text, let name = txfUsername.text, let phoneNumber = txfPhoneNumber.text else{
                print("Form is not valid")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if error != nil{
                    print(error)
                    return
                }
                //unwrap user ID
                guard let uid = authResult?.user.uid else {
                    return
                }
                //Add reference
                let ref = Database.database().reference(fromURL: "https://leaf-6d599.firebaseio.com/")
                //Add user and uid to the user
                let usersReference = ref.child("users").child(uid)
                //Add values
                let values = ["username": name,
                              "email": email,
                              "phone": phoneNumber]
            
                //Add data to database
                usersReference.updateChildValues(values) { (err, ref) in
                    if err != nil {
                        print(err)
                        return
                    }
                    print("Saved user successfully into firebase database")
                    
                    //instantiate next controller
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "homeVC")
                    self.navigationController?.pushViewController(vc, animated: true) 
                }
                
            }
        }else {
            //If something is wrong display an alert controller
            let alert = UIAlertController(title: "Something is missing", message: "You should fill at least your email and password correctly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
                print("Cancel")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        

        
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Pop Up Buttons
    @IBAction func btnCancelPopUpClicked(_ sender: UIButton) {
        self.viewPopUp.isHidden = true
        showPopUp = !showPopUp
        print("Pop up closed")
    }
    @IBAction func btnSubmitConfirmationCodeClicked(_ sender: UIButton) {
        
    }
    
    

}
