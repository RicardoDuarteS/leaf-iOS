//
//  ProfileTableViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCellName: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var txfCellData: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
