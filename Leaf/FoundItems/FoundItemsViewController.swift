//
//  FoundItemsViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-26.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

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
    
    var lostOrFoundSelector = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Found"
            registerNib()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            self.searchConstraint.constant = 0
    //        self.collectionView.isHidden = true
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
            return appManager.randomImages.count
        }else{
            return appManager.filterOptions.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LostItemCollectionViewCell", for: indexPath) as? LostItemCollectionViewCell else {return UICollectionViewCell()}
                
            cell.imgItemPhoto.image = UIImage(named: "\(appManager.randomImages[indexPath.row])")
            cell.lblItemName.text = "\(appManager.randomImages[indexPath.row])"
            cell.lblLocation.text = "Calgary, AB"
            cell.lblReward.isHidden = true
            cell.lblRewardValue.isHidden = true

            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterBarCollectionViewCell", for: indexPath) as? FilterBarCollectionViewCell else {return UICollectionViewCell()}
            
            cell.btnFilterOption.setTitle("\(appManager.filterOptions[indexPath.row])", for: .normal)
                
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectedItemFromFoundItemSegue", sender: self)
    }
}


