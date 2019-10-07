//
//  FeedbackViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-09-29.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    
    @IBOutlet weak var txfLeaveFeedback: UITextView!
    @IBOutlet weak var txfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Feedback"
    }
    
    @IBAction func btnSendFeedbackClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Feedback sent", message: "You have send your feedback to us. Thank you for participating on the LEAF improvement.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
            //Cancel action clicked
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            //Send feedback to the server
            
            //dismiss view controller
            self.navigationController?.popViewController(animated: true)

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
