//
//  LostItem.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-10-16.
//  Copyright © 2019 Khromos. All rights reserved.
//

import Foundation

class LostItem: NSObject {
    var userID: String?
    var itemName: String?
    var category: String?
    var location: String?
    var itemDescription: String?
    var itemImageUrl: String?
    var reward: String?
    
    init(dictionary: [String: AnyObject]) {
        self.userID = dictionary["user_id"] as? String ?? ""
        self.itemName = dictionary["itemName"] as? String ?? ""
        self.category = dictionary["category"] as? String ?? ""
        self.location = dictionary["location"] as? String ?? ""
        self.itemDescription = dictionary["description"] as? String ?? ""
        self.itemImageUrl = dictionary["item_picture"] as? String ?? ""
        self.reward = dictionary["reward"] as? String ?? "0.00"
    }
    
}
