//
//  RDTListingData.swift
//  ReddItKnockOff
//
//  Created by Anuj Deshmukh on 11/20/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import Foundation

class RDTListingData: RDTBaseModel, NSCoding {

    override init() {
        super.init()
    }
    
    public var id : Int?
    public var numComments : Int?
    public var title : String?
    public var author : String?
    public var thumbnailUrl : String?
    private var createdTimeInterval : String?
    public var createdAt : Date?
    
    private let _titleKey = "title"
    private let _createdKey = "created"
    private let _thumbnailKey = "thumbnail"
    private let _authorKey = "author"
    private let _numCommentsKey = "num_comments"
    
    override func parse(_ dataDict: [String : Any]?) {
        guard let dict = dataDict else {return}
        if let listingData = dict["data"] as? Dictionary<String, AnyObject> {
            if let created = RDTParser.getDouble(listingData[_createdKey]) {
                createdAt = Date(timeIntervalSince1970: created)
            }
            
            title = RDTParser.getString(listingData[_titleKey])
            author = RDTParser.getString(listingData[_authorKey])
            thumbnailUrl = RDTParser.getString(listingData[_thumbnailKey])
            numComments = RDTParser.getInt(listingData[_numCommentsKey])
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: _titleKey) as? String
        thumbnailUrl = aDecoder.decodeObject(forKey: _thumbnailKey) as? String
        author = aDecoder.decodeObject(forKey: _authorKey) as? String
        numComments = aDecoder.decodeObject(forKey: _numCommentsKey) as? Int
        createdAt = aDecoder.decodeObject(forKey: _createdKey) as? Date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: _titleKey)
        aCoder.encode(author, forKey: _authorKey)
        aCoder.encode(thumbnailUrl, forKey: _thumbnailKey)
        aCoder.encode(numComments, forKey: _numCommentsKey)
        aCoder.encode(createdAt, forKey: _createdKey)
        
    }
}
