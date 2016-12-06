//
//  ArrayExtension.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 12/5/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation


public extension Array where Element: Collection {
    //
    // Convert Array of Dictionary to JSON
    //
    // return: String?
    //
    func collectionArrayToJSONString(prettify: Bool) -> String? {
        let option: JSONSerialization.WritingOptions = (prettify == true ? JSONSerialization.WritingOptions.prettyPrinted : [])
        var jsonObjTemp: String? = nil
        guard JSONSerialization.isValidJSONObject(self) else {
            print("Array - fromArrayOfDictionariesToJSON, not valid JSON Object")
            return jsonObjTemp
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: option)
            jsonObjTemp = String(data: jsonData, encoding: .utf8)
        } catch let error as NSError {
            print("Array - fromArrayOfDictionariesToJSON, error: \(error)")
            jsonObjTemp = nil
        }
        
        return jsonObjTemp
        
    }
}



public extension Array {
    //
    // Convert Array of objects to JSON
    //
    // return: String?
    //
    func serializableArrayToJSONString(prettify: Bool) -> String? {
        var jsonObjTemp: String? = nil
        
        var tempNewArray = [Dictionary<String, Any>]()
        for item in self {
            if let tempItem = toDictionary(arrayElement: item) {
                tempNewArray.append(tempItem)
            }
        }
        
        if tempNewArray.count > 0 {
            jsonObjTemp = tempNewArray.collectionArrayToJSONString(prettify: prettify)
        }
        return jsonObjTemp
        
    }
    
    // Convert Classes or Structs to Dictionary
    //
    // e.g.: var dictionary = <yourObjectOrStructInitialized>.toDictionary()
    //
    // return: Dictionary<String, Any>?
    //
    func toDictionary(arrayElement: Element) -> Dictionary<String, Any>? {
        var dict: [String: Any] = [String: Any]()
        let otherSelf = Mirror(reflecting: arrayElement)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
    
}
