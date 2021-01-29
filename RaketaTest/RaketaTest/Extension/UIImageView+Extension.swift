//
//  ImageView+Extension.swift
//  RaketaTest
//
//  Created by mac on 29.01.2021.
//

import UIKit

let cache = NSCache<NSString, UIImage>()

public extension UIImageView {

    final func loadImage(with imageURL: String, placeHolder: UIImage?) {
        
        self.image = nil

        let imageServerUrl = imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = cache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            cache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
