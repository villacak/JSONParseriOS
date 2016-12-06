//
//  HelperUtils.swift
//  JSONParseriOS
//
//  Created by Klaus Villaca on 9/23/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation


class HelperUtils {
    
    //
    // Return the date set on the format MM/dd/yyyy
    //
    // return: String
    //
    static func todaysDateFormattedAsMMddYYYY() -> String {
        //        dateFormater.dateFormat = "EEE, dd MMM yyy hh:mm:ss +zzzz"
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let stringFromDate: String = dateFormater.string(from: Date())
        return stringFromDate
    }
    
    
    //
    // Validate user string date
    //
    // return: String
    //
    static func validateUsersDate(userDateStr: String) throws -> String {
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let dateFromString: Date? = dateFormater.date(from: userDateStr)!
        if (dateFromString != nil) {
            return userDateStr
        } else {
            throw Exception.ValidateDateFail
        }
    }

}
