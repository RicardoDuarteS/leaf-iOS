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
    @IBOutlet weak var searchToSegmentConstraint: NSLayoutConstraint!
    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnOpenCloseSearchField: UIBarButtonItem!
    
    //Segmented control
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchField: Bool = false
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Lost and founds"
        self.registerNib()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchConstraint.constant = -40
//        self.collectionView.isHidden = true
    }
    
    func registerNib(){
        //register collectionview cell
        let collectionNib = UINib(nibName: "MyListCollectionViewCell", bundle: nil)
        self.collectionView.register(collectionNib, forCellWithReuseIdentifier: "MyListCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        if segmentedControl.selectedSegmentIndex == 0{
            let viewWidth = (self.view.frame.width) / 2
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: viewWidth, height: viewWidth)
        }else {
            let viewWidth = self.view.frame.width
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: viewWidth, height: 100)
        }
        
        
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
    
    @IBAction func segmentedControllClicked(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            //load found items and reload collection view data

            print("Found list")
            self.collectionView.reloadData()
        case 1:
            //load lost items and reload collection view data
            print("Lost list")
            self.collectionView.reloadData()
        default: break
        }
    }
    
}

//collectionView
extension MainSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyListCollectionViewCell", for: indexPath) as? MyListCollectionViewCell else {return UICollectionViewCell()}
            
            cell.imgItemPhoto.image = UIImage(named: "gameSample1")
            cell.lblItemName.text = "Itemname # \(indexPath)"
            self.collectionView.reloadData()
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyListCollectionViewCell", for: indexPath) as? MyListCollectionViewCell else {return UICollectionViewCell()}
            
            cell.imgItemPhoto.image = UIImage(named: "gameSample1")
            cell.lblItemName.text = "Itemname # \(indexPath)"
            self.collectionView.reloadData()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "selectedItemSegue", sender: self)
        
    }
    
    
}

