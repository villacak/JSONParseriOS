# JSONParseriOS


Simple JSON parser for iOS, that I have developed to learn more about SWIFT and Generics.
This simple parser allow you to parse objects from class(es) and struct(s). It also has an object mapper to get from
JSON string to the object with data.

There is a read me within the JSONParseriOSTests.
Let's go for some code samples:

Example for struct and class:
```swift

import Foundation

/* struct */
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
```

```swift
import Foundation

/* Pure SWIFT class */
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
```


```swift
import Foundation

/* Pure SWIFT class */
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
```

Example of how to use from an object that may be a struct or a class:
```swift
let firstStructObject = FirstStructForTest(id: 1, name: "FirstName", dateCreation: "today")

// toJSON
let jsonStringObject: String? = firstStructObject?.toJSON()

// toDictionary
let objectAsDictionary: Dictionary<String, Any> = firstStructObject!.toDictionary()!
```

From Array to JSON. The Array may contain objects like those examples above or an Array of Dictionaries
```swift
let secondClassObject = FirstObjectForTest(codeId: 1, name: "SecondtName", value: "SecondValue", dateCreation: "today")

var masterArray = [Any]() // Any can be replaced by Dictionary<String, Any>

// If you need transform the object to JSON, then is a must you convert it to Dictionary first
masterArray2.append(firstClassObject?.toDictionary() as! [String: AnyObject])
masterArray2.append(secondClassObject?.toDictionary() as! [String: AnyObject])

// if instead Any you have used Dictionary you don't need the line bellow
let tempArray: Array<Dictionary<String, Any>> = masterArray as! Array<Dictionary<String, Any>>
let stringFromDicArray: String? = tempArray.collectionArrayToJSONString(prettify: true)

var tempMasterArray = [FirstStructForTest]()
tempMasterArray.append(firstStructObject!)
tempMasterArray.append(secondStructObjectObject!)
let tempArray2 = tempMasterArray.serializableArrayToJSONString(prettify: true)
```

Converting from Dictionary to JSON
```swift
let dictionaryFromObject: Dictionary<String, AnyObject> = firstStructObject!.toDictionary() as! [String: AnyObject]
let jsonFromDictionary = dictionaryFromObject.jsonString

// or
let jsonFromDictionary = dictionaryFromObject.jsonStringPretty

// or
let jsonFromDictionary = dictionaryFromObject.toJSONString(prettify: true)
```

And for last, parse a JSON String to an Array or Dictionary of objects
```swift
let jsonStringObject: String = firstStructObject?.toJSON()

let dictionaryObject = jsonStringObject?.toDictionary()

let arrayObject = jsonStringObject?.fromJSONToArray(typeObjectInTheArray: FirstStructForTest.self) as! Array<FirstStructForTest>
```

Please take a look on those tests that will give you a better idea on how to use it.
I know that for maximum performance the best thing is to have the especific code for each object that need to be parsed from/to,
however this consume time and it's harder to maintain. 
I don't really know so far if it's very performatic as the main intent was to learn more about SWIFT.
I am planning in make some performance tests and compare with other JSON libs available on GitHub, just for curiosity, once 
those test be finished I will post the results and the code.
Please feel free to **copy**, **fork** and if you want to improve it, feel free to send me an email that I will add you as a colaborator.
I hope it helps. 
