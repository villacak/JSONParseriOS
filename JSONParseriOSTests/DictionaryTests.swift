//
//  DictionaryTests.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 12/1/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//


import Foundation
import XCTest


class DictionaryTests: TestMaster {
    
    
    func testDictionaryTestsTestsSuccess() {
        print("testDictionaryTestsTestsSuccess - Start")

        
        //
        // Check if Dictionary has key
        //
        let dictionaryFromObject: Dictionary<String, AnyObject> = firstStructObject!.toDictionary() as! [String: AnyObject]
        let jsonFromDictionaryBool = dictionaryFromObject.has(key: "name")
        XCTAssertNotNil(jsonFromDictionaryBool)
        XCTAssertTrue(jsonFromDictionaryBool)
        
        
        //
        // From Dictionary to JSON
        //
        // Struct
        let jsonFromDictionary = dictionaryFromObject.jsonString
        XCTAssertNotNil(jsonFromDictionary)
        
        // Class NSObject
        let dictionaryFromObject2 = masterArray2[0] as! [String: AnyObject]
        let jsonFromDictionary2 = dictionaryFromObject2.jsonStringPretty
        XCTAssertNotNil(jsonFromDictionary2)
        
        // SWIFT class
        let dictionaryFromObject3 = masterArray3[0] as! [String: AnyObject]
        let jsonFromDictionary3 = dictionaryFromObject3.toJSONString(prettify: true)
        XCTAssertNotNil(jsonFromDictionary3)
        
        
        //
        // Getting supported types from Dictionary
        //
        let dictionaryFromObject4 = masterArray3[0] as! [String: AnyObject]
        let tempCodeId = dictionaryFromObject4.getInt(propertyName: "codeId")
        XCTAssertTrue(tempCodeId == firstSwiftClassObject?.codeId)
        
        let tempName = dictionaryFromObject4.getString(propertyName: "name")
        XCTAssertTrue(tempName == firstSwiftClassObject?.name)
        
        let tempDoubleValue = dictionaryFromObject4.getDouble(propertyName: "doubleValue")
        XCTAssertTrue(tempDoubleValue == firstSwiftClassObject?.doubleValue)
        
        let tempIsOk = dictionaryFromObject4.getBool(propertyName: "isOk")
        XCTAssertTrue(tempIsOk == firstSwiftClassObject?.isOk)
        
        let tempDateCreation = dictionaryFromObject4.getString(propertyName: "dateCreation")
        XCTAssertTrue(tempDateCreation == firstSwiftClassObject?.dateCreation)
    }
}
