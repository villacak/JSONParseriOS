//
//  StringExtension.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 11/30/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation

public extension String {
    // Convert Classes or Structs to Dictionary
    //
    // e.g.: var dictionary = <yourJSONString>.toDictionary()
    //
    // return: Dictionary<String, Any>?
    //
    func toDictionary() -> Dictionary<String, Any>? {
        var valueToReturn: NSDictionary?
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let tempDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                valueToReturn = tempDictionary
            } catch let error as NSError {
                print(error)
                valueToReturn = nil
            }
        }
        return valueToReturn as! [String : Any]?
    }
    
    
    //
    // Convert JSON String to an Array populated with objects from that class name passed, the class need to inherit from NSObject
    //
    // e.g.: var dictionary: Array<AnyObject> = <jsonString>.fromJson(classInTheArray: <class>.self)
    //
    // param: AnyClass (e.g. className.self)
    // return: Array<Any>?
    //
    func fromJSONToArray<T:JSONSerializable>(typeObjectInTheArray: T.Type) -> Array<Any>? {
        var tempArrayToReturn: Array<Any>?
        if typeObjectInTheArray is AnyClass && (typeObjectInTheArray as! AnyClass).isSubclass(of: NSObject.self) {
            tempArrayToReturn = fromJSONToNSObject(classInTheArray: typeObjectInTheArray as! AnyClass)
        } else {
            tempArrayToReturn = fromJSONToAnyObject(classInTheArray: typeObjectInTheArray)
        }
        return tempArrayToReturn
    }
    
    
    
    //
    //  fromJSONToAnyObject - Receive T.Type, T: JSONSerializable that's extend NSObject
    //
    //  param: AnyClass  (<className>.self)
    //  return: Array<Any>?
    //
    private func fromJSONToAnyObject<T:JSONSerializable>(classInTheArray: T.Type) -> Array<Any>? {
        var tempArrayToReturn: Array<Any>?
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let tempArrayOfDictionaries = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                tempArrayToReturn = Array<Any>()
                let tempAnyObject = classInTheArray.init()
                let wrapperTemp = Wrapper(tempAnyObject)
                if let jsonResult = tempArrayOfDictionaries as? NSArray {
                    for item in jsonResult {
                        let itemAsDic = item as! NSDictionary
                        let tempObject = wrapperTemp.populateFromJSON(dictionary: itemAsDic as! [String: AnyObject])
                        tempArrayToReturn?.append(tempObject)
                    }
                } else if let jsonResult = tempArrayOfDictionaries as? NSDictionary {
                    let tempObject = wrapperTemp.populateFromJSON(dictionary: jsonResult as! [String: AnyObject])
                    tempArrayToReturn?.append(tempObject)
                } else {
                    tempArrayToReturn = nil
                }
                
            } catch let error as NSError {
                tempArrayToReturn = nil
                print("fromJSONToArray, error: \(error)")
            }
        } else {
            tempArrayToReturn = nil
            print("fromJSONToArray, error: JSON cannot be transformed to UTF-8 bytes")
        }
        return tempArrayToReturn
    }
    
    
    //
    //  fromJSONToNSObject - Receive AnyClass that's extend NSObject
    //  param: AnyClass  (<className>.self)
    //
    //  return: Array<AnyObject>?
    //
    private func fromJSONToNSObject(classInTheArray: AnyClass) -> Array<AnyObject>? {
        var tempArrayToReturn: Array<AnyObject>?
        let classNameString: String = NSStringFromClass(classInTheArray)
        if let tempAnyObject: NSObject.Type = NSClassFromString(classNameString) as? NSObject.Type {
            if let data = self.data(using: String.Encoding.utf8) {
                do {
                    let tempArrayOfDictionaries = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    tempArrayToReturn = Array<AnyObject>()
                    
                    if let jsonResult = tempArrayOfDictionaries as? NSArray {
                        for item in jsonResult {
                            let itemAsDic = item as! NSDictionary
                            let tempObject = parseDictionaryToObject(dictionary: itemAsDic, tempObjectType: tempAnyObject)
                            tempArrayToReturn?.append(tempObject)
                        }
                    } else if let jsonResult = tempArrayOfDictionaries as? NSDictionary {
                        let tempObject = parseDictionaryToObject(dictionary: jsonResult, tempObjectType: tempAnyObject)
                        tempArrayToReturn?.append(tempObject)
                    } else {
                        tempArrayToReturn = nil
                    }
                    
                } catch let error as NSError {
                    tempArrayToReturn = nil
                    print("fromJSONToArray, error: \(error)")
                }
            } else {
                tempArrayToReturn = nil
                print("fromJSONToArray, error: JSON cannot be transformed to UTF-8 bytes")
            }
        } else {
            tempArrayToReturn = nil
            print("fromJSONToArray, error: class isn't a NSObject subclass")
        }
        return tempArrayToReturn
    }
    
    
    
    //
    // Parse from dictionary to NSObject
    //
    // param: NSDictionary
    // param: NSObject.Type
    // return NSObject
    //
    private func parseDictionaryToObject(dictionary: NSDictionary, tempObjectType: NSObject.Type) -> NSObject {
        let tempObject = tempObjectType.init()
        for (key, value) in dictionary {
            let keyString: String = key as! String
            if (tempObject.responds(to: Selector(keyString))) {
                tempObject.setValue(value, forKey: keyString)
            }
        }
        return tempObject
    }
}

