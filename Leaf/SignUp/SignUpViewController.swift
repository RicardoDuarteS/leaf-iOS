//
//  SignUpViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-25.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.viewPopUp.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
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
    
    //Login action
    @IBAction func btnSignUpClicked(_ sender: UIButton) {
        popUpAction()
        
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
