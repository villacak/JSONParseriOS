//
//  FirstObjectForTest.swift
//  JSONParser
//
//  Created by Klaus Villaca on 9/23/16.
//
//

import UIKit

//
//  Class that extends from NSObject
//
class FirstObjectForTest: NSObject, JSONSerializable {
    
    var codeId: NSNumber
    var name: String
    var value: String
    var dateCreation: String

    
    // An init() is necessary, even if it's empty
    override required init() {
        self.codeId = 0
        self.name = ""
        self.value = ""
        self.dateCreation = ""
    }
    
    
    
    init(codeId: Int, name: String, value: String, dateCreation: String) {
        self.codeId = codeId as NSNumber
        self.name = name
        self.value = value
        if (dateCreation == "today") {
            self.dateCreation = HelperUtils.todaysDateFormattedAsMMddYYYY()
        } else {
            do {
                self.dateCreation = try HelperUtils.validateUsersDate(userDateStr: dateCreation)
            } catch {
                // It's necessary to initialize all variables
                self.dateCreation = ""
                print("Wrong date.")
            }
        }
    }
    
    
    // Necessary if you need to populate the object from a JSON,
    // it can also be empty or omited if just using JSONSerialozable features
    func populateFromJSON(dictionary: [String : AnyObject]) -> Self {
        let tempSelf = type(of: self).init()
        
        tempSelf.codeId = JPUtils.getInt(propertyName: "codeId", from: dictionary) as NSNumber!
        tempSelf.name = JPUtils.getString(propertyName: "name", from: dictionary)!
        tempSelf.value = JPUtils.getString(propertyName: "value", from: dictionary)!
        tempSelf.dateCreation = JPUtils.getString(propertyName: "dateCreation", from: dictionary)!
        return self
    }


}
