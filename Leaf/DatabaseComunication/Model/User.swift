//
//  User.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-10-06.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var username: String?
    var email: String?
    var phone: String?
    var profileImageUrl: String?
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.profileImageUrl = dictionary["profile_image"] as? String ?? ""
    }
    
}
