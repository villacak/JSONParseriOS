//
//  JSONRepresentable.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 10/3/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation

// JSONRepresentable protocol
public protocol JSONRepresentable {
    var JSONRepresentation: Any { get }
}

// JSONSerializable protocol
public protocol JSONSerializable: JSONRepresentable {
    init()
    mutating func populateFromJSON(dictionary: [String: AnyObject]) -> Self
}

// Serialize a JSON Representation, the object must be a valid JSON Object
extension JSONSerializable {
    var JSONRepresentation: Any {
        var representation = [String: Any]()
        let itself: Self = self
        let tempMirror = Mirror(reflecting: itself)
        
        for item in tempMirror.children {
            let label = item.label
            let value = item.value
            
            switch value {
                case is Dictionary<String, JSONRepresentable>:
                    representation[label!] = (value as! Dictionary<String, JSONRepresentable>).map({$0.value.JSONRepresentation})
                    break
                    
                case is Array<JSONRepresentable>:
                    representation[label!] = (value as! Array<JSONRepresentable>).map({$0.JSONRepresentation})
                    break

                case is JSONRepresentable:
                    representation[label!] = (value as! JSONRepresentable).JSONRepresentation
                    break
                    
                case is Dictionary<String, Any>:
                    representation[label!] = value as! Dictionary<String, Any>
                    
                case is Array<Any>:
                    representation[label!] = value as! Array<Any>
                    
                // Need to improve this to remove the warning.
                case is AnyObject:
                    representation[label!] = value
                    break

                default:
                    // Ignore any unserializable properties
                    break
            }
        }
        
        return representation
    }
}



extension JSONSerializable {
    
    // Convert valid json object (class or struct), serialized, to JSON
    //
    // e.g.: var jsonObject = <yourStructInitialized>.toJSON()
    //
    // return: String?
    //
    func toJSON() -> String? {
        let representation = JSONRepresentation
        var jsonToReturn: String? = nil
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            print("JSONSerializable - toJSON, not valid JSON Object")
            return jsonToReturn
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            jsonToReturn = String(data: data, encoding: .utf8)
        } catch let error as NSError {
            print("JSONSerializable - toJSON, error: \(error)")
            jsonToReturn = nil
        }
        return jsonToReturn
    }
    
    
    // Convert Classes or Structs to Dictionary
    //
    // e.g.: var dictionary = <yourObjectOrStructInitialized>.toDictionary()
    //
    // return: Dictionary<String, Any>?
    //
    func toDictionary() -> Dictionary<String, Any>? {
        var dict: [String: Any] = [String: Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
