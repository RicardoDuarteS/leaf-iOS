//
//  MainSearchViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-12.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class MainSearchViewController: UIViewController {
    
    //Search
    @IBOutlet weak var searchConstraint: NSLayoutConstraint!
    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnOpenCloseSearchField: UIBarButtonItem!
        
    //Collection View
    @IBOutlet weak var tableview: UITableView!
    
    var searchField: Bool = false
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lost and founds"
        registerNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchConstraint.constant = -40
//        self.collectionView.isHidden = true
    }
    
    func registerNib(){
        //register collectionview cell
        let nibName = UINib(nibName: "FoundItemsTableViewCell", bundle: nil)
        self.tableview.register(nibName, forCellReuseIdentifier: "FoundItemsTableViewCell")
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
    }
   
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnOpenCloseSearchFieldClicked(_ sender: UIBarButtonItem) {
        if searchField == false {
            self.searchConstraint.constant = 8
            self.searchField = true
        } else{
            self.searchConstraint.constant = -40
            self.searchField = false
            
        }
    }
}

//collectionView
extension MainSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "FoundItemsTableViewCell", for: indexPath) as? FoundItemTableViewCell else {return UITableViewCell()}
        
        cell.lblTitle.text = "Item name"
        cell.txfDescription.text = "This is the description of the item #\(indexPath)"
        cell.imgItem.image = UIImage(named: "profilePhoto\(indexPath.row + 1)")

        
        return cell
    }
    
    
    
}

