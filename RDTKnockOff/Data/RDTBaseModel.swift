//
//  File.swift
//  ReddItKnockOff
//
//  Created by Anuj Deshmukh on 11/20/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import Foundation

class RDTBaseModel: NSObject {
    
    func fetch(completion: ((Error?) -> Void)? = nil) {
        guard let url = URL(string: self.getPath()) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { (data, responseData, error) in
            guard let data = data, error == nil else { return }
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                self.parse(RDTParser.getDict(dict["data"] as? [String : Any])!)
                guard let completionHandler = completion else {
                    return
                }
                DispatchQueue.main.async {
                    completionHandler(error)
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getPath() -> String {
        return ""
    }
    
    func parse(_ dataDict :[String:Any]?) {
        
    }
}
