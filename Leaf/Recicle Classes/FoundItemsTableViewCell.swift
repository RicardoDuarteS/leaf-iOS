//
//  FoundItemsTableViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-26.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class FoundItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txfDescription: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
