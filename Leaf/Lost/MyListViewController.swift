//
//  LostItemViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-27.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "My List"
        registerNib()
        let viewWidth = view.frame.width / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: viewWidth, height: viewWidth)
    }
    
    func registerNib(){
        let nibName = UINib(nibName: "MyListCollectionViewCell", bundle: nil)
        self.collectionView.register(nibName, forCellWithReuseIdentifier: "MyListCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    

    

}

extension MyListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
//    //FlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//    
//    //--------------------------------------------------------------------------------
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }
//    
//    //--------------------------------------------------------------------------------
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: ( self.collectionView.frame.size.width - 60) / 2,height:( self.collectionView.frame.size.width - 60) / 2)
//    }
//    
//    //--------------------------------------------------------------------------------
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyListCollectionViewCell", for: indexPath) as? MyListCollectionViewCell else {return UICollectionViewCell()}
        cell.imgItemPhoto.image = UIImage(named: "gameSample1")
        cell.lblItemName.text = "Itemname # \(indexPath)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Perform phone call
        
    }
    
    
    
}
