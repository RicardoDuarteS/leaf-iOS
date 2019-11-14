//
//  ProductViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-04.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var txvDescription: UITextView!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Description"
        // Do any additional setup after loading the view.
    }
    
    
    static func storyboardInstance() -> ProductsViewController? {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ProductViewController") as? ProductsViewController
    }

    //button
    @IBAction func btnContactClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Contact", message: nil, preferredStyle: .actionSheet)
        
        let alertCall = UIAlertAction(title: "Call", style: .default) { _ in
            //Perform phone call
            //Use the phone number from the API
            if let url = URL(string: "tel://\(7783255098)") {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(alertCall)
        let sendEmail = UIAlertAction(title: "E-mail", style: .default) { _ in
            //Send email
        }
        alert.addAction(sendEmail)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel alert")
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    

}
