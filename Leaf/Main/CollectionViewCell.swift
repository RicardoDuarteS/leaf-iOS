//
//  CollectionViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-02.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ImgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
