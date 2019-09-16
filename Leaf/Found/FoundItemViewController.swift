//
//  LostItemViewController.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-06-13.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class SelectedItemViewController: UIViewController {

    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let appManager = AppManager()
    let pickerView = UIPickerView()
    
    var titleArray = ["Lost wallet", "Lost Backpack", "Lost Cellphone", "Lost Cat", "Lost Dog"]
    var textArray = [
            "I found a wallet at somerset station yesterday night (june 12nd. It's black and the id is for johnatan",
            "I found a green backpack in the Public Library. I just gave it to the customer service.",
            "I found a black iphone X on the Chinook Mall. I just gave it back to the lost and founds.",
            "I found a black cat. He's using a colar with Maggie's Name. She's ok and waiting fot the owner",
            "I found a puppy this week. It's a baccet and it's pretty thin and needs attention. THere's no collar but it seems to be someone's dog"
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerNib()
        
        self.txfSearch.inputView = pickerView
        self.pickerView.delegate = self

    }
    
    func registerNib(){
        let nibName = UINib(nibName: "FoundItemTableViewCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "FoundItemTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    @IBAction func btnSearchClicked(_ sender: UIButton) {
    }
}

extension SelectedItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appManager.myPickerData.count
        
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appManager.myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txfSearch.text = appManager.myPickerData[row]
    }
    
    
}

extension SelectedItemViewController: UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoundItemTableViewCell", for: indexPath) as? FoundItemTableViewCell else {return UITableViewCell()}
        cell.lblItemTitle.text = titleArray[indexPath.row]
        cell.txvItemDescription.text = textArray[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        //Action Sheet
        let alert = UIAlertController(title: "Contact User", message: "Which way do you want to contact the user?", preferredStyle: .actionSheet)

        //Phone call
        alert.addAction(UIAlertAction(title: "Phone Call", style: .default, handler: { (action) in
            if let url = URL(string: "tel://\(7782235099)") {
                UIApplication.shared.openURL(url)
            }
        }))

        //Email
        alert.addAction(UIAlertAction(title: "Email", style: .default, handler: { (action) in
            //Perform email contact
            //Toast message
            //If email found
            //if emailIsValid == true {

            self.appManager.showToast(message: "Email sent", view: self.view)
            //}else{
//            self.appManager.showToast(message: "Email contact failed. try again", view: self.view)
//            }
        }))

        //Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
            print("Dismiss action sheet")
        }))

        self.present(alert, animated: true, completion: {
            print("Completion block")
        })

    }
    
    
    
}
