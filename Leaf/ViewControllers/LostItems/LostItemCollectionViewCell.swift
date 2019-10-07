//
//  LostItemCollectionViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-26.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class LostItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgItemPhoto: UIImageView!
    
    @IBOutlet weak var lblItemName: UILabel!
    
    @IBOutlet weak var lblRewardValue: UILabel!
    @IBOutlet weak var lblReward: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
