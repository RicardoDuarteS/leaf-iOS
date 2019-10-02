//
//  ProfileViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnUpdateProfile: UIBarButtonItem!
    @IBOutlet weak var viewSaveNewProfile: UIView!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    
    @IBOutlet weak var ViewEditProfile: UIView!
    @IBOutlet weak var imgUpgradeImage: UIImageView!
    @IBOutlet weak var txfUpdateUsername: UITextField!
    @IBOutlet weak var txfUpdateEmail: UITextField!
    @IBOutlet weak var txfUpdatePassword: UITextField!
    
    var isShow: Bool = false
    var isHidden: Bool = false
    var appManager = AppManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        // Do any additional setup after loading the view.
        registerNib()
        self.ViewEditProfile.isHidden = true
        
    }
    
    func registerNib(){
        let nibName = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        let nibHeader = UINib(nibName: "ProfileUserDetailsTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(nibHeader, forCellReuseIdentifier: "ProfileUserDetailsTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.bounces = false
    }

    
    //Buttons
    
    
    
    @IBAction func btnUpdateProfileClicked(_ sender: UIBarButtonItem) {
        if isShow == true {
            UIView.animate(withDuration: 0.5) {
                self.ViewEditProfile.isHidden = true
            }
            isShow = !isShow
            print(isShow)
        }else{
            UIView.animate(withDuration: 0.5) {
                self.ViewEditProfile.isHidden = false
            }
            isShow = !isShow
            print(isShow)
        }
        
        
    }
    
    @IBAction func btnHideShowPasswordClicked(_ sender: UIButton) {
        if isHidden == false{
            self.btnShowHidePassword.setImage(UIImage(named: "hidePassword"), for: .normal)
            self.txfUpdatePassword.isSecureTextEntry = false
            isHidden = !isHidden
        }else {
            self.btnShowHidePassword.setImage(UIImage(named: "showPassword"), for: .normal)
            self.txfUpdatePassword.isSecureTextEntry = true
            isHidden = !isHidden
        }
    }
    
    @IBAction func btnSaveUpdateProfileClicked(_ sender: UIButton) {
        
        // Save profile
        
        // update view
        // close view
        self.ViewEditProfile.isHidden = true
        //if correct upload
        appManager.showToast(message: "Profile Updated",view: self.view)
        //else show error message
        
        isShow = !isShow
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        }else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserDetailsTableViewCell", for: indexPath) as? ProfileUserDetailsTableViewCell else { return UITableViewCell()}
            //profile Image
            cell.imgProfilePicture.image = UIImage(named: "profilePictureDefault")
            //Username
            cell.lblUsername.text = "Baby Mario"
            
            return cell
        }else if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
            cell.lblCellName.text = "Email"
            cell.txfCellData.text = "Email@email.com"
            cell.txfCellData.isHidden = false
            
            //do the swift stuff
            return cell
        }else if indexPath.row == 2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
            cell.lblCellName.text = "Password"
            cell.txfCellData.text = "abc123123"
            cell.txfCellData.isHidden = false
            cell.txfCellData.isSecureTextEntry = true
            
            //do the swift stuff
            return cell
        }else if indexPath.row == 3{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
            cell.lblCellName.text = "Notification"
            cell.notificationSwitch.isHidden = false
            //do the swift stuff
            return cell
        }else if indexPath.row == 4{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell  else {return UITableViewCell()}
            cell.lblCellName.text = "My List"
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        }else if indexPath.row == 5{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell  else {return UITableViewCell()}
            cell.lblCellName.text = "Feedback"
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
            return cell
        }else{
                
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell  else {return UITableViewCell()}
            cell.lblCellName.text = "Logout"
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
            
            
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 4 { //Go to My List
            performSegue(withIdentifier: "toUserListSegue", sender: self)
        }else if indexPath.row == 5{ //Go to feedback ViewController
            performSegue(withIdentifier: "sendFeedbackSegue", sender: self)
        }else if indexPath.row == 6{ //Logout
            
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "no", style: .cancel, handler: { (action) in
                print("Logout canceled")
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
                //logout from the server
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
