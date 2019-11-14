//
//  FoundItemsViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-26.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FoundItemsViewController: UIViewController {

   //Search
        @IBOutlet weak var searchConstraint: NSLayoutConstraint!
        @IBOutlet weak var txfSearch: UITextField!
        @IBOutlet weak var btnSearch: UIButton!
        @IBOutlet weak var btnOpenCloseSearchField: UIBarButtonItem!
            
        //Collection View
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterBarCollectionView: UICollectionView!
    
    let appManager = AppManager()
    var itemFoundArray = [FoundItem]()
    var lostOrFoundSelector = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Found"
            self.navigationController?.isToolbarHidden = true

            registerNib()
            fetchItemFoundData()
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            self.searchConstraint.constant = 0
            self.collectionView.reloadData()
            
        }
        
        func registerNib(){
            //register collectionview cell
            let nibName = UINib(nibName: "LostItemCollectionViewCell", bundle: nil)
            self.collectionView.register(nibName, forCellWithReuseIdentifier: "LostItemCollectionViewCell")
            
            let filterName = UINib(nibName: "FilterBarCollectionViewCell", bundle: nil)
            self.filterBarCollectionView.register(filterName, forCellWithReuseIdentifier: "FilterBarCollectionViewCell")
            
            //Set 2 cells each row
            let viewWidth = (self.view.frame.width) / 2
            //            let viewHeigh = self.view.frame.height - 128
            let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: viewWidth, height: viewWidth)
            
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.filterBarCollectionView.delegate = self
            self.filterBarCollectionView.dataSource = self
            
        }
    
    func fetchItemFoundData(){

        let reference = Database.database().reference()
        reference.child("found_items").observe(.value) { (snapshot) in
            
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let itemID = child.key as String
                    
                    reference.child("found_items/\(itemID)").observe(.value) { (dataSnapshow) in
                        guard let dictionary = dataSnapshow.value as? [String: AnyObject] else {return}
                        
                        let itemFound = FoundItem.init(dictionary: dictionary)
                        self.itemFoundArray.append(itemFound)
                        self.collectionView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func handleLogout(){
        //logout from the server
        do{
            try Auth.auth().signOut()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            let vc = LoginViewController()
            present(vc, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
        }catch let signOutError as NSError{
            print("Error signing out: %@ ", signOutError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedItemFromFoundItemSegue" {
            if let nextViewController = segue.destination as? SelectedItemViewController {
                nextViewController.lostOrFoundSelector = self.lostOrFoundSelector
            }
        }
    }
       
        @IBAction func btnSearchClicked(_ sender: UIButton) {
            
        }
        
        @IBAction func btnOpenCloseSearchFieldClicked(_ sender: UIBarButtonItem) {
            appManager.openCloseSearchBar(closedValue: 0, openedValue: 40, constraint: searchConstraint)
        }
}


    //collectionView
extension FoundItemsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return itemFoundArray.count
        }else{
            return appManager.filterOptions.count - 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let currentItem = itemFoundArray[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LostItemCollectionViewCell", for: indexPath) as? LostItemCollectionViewCell else {return UICollectionViewCell()}
            
            if let profileImageUrl = currentItem.itemImageUrl {
                cell.imgItemPhoto.loadImageUsingCacheWithURLString(profileImageUrl as! String)
                
            }
            
            cell.lblItemName.text = currentItem.itemName
            cell.lblLocation.text = currentItem.location
            cell.lblReward.isHidden = true
            cell.lblRewardValue.isHidden = true

            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterBarCollectionViewCell", for: indexPath) as? FilterBarCollectionViewCell else {return UICollectionViewCell()}
            
            cell.btnFilterOption.setTitle("\(appManager.filterOptions[indexPath.row + 1])", for: .normal)
                
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectedItemFromFoundItemSegue", sender: self)
    }

}


