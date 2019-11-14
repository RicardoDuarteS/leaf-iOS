//
//  ChatListTableViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-07-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblChatPreview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
