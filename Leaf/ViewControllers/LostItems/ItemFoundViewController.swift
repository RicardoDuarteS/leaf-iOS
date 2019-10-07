//
//  ItemFoundViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-17.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ItemFoundViewController: UIViewController {
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    let appManager = AppManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registernib()
    }
    
    
    func registernib(){
        let nibname = UINib(nibName: "MyListCollectionViewCell", bundle: nil)
        self.collectionview.register(nibname, forCellWithReuseIdentifier: "MyListCollectionViewCell")
        //Set 2 cells each row
        let viewWidth = self.view.frame.width
        let viewHeigh = self.view.frame.height - 128
        let layout = self.collectionview.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: viewWidth, height: viewHeigh)
        
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
    }

}

extension ItemFoundViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appManager.randomImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyListCollectionViewCell", for: indexPath) as? MyListCollectionViewCell else {return UICollectionViewCell()}
        
            cell.imgItemPhoto.image = UIImage(named: "\(appManager.randomImages[indexPath.row])")
            cell.lblItemName.text = "\(appManager.randomImages[indexPath.row]))"
            cell.lblLocation.text = "Calgary, AB"
        

            return cell
    }
    
    
}
