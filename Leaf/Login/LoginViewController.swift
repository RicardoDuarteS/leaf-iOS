//
//  LoginViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-25.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

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
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
        let tap : UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidePopUpByClickOutside))
        self.viewPopUp.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
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
    
    @objc func hidePopUpByClickOutside(){
        UIView.animate(withDuration: 2) {
            self.viewPopUp.isHidden = true
        }
        
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        //instanciate home vc
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
