//
//  DictionaryExtension.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 11/30/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation

public extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    //
    // Convert Dictionary to JSON
    //
    // return: String?
    //
    func toJSONString(prettify: Bool) -> String? {
        let option: JSONSerialization.WritingOptions = (prettify == true ? JSONSerialization.WritingOptions.prettyPrinted : [])
        let jsonObjTemp: String? = fromDictionaryToJSON(option: option)
        return jsonObjTemp

    }
    
    
    //
    // Check if the key exist
    //
    // param: Key (String)
    // return: Bool
    //
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    
    //
    // Return the JSON with pretty format
    //
    var jsonStringPretty: String? {
        let tempJSON = fromDictionaryToJSON(option: JSONSerialization.WritingOptions.prettyPrinted)
        return tempJSON
    }
    
    
    //
    // Return the JSON inline
    //
    var jsonString: String? {
        let tempJSON = fromDictionaryToJSON(option: [])
        return tempJSON
    }
    
    
    //
    // Convert the dictionary (self) to JSON string
    //
    // param: JSONSerialization.WritingOptions
    // return: String?
    //
    private func fromDictionaryToJSON(option: JSONSerialization.WritingOptions)-> String? {
        var jsonToReturn: String? = nil
        guard JSONSerialization.isValidJSONObject(self) else {
            print("Dictionary - fromDictionaryToJSON, not valid JSON Object")
            return jsonToReturn
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: option)
            jsonToReturn = String(data: jsonData, encoding: .utf8)
        } catch let error as NSError {
            print("Dictionary - fromDictionaryToJSON, error: \(error)")
            jsonToReturn = nil
        }
        return jsonToReturn
    }
    
    
    //
    // Convert the String from JSON Dictionary ([String: Any]? to Bool
    //
    // param: String
    // param: [String: Any]?
    // return: Bool?
    //
    func getBool(propertyName: String) -> Bool? {
        let tempDic: NSDictionary = self as NSDictionary
        let valueToReturn: Bool? = tempDic[propertyName] as? Bool
        if valueToReturn == nil {
            // Not valid type for conversion
            print("Dictionary - getBool, Returning nil as the value was null.")
        }
        
        return valueToReturn
    }
    
    
    //
    // Convert the String from JSON Dictionary ([String: Any]? to Int
    //
    // param: String
    // param: [String: Any]?
    // return: Int?
    //
    func getInt(propertyName: String) -> Int? {
        let tempDic: NSDictionary = self as NSDictionary
        let valueToReturn: Int? = tempDic[propertyName] as? Int
        if valueToReturn == nil {
            // Not valid type for conversion
            print("Dictionary - getInt, Returning nil as the value was null.")
        }
        return valueToReturn
    }
    
    
    //
    // Convert the String from JSON Dictionary ([String: Any]? to Int
    //
    // param: String
    // param: [String: Any]?
    // return: Double?
    //
    func getDouble(propertyName: String) -> Double? {
        let tempDic: NSDictionary = self as NSDictionary
        let valueToReturn: Double? = tempDic[propertyName] as? Double
        if valueToReturn == nil {
            // Not valid type for conversion
            print("Dictionary - getDouble, Returning nil as the value was null.")
        }
        return valueToReturn
    }
    
    
    //
    // Convert the String from JSON Dictionary ([String: Any]? to Int
    //
    // param: String
    // param: [String: Any]?
    // return: String?
    //
    func getString(propertyName: String) -> String? {
        let tempDic: NSDictionary = self as NSDictionary
        let valueToReturn: String? = tempDic[propertyName] as? String
        if valueToReturn == nil {
            // Not valid type for conversion
            print("Dictionary - getString, Returning nil as the value was null.")
        }
        return valueToReturn
    }
    
    
    //
    // Convert the String from JSON Dictionary ([String: Any]? to Int
    //
    // param: String
    // param: [String: Any]?
    // return: Any?
    //
    func getAnyObject(propertyName: String) -> Any? {
        let tempDic: NSDictionary = self as NSDictionary
        let valueToReturn: Any? = tempDic[propertyName]
        if valueToReturn == nil {
            // Not valid type for conversion
            print("Dictionary - getAnyObject, Returning nil as the value was null.")
        }
        return valueToReturn
    }
}

