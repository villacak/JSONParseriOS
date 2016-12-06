//
//  SecondObjectForTest.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 11/1/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation

//
//  Pure SWIFT class
//
class SecondObjectForTest: JSONSerializable {
    
    var codeId: Int
    var name: String
    var doubleValue: Double
    var isOk: Bool
    var dateCreation: String
    
    
    // An init() is necessary, even if it's empty
    required init() {
        self.codeId = 0
        self.name = ""
        self.doubleValue = 0.00
        self.isOk = false
        self.dateCreation = ""
    }
    
    
    init(codeId: Int, name: String, doubleValue: Double, isOk: Bool, dateCreation: String) {
        self.codeId = codeId
        self.name = name
        self.doubleValue = doubleValue
        self.isOk = isOk
        if (dateCreation == "today") {
            self.dateCreation = HelperUtils.todaysDateFormattedAsMMddYYYY()
        } else {
            do {
                self.dateCreation = try HelperUtils.validateUsersDate(userDateStr: dateCreation)
            } catch {
                self.dateCreation = ""
                print("Wrong date.")
            }
        }
    }
    
    // Necessary if you need to populate the object from a JSON,
    // it can also be empty or omited if just using JSONSerialozable features
    func populateFromJSON(dictionary: [String: AnyObject]) -> Self {
        let tempSelf = type(of: self).init()
        
        // The line bellow is necessary at moment.
        tempSelf.codeId = dictionary.getInt(propertyName: "codeId")!
        tempSelf.name = dictionary.getString(propertyName: "name")!
        tempSelf.doubleValue = dictionary.getDouble(propertyName: "doubleValue")!
        tempSelf.isOk = dictionary.getBool(propertyName: "isOk")!
        tempSelf.dateCreation = dictionary.getString(propertyName: "dateCreation")!
        return tempSelf
    }
}

