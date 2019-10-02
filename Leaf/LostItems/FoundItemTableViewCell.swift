//
//  LostItemTableViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-13.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class FoundItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lblItemTitle: UILabel!
    @IBOutlet weak var txvItemDescription: UITextView!
    @IBOutlet weak var viewBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBackground.layer.borderWidth = 2
        self.viewBackground.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
