//
//  ProfileViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

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
    
    var userData: [String:Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        // Do any additional setup after loading the view.
        registerNib()
        self.ViewEditProfile.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchuserData()
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
    //Fetch user data
    func fetchuserData(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                self.userData["name"] = dictionary["username"] as? String
                self.userData["email"] = dictionary["email"] as? String
                self.userData["phone"] = dictionary["phone"] as? String
                print("User data: \n\(self.userData)")
                self.tableView.reloadData()
            }
        }
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
    
    func handleLogount(){
        //logout from the server
        
        do{
            try Auth.auth().signOut()
            print("User logged out successfully")
        }catch let signOutError as NSError{
            print("Error signing out: %@ ", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
        //New iOS 13 behaviour - Avoid card view after present VC. 
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserDetailsTableViewCell", for: indexPath) as? ProfileUserDetailsTableViewCell else { return UITableViewCell()}
            //profile Image
            cell.imgProfilePicture.image = UIImage(named: "profilePictureDefault")
            //Username
            cell.lblUsername.text = self.userData["name"] as? String
            
            return cell
        }else if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
            cell.lblCellName.text = "Email"
            cell.txfCellData.text = self.userData["email"] as? String
            cell.txfCellData.isHidden = false
            
            //do the swift stuff
            return cell
        }else if indexPath.row == 2{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
        cell.lblCellName.text = "Phone Number"
            cell.txfCellData.text = self.userData["phone"] as? String
        cell.txfCellData.isHidden = false
        
        //do the swift stuff
        return cell
        }else if indexPath.row == 3{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
            cell.lblCellName.text = "Password"
            cell.txfCellData.text = "abc123123"
            cell.txfCellData.isHidden = false
            cell.txfCellData.isSecureTextEntry = true
            
            //do the swift stuff
            return cell
        }else if indexPath.row == 4{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
            cell.lblCellName.text = "Notification"
            cell.notificationSwitch.isHidden = false
            //do the swift stuff
            return cell
        }else if indexPath.row == 5{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell  else {return UITableViewCell()}
            cell.lblCellName.text = "My List"
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell
        }else if indexPath.row == 6{
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
        
        if indexPath.row == 5 { //Go to My List
            performSegue(withIdentifier: "toUserListSegue", sender: self)
        }else if indexPath.row == 6{ //Go to feedback ViewController
            performSegue(withIdentifier: "sendFeedbackSegue", sender: self)
        }else if indexPath.row == 7{ //Logout
            self.handleLogount()
            
        }
    }
    
    
}
