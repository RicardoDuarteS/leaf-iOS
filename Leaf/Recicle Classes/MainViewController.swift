//
//  MainViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-02.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

//    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnOpenSearchView: UIBarButtonItem!
    //searchview
    @IBOutlet weak var searchConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var btnSearching: UIButton!
    
    private var refreshControl = UIRefreshControl()
    
    var image = ["gameSample1","gameSample2","gameSample3","gameSample4"]
    var showSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Losts"
        registerNib()
        
    }
    

    
    func registerNib(){
        let nibName = UINib(nibName: "LostTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "LostTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        //If version 10.0 ahead it has the refresh controll. Otherwise you add a subview with the refresh
        if #available(iOS 10.0, *){
            self.tableView.refreshControl = refreshControl
        }else{
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshTableviewData(_:)), for: .valueChanged)
    }
    
    @objc func refreshTableviewData(_ sender: Any){
        fetchLostData()
    }
    
    func fetchLostData(){
        print("Update data")
        self.tableView.reloadData()
    }
    
    @IBAction func btnOpenSearchViewClicked(_ sender: UIBarButtonItem) {
        if showSearch == false {
            UIView.animate(withDuration: 1) {
                self.searchConstraint.constant = 0
            }
            
            showSearch = !showSearch
        }else{
            UIView.animate(withDuration: 1) {
                self.searchConstraint.constant = -80
                self.txfSearch.text = ""
            }
            
            showSearch = !showSearch
        }
    }
    
    @IBAction func btnSearchCLicked(_ sender: UIButton) {
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height / 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LostTableViewCell", for: indexPath) as? LostTableViewCell else {return UITableViewCell()}
        
        cell.didTouchOnFollowButton = {
            button in
            if cell.isFollowed == true {
                cell.btnFollow.setImage(UIImage(named: "heartRed"), for: .normal)
                cell.isFollowed = !cell.isFollowed
            }else{
                cell.btnFollow.setImage(UIImage(named: "heartOutline"), for: .normal)
                cell.isFollowed = !cell.isFollowed
            }
        }
        
        cell.didTouchOnClaimButton = {
            button in
                self.performSegue(withIdentifier: "productsSegue", sender: self)
        }
        return cell
    }
    
    
    
}

