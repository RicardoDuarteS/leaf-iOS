//
//  AppManager.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-13.
//  Copyright © 2019 Khromos. All rights reserved.
//

import Foundation
import UIKit

class AppManager {
    
    var myPickerData = [String](arrayLiteral: "Animal","Backpack", "Clothing","Document/ID", "Eletronic","Phone","Wallet", "Purse", "Others")
    
    let randomImages = ["lostDog", "lostCat", "lostWallet", "lostLicence", "lostId", "lostPurse"]
    
    let filterOptions = ["Select category","Purse","Pet","Wallet","Document","Phone","Other"]
    
    var searchField: Bool = false
    
    func openCloseSearchBar(closedValue: Int, openedValue: Int, constraint: NSLayoutConstraint){
        if searchField == false {
            constraint.constant = 40
            self.searchField = true
        } else{
            constraint.constant = 0
            self.searchField = false
        }
    }
    
    func showToast(message : String, view: UIView) {
        
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
