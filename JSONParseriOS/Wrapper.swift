//
//  Wrapper.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 11/29/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation

class Wrapper<T> where T: JSONSerializable {
    var object: T
    
    //
    // init the wrapper with the object
    //
    init(_ object: T) {
        self.object = object
    }
    
    
    //
    // populateFromJSON, to implement JSONSerializable
    //
    // param: [String: AnyObject]
    // return: T that may be any object (class or struct)
    //
    func populateFromJSON(dictionary: [String: AnyObject]) -> T {
        let tempObject = object.populateFromJSON(dictionary: dictionary)
        return tempObject as T
    }
    
}
