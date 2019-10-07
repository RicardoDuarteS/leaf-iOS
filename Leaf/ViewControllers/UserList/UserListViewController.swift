//
//  UserListViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-28.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    
    let appManager = AppManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerNib()
    }
    
    func registerNib(){
        let nib = UINib(nibName: "UserListTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "UserListTableViewCell")
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
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
            return appManager.randomImages.count
        }else{
            return appManager.randomImages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell else { return UITableViewCell()}
            
            cell.lblItemName.text = appManager.filterOptions[indexPath.row]
            cell.lblPostStatus.text = "Finished"
            cell.lblPostStatus.textColor = UIColor.red
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell else { return UITableViewCell()}
            cell.lblItemName.text = appManager.filterOptions[indexPath.row]
            cell.lblPostStatus.text = "Searching"
            cell.lblPostStatus.textColor = UIColor.green
            return cell
        }
    }
    
    
    
}
        
