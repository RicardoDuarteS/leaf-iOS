//
//  ApiManager.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-10-16.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ApiManager {
    
    func addLostItem(userID: String?, itemName: String?, category: String?, location: String?, description: String?, reward: String?, itemPicture: UIImageView?){
        
        //unwrap data
        guard let thisUserID = userID, let thisItemName = itemName, let thisCategory = category, let thisLocation = location, let thisDescription = description, let thisReward = reward , let thisItemPicture = itemPicture else {
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        //Name image
        let imageName = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("lost_items").child("item_\(imageName).png")
        //upload data
        if let uploadData = itemPicture?.image!.pngData(){
            storageRef.putData(uploadData, metadata: nil) { (_, err) in
                if let error = err {
                    print(error)
                    return
                }
                storageRef.downloadURL { (url, err) in
                    if let err = err{
                        print(err)
                        return
                    }
                    
                    guard let url = url else {return}
                    //Add values
                    
                    
                    let value = ["user_id": Auth.auth().currentUser?.uid,
                    "itemName": itemName,
                    "category": category,
                    "location": location,
                    "description": description,
                    "reward": reward,
                    "item_picture": url.absoluteString] as [String: AnyObject]
                    
                    
                    let values = LostItem(dictionary: value)
                    //save
                    self.registerLostItemIntoDatabaseWithUID(uid, values: value)
                    self.registerLostItemIntoDatabaseArrayWithUID(uid, values: value)
                    
                }
            }
        }
    }
    
        
    func registerLostItemIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]){
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid).child("lost_item").childByAutoId()
                
                usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if let err = err {
                        print(err)
                        return
                    }
                    print("Saved user successfully into firebase database")
                })
    }
    
    func registerLostItemIntoDatabaseArrayWithUID(_ uid: String, values: [String: AnyObject]){
        let ref = Database.database().reference()
        let usersReference = ref.child("lost_item").childByAutoId()
                
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
            if let err = err {
                print(err)
                return
            }
            print("Saved user successfully into firebase database")
        })
    }
    
    //Found
    
    func addFoundItem(itemName: String?, category: String?, location: String?, description: String?, itemPicture: UIImageView?){
        
        //unwrap data
        guard let thisItemName = itemName, let thisCategory = category, let thisLocation = location, let thisDescription = description, let thisItemPicture = itemPicture else {
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        //Name image
        let imageName = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("found_items").child("item_\(imageName).png")
        //upload data
        if let uploadData = itemPicture?.image!.pngData(){
            storageRef.putData(uploadData, metadata: nil) { (_, err) in
                if let error = err {
                    print(error)
                    return
                }
                storageRef.downloadURL { (url, err) in
                    if let err = err{
                        print(err)
                        return
                    }
                    
                    guard let url = url else {return}
                    //Add values
                    
                    let value = ["user_id": Auth.auth().currentUser?.uid,
                    "itemName": itemName,
                    "category": category,
                    "location": location,
                    "description": description,
                    "item_picture": url.absoluteString] as [String: AnyObject]
                    
//                    let values = LostItem(dictionary: value)
                    //save
                    self.registerItemFoundIntoDatabaseWithUID(uid, values: value)
                    self.registerItemFoundIntoDatabaseArrayWithUID(uid, values: value)
                    
                }
            }
        }
    }
    
    func registerItemFoundIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]){
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid).child("found_items").childByAutoId()
                
                usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if let err = err {
                        print(err)
                        return
                    }
                    print("Saved user successfully into firebase database")
                })
    }
    
    func registerItemFoundIntoDatabaseArrayWithUID(_ uid: String, values: [String: AnyObject]){
        let ref = Database.database().reference()
        let usersReference = ref.child("found_items").childByAutoId()
                
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
            if let err = err {
                print(err)
                return
            }
            print("Saved user successfully into firebase database")
        })
    }

    //User Feedback
//    func SendFeedback(userEmail: String?, message: String?){
//
//                //unwrap data
//                guard let thisuserEmail = userEmail, let thisMessage = message else {
//                    return
//                }
//
//                guard let uid = Auth.auth().currentUser?.uid else {
//                    return
//                }
//
//                let storageRef = Storage.storage().reference().child("feedback")
//                //upload data
//                storageRef.downloadURL { (url, err) in
//                    if let err = err{
//                        print(err)
//                        return
//                    }
//
//
//                    self.registerUserFeedbackWithUID(uid, values: value as [String : AnyObject])
//                }
//            }
    
    func registerUserFeedbackWith(userEmail: String?, message: String?){
        let ref = Database.database().reference()
        let usersReference = ref.child("feedback").childByAutoId()
        
        guard let thisEmail = userEmail, let thisMessage = message else {return}
        
        let value = ["user_email": thisEmail,
        "user_feedback": thisMessage]
                
        usersReference.setValue(value, withCompletionBlock: { (err, ref) in
            if let err = err {
                print(err)
                return
            }
            print("Saved user successfully into firebase database")
        })
    }

}
