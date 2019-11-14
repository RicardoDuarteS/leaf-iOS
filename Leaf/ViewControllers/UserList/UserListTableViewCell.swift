//
//  UserListTableViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-28.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPostStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
