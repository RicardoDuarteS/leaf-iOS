//
//  ChstViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-07-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtMessageBox: UITextField!
    
    @IBOutlet weak var btnSendMessage: UIButton!
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(self.userName ?? "Username")"
        print(self.userName)
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnSendMessageClicked(_ sender: UIButton) {
        
        
        
        
    }
    
    

}
