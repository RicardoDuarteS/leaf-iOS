//
//  LoginViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-25.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    //Login
    @IBOutlet weak var txfUsername: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    
    //view
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var txfForgotPassword: UITextField!
    
    
    var showHidePassword = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap : UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidePopUpByClickOutside))
        self.viewPopUp.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    //Show and Hide password
    @IBAction func btnShowAndHidePasswordClicked(_ sender: UIButton) {
        if showHidePassword == true {
            self.btnShowHidePassword.setImage(UIImage(named: "hidePassword"), for: .normal)
            self.showHidePassword = !showHidePassword
            self.txfPassword.isSecureTextEntry = false
            print("Show password", showHidePassword)
        }else{
            self.btnShowHidePassword.setImage(UIImage(named: "showPassword"), for: .normal)
            self.showHidePassword = !showHidePassword
            self.txfPassword.isSecureTextEntry = true
            print("Show password", showHidePassword)
        }
    }
    
    //Hide pop up when click outside the view
    @objc func hidePopUpByClickOutside(){
        UIView.animate(withDuration: 2) {
            self.viewPopUp.isHidden = true
        }
        
    }
    
    func handleLogin(){
        guard let email = txfUsername.text, let password = txfPassword.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                    print("Error: \(error)")
            }else{
                //instanciate home vc
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "homeVC")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        if txfUsername.text != "" && txfPassword.text != "" {
            handleLogin()
        }else{
            if txfUsername.text == ""{
                txfUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }else if txfPassword.text == ""{
                txfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
    }
    
    @IBAction func btnForgotPasswordClicked(_ sender: UIButton) {
        //show pop up
        UIView.animate(withDuration: 2) {
            if self.viewPopUp.isHidden == true {
                self.viewPopUp.isHidden = false
            }
        }
        
        
    }
    
    @IBAction func btnRestorePasswordClicked(_ sender: UIButton) {
        //send email or text message
    }
    
}
