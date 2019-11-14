//
//  UserListViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-28.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class UserListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let appManager = AppManager()
    var lostItemArray = [String]()
    var itemFoundArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerNib()
        fetchLostItemsData()
        fetchFoundItemsData()
    }
    
    func registerNib(){
        let nib = UINib(nibName: "UserListTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "UserListTableViewCell")
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }
    
    func fetchLostItemsData(){

        let reference = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        reference.child("users/\(userID!)/lost_item").observe(.value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            for item in dictionary{
                let itemName = item.value["itemName"]as! String
                self.lostItemArray.append(itemName)
                self.tableview.reloadData()
            }            
        }
    }
    
    func fetchFoundItemsData(){

        let reference = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        reference.child("users/\(userID!)/found_items").observe(.value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            for item in dictionary{
                let itemName = item.value["itemName"]as! String
                self.itemFoundArray.append(itemName)
                self.tableview.reloadData()
            }
        }
    }

}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Found Items"
        }else{
            return "Lost Items"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.itemFoundArray.count
        }else{
            return self.lostItemArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let currentItem = itemFoundArray[indexPath.row]

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell else { return UITableViewCell()}
            
            cell.lblItemName.text = currentItem
            cell.lblPostStatus.isHidden = true
//            cell.lblPostStatus.textColor = UIColor.red
            return cell
            
        }else{
            let currentItem = lostItemArray[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell else { return UITableViewCell()}
            cell.lblItemName.text = currentItem
            cell.lblPostStatus.isHidden = true
//            text = "Searching"
            cell.lblPostStatus.textColor = UIColor.green
            return cell
        }
    }
    
    
    
}
        
