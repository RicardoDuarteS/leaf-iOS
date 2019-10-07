//
//  ProfileUserDetailsTableViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-05.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ProfileUserDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
