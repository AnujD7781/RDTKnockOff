//
//  RDTImageViewExtension.swift
//  ReddItKnockOff
//
//  Created by Anuj Deshmukh on 11/21/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String?) {
        self.image = UIImage.init(named: "placeholder")

        guard let url = urlString else {
            return
        }
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
