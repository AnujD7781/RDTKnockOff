//
//  RDTKnockOffTests.swift
//  RDTKnockOffTests
//
//  Created by Anuj Deshmukh on 11/27/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import XCTest
@testable import RDTKnockOff

class RDTKnockOffTests: XCTestCase {
    
    var fileManager:FileManager!
    var bundle:Bundle!
    
    override func setUp() {
        super.setUp()
        fileManager = FileManager.default
        bundle = Bundle(for: RDTKnockOffTests.self)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRDTListings() {
        let data = fileManager.contents(atPath: bundle.path(forResource: "RDTMockResponse", ofType: "json")!)
        XCTAssertNotNil(data)
        
        let userJSONFromData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue: 0))
        XCTAssertNotNil(userJSONFromData)
        XCTAssertTrue(userJSONFromData is [String: Any])
        let dataDict = userJSONFromData as! [String: Any]
        
        let topData = RDTTopData()
        topData.parse(dataDict["data"] as? [String: Any])
        XCTAssertEqual(topData.listingArr.count, 1)
        
        let listingData = topData.listingArr[0]
        XCTAssertEqual(listingData.title, "Infant unit nurses when the earthquake hits the hospital")
        XCTAssertEqual(listingData.thumbnailUrl, "https://b.thumbs.redditmedia.com/ryagROAh_VCI7rInrztRe-YkC-FxY54DLiE3RXe9s5U.jpg")
        XCTAssertEqual(listingData.author, "slightlysadist")
        XCTAssertEqual(listingData.numComments, 3795)

    }
    
}
