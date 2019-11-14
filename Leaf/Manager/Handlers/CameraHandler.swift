//
//  CameraHandler.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-10-09.
//  Copyright © 2019 Khromos. All rights reserved.
//

import UIKit

class CameraHandler{
    
    func openCamera(imagePickerController: UIImagePickerController, viewController: UIViewController){
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            imagePickerController.allowsEditing = true
            viewController.present(imagePickerController, animated: true, completion: nil)
        }else{
            let alert  = UIAlertController(title: "Warning", message: "You can't use your camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(imagePickerController: UIImagePickerController, viewController: UIViewController){
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
}
