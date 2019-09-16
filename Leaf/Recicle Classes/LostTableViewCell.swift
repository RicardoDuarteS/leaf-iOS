//
//  LostTableViewCell.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-06.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class LostTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProductImage: UIImageView!
    @IBOutlet weak var btnClaimProduct: UIButton!
    @IBOutlet weak var lblHonestyCount: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    var didTouchOnClaimButton:((_ button: UIButton) -> Void)?
    var didTouchOnFollowButton:((_ button: UIButton) -> Void)?
    
    var isFollowed: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnClaimProductClicked(_ sender: UIButton) {
        self.didTouchOnClaimButton?(sender)
    }
    
    @IBAction func btnFollowClicked(_ sender: UIButton) {
        self.didTouchOnFollowButton?(sender)
    }
    
}
