//
//  StringTests.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 12/1/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation
import XCTest

class StringTests: TestMaster {
    
    var jsonStringObject: String?
    var jsonStringObject2: String?
    var jsonStringObject3: String?
    
    
    override func setUp() {
        super.setUp()
        print("StringTests - setUp")
        
        jsonStringObject = firstStructObject?.toJSON()
        jsonStringObject2 = firstClassObject?.toJSON()
        jsonStringObject3 = firstSwiftClassObject?.toJSON()
    }
    
    
    override func tearDown() {
        print("StringTests - tearDown")
        
        jsonStringObject = nil
        jsonStringObject2 = nil
        jsonStringObject3 = nil
    }
    
    
    func testStringExtensionTestsSuccess() {
        print("testStringExtensionTestsSuccess - Start")
        
        //
        // JSON String to Dictionary
        //
        // Struct
        let dictionaryObject = jsonStringObject?.toDictionary()
        XCTAssertNotNil(dictionaryObject)
        
        // Class NSObject
        let dictionaryObject2 = jsonStringObject2?.toDictionary()
        XCTAssertNotNil(dictionaryObject2)
        
        // SWIFT class
        let dictionaryObject3 = jsonStringObject3?.toDictionary()
        XCTAssertNotNil(dictionaryObject3)
        
        
        //
        // JSON String to JSON Array
        //
        // Struct
        let jsonArray = jsonStringObject?.fromJSONToArray(typeObjectInTheArray: FirstStructForTest.self) as! Array<FirstStructForTest>
        XCTAssertNotNil(jsonArray)
        
        let firstItem: FirstStructForTest = jsonArray[0]
        XCTAssertTrue(firstItem.id == firstStructObject?.id)
        XCTAssertTrue(firstItem.name == firstStructObject?.name)
        
        // Class NSObject
        let jsonArray2 = jsonStringObject2?.fromJSONToArray(typeObjectInTheArray: FirstObjectForTest.self) as! Array<FirstObjectForTest>
        XCTAssertNotNil(jsonArray2)
        
        let secondItem: FirstObjectForTest = jsonArray2[0]
        XCTAssertTrue(secondItem.codeId == firstClassObject?.codeId)
        XCTAssertTrue(secondItem.name == firstClassObject?.name)
        
        // SWIFT class
        let jsonArray3: Array<SecondObjectForTest> = jsonStringObject3?.fromJSONToArray(typeObjectInTheArray: SecondObjectForTest.self) as! Array<SecondObjectForTest>
        XCTAssertNotNil(jsonArray3)
        
        let thirdItem: SecondObjectForTest = jsonArray3[0]
        XCTAssertTrue(thirdItem.codeId == firstSwiftClassObject?.codeId)
        XCTAssertTrue(thirdItem.name == firstSwiftClassObject?.name)
    }
}
