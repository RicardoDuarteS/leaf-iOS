//
//  SelectedItemViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-08-14.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class SelectedItemViewController: UIViewController {
    
    @IBOutlet weak var imgItemPhoto: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var txvItemDescription: UITextView!
    //Pop Up view
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var txvMessage: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        // Fetch the result for blocked/unblocked post
    }
    
    @IBAction func btnContactClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Contact user", message: "Contact the user to arrange your pick up", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Phone Call", style: .default, handler: { (UIAlertAction) in
            //perform phone call
            if let url = URL(string: "tel://\(7782235099)") {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Email", style: .default, handler: { (UIAlertAction) in
            //Send email
        }))
        alert.addAction(UIAlertAction(title: "Message User", style: .default, handler: { (UIAlertAction) in
            //Send to message
            self.performSegue(withIdentifier: "toChatSegue", sender: self)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            print("Close pop up")
        }))
        self.present(alert, animated: true, completion: {
            print("Completion block")
        })
    }
    
    @IBAction func btnSendMessageClicked(_ sender: UIButton) {
        //Send Message to the user
    }
    

}
