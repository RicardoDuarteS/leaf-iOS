//
//  ChatListViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-07-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class ChatListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var profilePhoto = ["profilePhoto1", "profilePhoto2", "profilePhoto3", "profilePhoto4", "profilePhoto5"]

    var users = [User]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Chat"
        registerNib()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func registerNib(){
        let nibName = UINib(nibName: "ChatListTableViewCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "ChatListTableViewCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func fetchUser(){
        //reference database
        self.ref = Database.database().reference()
        self.ref?.child("users").observe(.childAdded, with: { (snapshot) in
        print("User found")
        print(snapshot)
        //set dictionary as the array and use its key to identify each item
        if let dictionary = snapshot.value as? [String: AnyObject]{
            let user = User(dictionary: dictionary)
            self.users.append(user)
            print(user)
            //dispatch
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }
    }, withCancel: nil)
}
    
    
     
}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as? ChatListTableViewCell else {return UITableViewCell()}
        let currentUser = users[indexPath.row]
        print(currentUser)
        cell.lblUserName.text = currentUser.username
        cell.lblChatPreview.text = currentUser.email
        
        return cell
    }
    //send data to chat view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "chatSegue", sender: self)

    }
//    //Delete row
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("User \(self.profileName[indexPath.row]) deleted")
//            self.profileName.remove(at: indexPath.row)
//            self.tableView.beginUpdates()
//            self.tableView.deleteRows(at: [indexPath], with: .left)
////            self.tableView.reloadData()
//            self.tableView.endUpdates()
//
//        }
//    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if segue.identifier == "chatSegue"{
                if let nextViewController = segue.destination as? ChatViewController {
//                    nextViewController.userName = self.username
                }
            }
        }
    
    
}

