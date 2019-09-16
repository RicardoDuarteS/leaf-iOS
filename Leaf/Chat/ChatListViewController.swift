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
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    static func storyboardInstance() -> ChatListViewController? {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController
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
        cell.lblChatPreview.text = "Bla bla bla Bla bla bla Bla bla bla Bla bla bla Bla bla bla"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chatSegue", sender: self)
    }
    
    
}
