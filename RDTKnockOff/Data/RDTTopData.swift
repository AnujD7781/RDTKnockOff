//
//  RDTTopData.swift
//  ReddItKnockOff
//
//  Created by Anuj Deshmukh on 11/20/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import Foundation

class RDTTopData: RDTBaseModel, NSCoding {
    private let _afterKey = "after"
    private let _listingArrKey = "listingArr"
    private var before : String?
    private var after : String?
    private let limit = 10
    public var listingArr = Array<RDTListingData>()
    
    override init() {
        super.init()
    }
    
    override func getPath() -> String {
        guard let afterParam = after else {
            return "https://www.reddit.com/top.json?limit=\(limit)"
        }
        return "https://www.reddit.com/top.json?limit=\(limit)&after=\(afterParam)"
    }
    
    override func parse(_ dataDict: [String : Any]?) {
        guard let data = dataDict else {return}
        
        if let childrenArr = data["children"] as? NSArray {
            for listingDict in childrenArr {
                let listingData = RDTListingData() as RDTListingData
                if let paramData = listingDict as? Dictionary<String, AnyObject> {
                    listingData.parse(RDTParser.getDict(paramData))
                    listingArr.append(listingData)
                }
            }
        }
        after = RDTParser.getString(data["after"])
    }
    
    required init(coder aDecoder: NSCoder) {
        after = aDecoder.decodeObject(forKey: _afterKey) as? String
        guard let arr = aDecoder.decodeObject(forKey: _listingArrKey) else {
            return
        }
        listingArr = arr as! [RDTListingData]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(after, forKey: _afterKey)
        aCoder.encode(listingArr, forKey: _listingArrKey)
        
    }
}
