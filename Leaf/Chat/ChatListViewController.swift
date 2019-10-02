//
//  ChatListViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-07-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var profilePhoto = ["profilePhoto1", "profilePhoto2", "profilePhoto3", "profilePhoto4", "profilePhoto5"]
    var profileName = ["User1", "User2", "User3", "User4", "User5"]
    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Chat"
        registerNib()
        
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
    

    

}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profilePhoto.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as? ChatListTableViewCell else {return UITableViewCell()}
        cell.imgUserImage.image = UIImage(named: profilePhoto[indexPath.row])
        cell.lblUserName.text = profileName[indexPath.row]
        
        print(self.username)
        cell.lblChatPreview.text = "Bla bla bla Bla bla bla Bla bla bla Bla bla bla Bla bla bla"
        
        return cell
    }
    //send data to chat view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.username = profileName[indexPath.row]
        performSegue(withIdentifier: "chatSegue", sender: self)

    }
    //Delete row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("User \(self.profileName[indexPath.row]) deleted")
            self.profileName.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .left)
            self.tableView.endUpdates()
            self.tableView.reloadData()
        }
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if segue.identifier == "chatSegue"{
                if let nextViewController = segue.destination as? ChatViewController {
                    nextViewController.userName = self.username
                }
            }
        }
    
    
}

