//
//  RDTParser.swift
//  ReddItKnockOff
//
//  Created by Anuj Deshmukh on 11/21/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import Foundation

class RDTParser {
    static func getString(_ str: Any?) -> String? {
        guard let strData = str else {return nil}
        if strData is String {
            return strData as? String
        }
        return nil
    }
    
    static func getDouble(_ double: Any?) -> Double? {
        guard let doubleData = double else {return nil}
        if doubleData is Double {
            return doubleData as? Double
        }
        return nil
    }
    
    static func getInt(_ int: Any?) -> Int? {
        guard let intData = int else {return nil}
        if intData is Double {
            return intData as? Int
        }
        return nil
    }
    
    static func getDict(_ dict: [String : Any]?) -> [String : Any]? {
        guard let dictData = dict else {return nil}
        return dictData
    }
}
