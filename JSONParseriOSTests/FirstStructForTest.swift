//
//  FirstStructForTest.swift
//  JSONParser
//
//  Created by Klaus Villaca on 9/23/16.
//
//

import Foundation

//
//  Struct
//
struct FirstStructForTest: JSONSerializable {
    
    var id: Int
    var name: String
    var dateCreation: String
    
    // An init() is necessary, even if it's empty
    init() {
        self.id = 0
        self.name = ""
        self.dateCreation = ""
    }
    
    
    init(id: Int, name: String, dateCreation: String) {
        self.id = id;
        self.name = name
        if (dateCreation == "today") {
            self.dateCreation = HelperUtils.todaysDateFormattedAsMMddYYYY()
        } else {
            do {
                let tempValue = try HelperUtils.validateUsersDate(userDateStr: dateCreation)
                self.dateCreation = tempValue
            } catch {
                self.dateCreation = ""
                print("Wrong date.")
            }
        }
    }

    
    mutating func populateFromJSON(dictionary: [String : AnyObject]) -> FirstStructForTest {
        self.id = JPUtils.getInt(propertyName: "id", from: dictionary)!
        self.name = JPUtils.getString(propertyName: "name", from: dictionary)!
        self.dateCreation = JPUtils.getString(propertyName: "dateCreation", from: dictionary)!
        return self
    }
}
