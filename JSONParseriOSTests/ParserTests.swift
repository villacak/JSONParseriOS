//
//  ParserTests.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 12/1/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation
import XCTest


class ParserTests: TestMaster {
    
    func testParserClassTestsSuccess() {
        print("testParserClassTestsSuccess - Start")
        
        //
        // Class and struct to JSON
        //
        // Struct
        let jsonStringObject: String? = firstStructObject?.toJSON()
        XCTAssertNotNil(jsonStringObject)
        
        // Class NSObject
        let jsonStringObject2: String? = firstClassObject?.toJSON()
        XCTAssertNotNil(jsonStringObject2)
        
        // SWIFT class
        let jsonStringObject3: String? = firstSwiftClassObject?.toJSON()
        XCTAssertNotNil(jsonStringObject3)
        
        // Test object containing other object
        let jsonStringObject4: String? = thirdSwiftClassObject?.toJSON();
        XCTAssertNotNil(jsonStringObject4)
        
        
        //
        // Class and struct to Dictionary
        //
        // Struct
        let objectAsDictionary: Dictionary<String, Any> = firstStructObject!.toDictionary()!
        XCTAssertNotNil(objectAsDictionary)
        
        // Class NSObject
        let objectAsDictionary2: Dictionary<String, Any> = firstClassObject!.toDictionary()!
        XCTAssertNotNil(objectAsDictionary2)
        
        // SWIFT class
        let objectAsDictionary3: Dictionary<String, Any> = firstSwiftClassObject!.toDictionary()!
        XCTAssertNotNil(objectAsDictionary3)
    }
}
