//
//  JPUtils.swift
//  JSONParser
//
//  Created by Klaus Villaca on 8/27/16.
//
//

import Foundation

class JPUtils {
    
    //
    // Parse Dictionary to Any -> JSON
    //
    // param: [Any]
    // return: String?
    //
    func parseToJSONString(objectToParse: [Any]!) -> String? {
        var jsonObj: String? = nil
        
        if JSONSerialization.isValidJSONObject(objectToParse) {
            do {
                let bytes: Data = try JSONSerialization.data(withJSONObject: objectToParse, options: JSONSerialization.WritingOptions.prettyPrinted)
                jsonObj = NSString(data: bytes, encoding: String.Encoding.utf8.rawValue)! as String
            } catch let errorDicToJSON {
                print(errorDicToJSON)
            }
        }
        return jsonObj
    }
    
    
    //
    // Parse JSONString to NSArray
    //
    // param: String
    // return: NSArray?
    //
    func jsonStringToArray(text: String!) -> NSArray? {
        var valueToReturn: NSArray? = nil
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let tempDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray
                valueToReturn = tempDictionary
            } catch let error as NSError {
                print(error)
            }
        }
        return valueToReturn
    }
    
    
    //
    // Parse JSONString to NSDdictionary
    //
    // param: String
    // return: NSDictionary?
    //
    func jsonStringToDictionary(text: String!) -> NSDictionary? {
        var valueToReturn: NSDictionary? = nil
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let tempDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                valueToReturn = tempDictionary
            } catch let error as NSError {
                print(error)
            }
        }
        return valueToReturn
    }
    
    
    //
    // Parse JSONString to AnyObject
    //
    // param: String
    // return: Any?
    //
    func jsonStringToObject(jsonString: String) -> Any? {
        var objectToReturn: Any? = nil
        if let data = jsonString.data(using: String.Encoding.utf8) {
            do {
                let tempDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                if let jsonResult = tempDictionary as? NSMutableArray {
                    objectToReturn = jsonResult
                } else if let jsonResult = tempDictionary as? NSMutableDictionary {
                    objectToReturn = jsonResult
                } else {
                    return nil
                }
            } catch let error as NSError {
                print(error)
            }
        }
        return objectToReturn
    }
    
    
    //
    // Parse NSArray to Array of objects
    //
    // param: NSArray
    // param: AnyClass
    // return: Array<Any>?
    //
    func dictionaryArraytoObject(nsarray: NSArray, classNameInTheArray: AnyClass) -> Array<Any>? {
        var arrayToReturn: Array<Any>! = nil
        let classNameString: String = NSStringFromClass(classNameInTheArray)
        if let tempAnyObject: NSObject.Type = NSClassFromString(classNameString) as? NSObject.Type {
            arrayToReturn = Array<Any>()
            for item in nsarray {
                let tempObject = tempAnyObject.init()
                for (key, value) in item as! NSDictionary {
                    tempObject.setValue(value, forKey: key as! String)
                }
                arrayToReturn.append(tempObject)
            }
        }
        return arrayToReturn
    }
    
    
    //
    // Parse the dictionary to an object
    //
    // param: Dictionary<String, Any>
    // param: AnyClass
    // return: Any?
    //
    func dictionaryToObject(dictionary: Dictionary<String, Any>, classNameInTheArray: AnyClass) -> Any? {
        var objectToReturn: Any! = nil
        let classNameString: String = NSStringFromClass(classNameInTheArray)
        if let tempAnyObject: NSObject.Type = NSClassFromString(classNameString) as? NSObject.Type {
            objectToReturn = NSObject()
            let tempObject = tempAnyObject.init()
            for (key, value) in dictionary {
                tempObject.setValue(value, forKey: key)
            }
            objectToReturn = tempObject;
        }
        return objectToReturn
    }
    
    
    
    //
    // Convert the String from JSON Dictionary ([String: Any]? to Bool
    //
    // param: String
    // param: [String: Any]?
    // return: Bool?
    //
    static func getBool(propertyName: String, from jsonAsDictionary: [String: Any]?) -> Bool? {
        var valueToReturn: Bool? = nil
        if (jsonAsDictionary != nil) {
            valueToReturn = jsonAsDictionary?[propertyName] as? Bool
            if valueToReturn == nil {
                // Not valid type for conversion
                valueToReturn = nil
                print("Returning nil as the value was null.")
            }
        } else {
            valueToReturn = nil
            print("Returning nil as the value was null.")
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
    static func getInt(propertyName: String, from jsonAsDictionary: [String: Any]?) -> Int? {
        var valueToReturn: Int? = nil
        if (jsonAsDictionary != nil) {
            valueToReturn = jsonAsDictionary?[propertyName] as? Int
            if valueToReturn == nil {
                // Not valid type for conversion
                valueToReturn = nil
                print("Returning nil as the value was null.")
            }
        } else {
            valueToReturn = nil
            print("Returning nil as the value was null.")
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
    static func getDouble(propertyName: String, from jsonAsDictionary: [String: Any]?) -> Double? {
        var valueToReturn: Double? = nil
        if (jsonAsDictionary != nil) {
            valueToReturn = jsonAsDictionary?[propertyName] as? Double
            if valueToReturn == nil {
                // Not valid type for conversion
                valueToReturn = nil
                print("Returning nil as the value was null.")
            }
        } else {
            valueToReturn = nil
            print("Returning nil as the value was null.")
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
    static func getString(propertyName: String, from jsonAsDictionary: [String: Any]?) -> String? {
        var valueToReturn: String? = nil
        if (jsonAsDictionary != nil) {
            valueToReturn = jsonAsDictionary?[propertyName] as? String
            if valueToReturn == nil {
                // Not valid type for conversion
                valueToReturn = nil
                print("Returning nil as the value was null.")
            }
        } else {
            valueToReturn = nil
            print("Returning nil as the value was null.")
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
    static func getAnyObject(propertyName: String, from jsonAsDictionary: [String: Any]?) -> Any? {
        var valueToReturn: Any? = nil
        if (jsonAsDictionary != nil) {
            valueToReturn = jsonAsDictionary?[propertyName]
            if valueToReturn == nil {
                // Not valid type for conversion
                valueToReturn = nil
                print("Returning nil as the value was null.")
            }
        } else {
            valueToReturn = nil
            print("Returning nil as the value was null.")
        }
        return valueToReturn
    }
}
