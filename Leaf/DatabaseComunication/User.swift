//
//  User.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-10-06.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class User: NSObject {
        
    private var _username: String = ""
    private var _email: String = ""
    private var _phone: String = ""
    
       
    var username: String? {
        return _username
    }
       
    var email: String? {
        return _email
    }
    
    var phone: String?{
        return _phone
    }
       
    override init(){
        self._username = ""
        self._email = ""
        self._phone = ""
    }
       
    init(username: String, email: String, phone: String){
         self._username = username
         self._email = email
        self._phone = phone
       }
    
}
