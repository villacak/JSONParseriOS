//
//  ArrayTests.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 12/5/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation
import XCTest


class ArrayTests: TestMaster {
    
    
    func testArrayTestsTestsSuccess() {
        print("testArrayTestsTestsSuccess - Start")
        
        
        //
        // From Dictionary to JSON
        //
        // Struct
        let tempArray: Array<Dictionary<String, Any>> = masterArray as! Array<Dictionary<String, Any>>
        let stringFromDicArray: String? = tempArray.collectionArrayToJSONString(prettify: true)
        XCTAssertNotNil(stringFromDicArray)
        
        var tempMasterArray = [FirstStructForTest]()
        tempMasterArray.append(firstStructObject!)
        tempMasterArray.append(secondStructObjectObject!)
        let tempArray2 = tempMasterArray.serializableArrayToJSONString(prettify: true)
        XCTAssertNotNil(tempArray2)
        
        // Class NSObject
        let tempArray3: Array<Dictionary<String, Any>> = masterArray2 as! Array<Dictionary<String, Any>>
        let stringFromDicArray2: String? = tempArray3.collectionArrayToJSONString(prettify: true)
        XCTAssertNotNil(stringFromDicArray2)
        
        var tempMasterArray2 = [FirstObjectForTest]()
        tempMasterArray2.append(firstClassObject!)
        tempMasterArray2.append(secondClassObject!)
        let tempArray4 = tempMasterArray2.serializableArrayToJSONString(prettify: true)
        XCTAssertNotNil(tempArray4)


        // SWIFT class
        let tempArray5: Array<Dictionary<String, Any>> = masterArray2 as! Array<Dictionary<String, Any>>
        let stringFromDicArray3: String? = tempArray5.collectionArrayToJSONString(prettify: true)
        XCTAssertNotNil(stringFromDicArray3)
        
        var tempMasterArray3 = [SecondObjectForTest]()
        tempMasterArray3.append(firstSwiftClassObject!)
        tempMasterArray3.append(secondSwiftClassObject!)
        let tempArray6 = tempMasterArray3.serializableArrayToJSONString(prettify: true)
        XCTAssertNotNil(tempArray6)
    }
}
