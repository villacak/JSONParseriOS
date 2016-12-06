//
//  TestsMaster.swift
//  JSONParseriOS
//
//  Created by Villaca, Klaus on 12/1/16.
//  Copyright © 2016 Klaus Villaca. All rights reserved.
//

import Foundation
import XCTest

@testable import JSONParseriOS

class TestMaster: XCTestCase {
    var masterArray = [Any]()
    var masterArray2 = [Any]()
    var masterArray3 = [Any]()
    var masterArray4 = [Any]()
    
    var objectsDictionary = [String: AnyObject]()
    
    var firstStructObject: FirstStructForTest?
    var secondStructObjectObject: FirstStructForTest?
    var firstClassObject: FirstObjectForTest?
    var secondClassObject: FirstObjectForTest?
    var firstSwiftClassObject: SecondObjectForTest?
    var secondSwiftClassObject: SecondObjectForTest?
    var thirdSwiftClassObject: ThirdObjectForTest?
    
    override func setUp() {
        super.setUp()
        print("Master - setUp")
        
        //
        // Creating objects from Structs
        //
        firstStructObject = FirstStructForTest(id: 1, name: "FirstName", dateCreation: "today")
        secondStructObjectObject = FirstStructForTest(id: 2, name: "SecondtName", dateCreation: "today")
        
        // If you need transform the object to JSON, then is a must you convert it to Dictionary first
        masterArray.append(firstStructObject?.toDictionary() as! Dictionary<String, AnyObject>)
        masterArray.append(secondStructObjectObject?.toDictionary() as! [String : AnyObject])
        
        
        //
        // Creating objects from Class extending NSObject
        //
        firstClassObject = FirstObjectForTest(codeId: 1, name: "FirstName", value: "FirstValue", dateCreation: "today")
        secondClassObject = FirstObjectForTest(codeId: 1, name: "SecondtName", value: "SecondValue", dateCreation: "today")
        
        // If you need transform the object to JSON, then is a must you convert it to Dictionary first
        masterArray2.append(firstClassObject?.toDictionary() as! [String: AnyObject])
        masterArray2.append(secondClassObject?.toDictionary() as! [String: AnyObject])
        
        
        //
        // Creating objects from pure SWIFT Class
        //
        firstSwiftClassObject = SecondObjectForTest(codeId: 1, name: "FirstName", doubleValue: 10.50, isOk: true, dateCreation: "today")
        secondSwiftClassObject = SecondObjectForTest(codeId: 2, name: "SecondName", doubleValue: 21.0, isOk: true, dateCreation: "today")
        
        // If you need transform the object to JSON, then is a must you convert it to Dictionary first
        masterArray3.append(firstSwiftClassObject?.toDictionary() as! [String: AnyObject])
        masterArray3.append(secondSwiftClassObject?.toDictionary() as! [String: AnyObject])
        
        
        thirdSwiftClassObject = ThirdObjectForTest(codeId: 1, name: "Second Object", secondObj: firstSwiftClassObject!)
        let tempDic = thirdSwiftClassObject?.toDictionary() as! [String: AnyObject]
        masterArray4.append(tempDic)
    }
    
    
    //
    // Clean all variables after each test
    //
    override func tearDown() {
        print("Master - tearDown")
        masterArray.removeAll()
        masterArray2.removeAll()
        masterArray3.removeAll()
        
        objectsDictionary.removeAll()
        
        firstStructObject = nil
        secondStructObjectObject = nil
//        firstClassObject = nil
        secondClassObject = nil
        firstSwiftClassObject = nil
        secondSwiftClassObject = nil
        thirdSwiftClassObject = nil
        
        super.tearDown()
    }
}
