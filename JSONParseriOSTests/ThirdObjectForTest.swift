//
//  ThirdObjectForTest.swift
//  JSONParseriOS
//
//  Created by Klaus Villaca on 12/1/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation


//
//  Pure SWIFT class
//
class ThirdObjectForTest: JSONSerializable {
    
    var codeId: Int
    var name: String
    var secondObj: SecondObjectForTest
    
    
    // An init() is necessary, even if it's empty
    required init() {
        self.codeId = 0
        self.name = ""
        self.secondObj = SecondObjectForTest()
    }
    
    
    init(codeId: Int, name: String, secondObj: SecondObjectForTest) {
        self.codeId = codeId
        self.name = name
        self.secondObj = secondObj
    }
    
    // Necessary if you need to populate the object from a JSON,
    // it can also be empty or omited if just using JSONSerialozable features
    func populateFromJSON(dictionary: [String: AnyObject]) -> Self {
        let tempSelf = type(of: self).init()
        
        // The line bellow is necessary at moment.
        tempSelf.codeId = dictionary.getInt(propertyName: "codeId")!
        tempSelf.name = dictionary.getString(propertyName: "name")!
        tempSelf.secondObj = dictionary.getAnyObject(propertyName: "secondObj") as! SecondObjectForTest
        return tempSelf
    }
}

