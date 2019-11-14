//
//  LostItemViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-26.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class LostItemViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterBarCollectionView: UICollectionView!
    
    @IBOutlet weak var searchConstraint: NSLayoutConstraint!
    @IBOutlet weak var txfSearch: UITextField!
    
    let appManager = AppManager()
    
//    var lostData : [String: AnyObject] = [:]
    var lostItemArray = [LostItem]()
        
    var lostOrFoundSelector = 1
    
    
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            self.title = "Lost"
            registernib()
            self.fetchLostItemsData()
        }
        
    override func viewWillAppear(_ animated: Bool) {
        self.searchConstraint.constant = 0
        

    }
        
        func registernib(){
            //Collection View
            let nibname = UINib(nibName: "LostItemCollectionViewCell", bundle: nil)
            self.collectionView.register(nibname, forCellWithReuseIdentifier: "LostItemCollectionViewCell")
            //Filter
            let filterName = UINib(nibName: "FilterBarCollectionViewCell", bundle: nil)
            self.filterBarCollectionView.register(filterName, forCellWithReuseIdentifier: "FilterBarCollectionViewCell")
            
            //Set 2 cells each row
            let viewWidth = (self.view.frame.width) / 2
//            let viewHeigh = self.view.frame.height - 128
            let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: viewWidth, height: viewWidth)
            
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            
            self.filterBarCollectionView.delegate = self
            self.filterBarCollectionView.dataSource = self
            
        }
    
    func fetchLostItemsData(){

        let reference = Database.database().reference()
        reference.child("lost_item").observe(.value) { (snapshot) in
            
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let itemID = child.key as String
                    
                    reference.child("lost_item/\(itemID)").observe(.value) { (dataSnapshow) in
                        guard let dictionary = dataSnapshow.value as? [String: AnyObject] else {return}
                        
                        let lostItem = LostItem.init(dictionary: dictionary)
                        self.lostItemArray.append(lostItem)
                        self.collectionView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedItemFromLostItemSegue" {
            if let nextViewController = segue.destination as? SelectedItemViewController {
                nextViewController.lostOrFoundSelector = self.lostOrFoundSelector
                nextViewController.lostItemSelected = self.lostItemArray
            }
            
        }
    }
    
    @IBAction func btnSearchClicked(_ sender: UIButton) {
    }
    
    @IBAction func btnShowSearchClicked(_ sender: UIBarButtonItem) {
        appManager.openCloseSearchBar(closedValue: 0, openedValue: 40, constraint: searchConstraint)
    }
    
    }

    extension LostItemViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return lostItemArray.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let currentItem = lostItemArray[indexPath.row]
            
            if collectionView == self.collectionView {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LostItemCollectionViewCell", for: indexPath) as? LostItemCollectionViewCell else {return UICollectionViewCell()}
                
                if let profileImageUrl = currentItem.itemImageUrl {
                    cell.imgItemPhoto.loadImageUsingCacheWithURLString(profileImageUrl as! String)
                }
                    
                cell.lblItemName.text =  currentItem.itemName
                cell.lblLocation.text = currentItem.location
                cell.lblRewardValue.text = "CAD$: \(currentItem.reward ?? "0").00"
                    

                return cell
            }else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterBarCollectionViewCell", for: indexPath) as? FilterBarCollectionViewCell else { return UICollectionViewCell()}
                cell.btnFilterOption.setTitle("\(appManager.filterOptions[indexPath.row + 1])", for: .normal)
                return cell
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let currentItem = lostItemArray[indexPath.row]
            performSegue(withIdentifier: "selectedItemFromLostItemSegue", sender: self)
            
            
        }
        
        
    }

