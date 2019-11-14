//
//  Extensions.swift
//  Leaf
//
//  Created by Ricardo Duarte on 2019-10-16.
//  Copyright © 2019 Khromos. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithURLString(_ urlString: String){
        
        self.image = nil
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error)
                return
            }
            DispatchQueue.main.sync {
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}
