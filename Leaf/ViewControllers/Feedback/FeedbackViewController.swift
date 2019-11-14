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
    
    let apiManager = ApiManager()
    let appManager = AppManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Feedback"
    }
    
    func sendFeedback(){
        guard let email = txfEmail.text, let message = txfLeaveFeedback.text else {return}
        if txfEmail.text != "" && txfLeaveFeedback.text != ""{
            apiManager.registerUserFeedbackWith(userEmail: email, message: message)
        }else if txfLeaveFeedback.text == ""{
            appManager.displayAlertWithOneOption(title: "Feedback Failure", message: "You have at least to fill the message in order to send a valid feedback. Try again", view: self)
        }
        
    }
    
    @IBAction func btnSendFeedbackClicked(_ sender: UIButton) {
        sendFeedback()
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
