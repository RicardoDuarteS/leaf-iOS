//
//  LostItemCollectionViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-27.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class MyListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgItemPhoto: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgItemPhoto.layer.borderWidth = 2
        self.imgItemPhoto.layer.borderColor = UIColor.black.cgColor
        // Initialization code
    }

}
