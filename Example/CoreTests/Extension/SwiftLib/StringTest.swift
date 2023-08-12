//
//  StringTest.swift
//  CoreTests
//
//  Created by 赵新 on 2023/8/12.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import AxcBedrock

final class StringTest: XCTestCase {
    override func tearDownWithError() throws {
        print("=======开始StringTest单元测试=======")
        test_isJSONString()
        testJSONSerialization()
        testCodable()
    }

    func test_isJSONString() {
        // 测试空字符串
        let result = ""
            .axc.isJSONString(encoding: .utf8)
        XCTAssertFalse(result)

        // 测试非 JSON 格式的字符串
        let result2 = "Hello, world!"
            .axc.isJSONString(encoding: .utf8)
        XCTAssertFalse(result2)

        // 测试有效的 JSON 字符串
        let result3 = "{\"name\":\"John\", \"age\":30}"
            .axc.isJSONString(encoding: .utf8)
        XCTAssertTrue(result3)

        // 测试包含无效字符的字符串
        let result4 = "{\"name\":\"John\", \"age\":30, \"address\": \"New\nYork\"}"
            .axc.isJSONString(encoding: .utf8)
        XCTAssertFalse(result4)

        // 测试使用不同的字符编码
        let result5 = "{\"name\":\"John\", \"age\":30}"
            .axc.isJSONString(encoding: .utf16)
        XCTAssertTrue(result5)
    }

    func testJSONSerialization() {
        // to data测试空字典转换Data
        let emptyMap: [String: Any] = [:]
        let data = emptyMap.axc.jsonSerializationData
        XCTAssertNotNil(data)
        // to obj测试反转
        if let obj = testJsonSerializationObj(data: data) as? [String: Any] {
            XCTAssertTrue(obj.isEmpty)
        } else {
            XCTFail("Unable to transform an object to [String: Any] type")
        }

        // to data测试有效字典转换Data
        let effectiveMap: [String: Any] = ["name": "John", "age": 30]
        let data2 = effectiveMap.axc.jsonSerializationData
        XCTAssertNotNil(data2)
        // to obj测试反转
        if let obj2 = testJsonSerializationObj(data: data2) as? [String: Any] {
            XCTAssertEqual(obj2["name"] as? String, effectiveMap["name"] as? String)
            XCTAssertEqual(obj2["age"] as? Int, effectiveMap["age"] as? Int)
        } else {
            XCTFail("Unable to transform an object to [String: Any] type")
        }

        // to data测试无效字典转换Data
        let invalidMap: [String: Any] = ["name": "John", "age": 30, "address": ()]
        let data3 = invalidMap.axc.jsonSerializationData
        XCTAssertNil(data3) // it's Empty, no need for a reverse test

        // to data测试字符串Data转换Data
        let string4 = "Custom Data"
        let customData = string4.axc.data
        let data4 = customData?.axc.jsonSerializationData
        XCTAssertEqual(data4, customData)
        // to obj测试反转
        let obj4 = testJsonSerializationObj(data: data4) as? String
        XCTAssertNil(obj4) // it's Empty, because isn't json string

        // to data测试写入类型转换Data
        let writingOptions: JSONSerialization.WritingOptions = [.prettyPrinted, .sortedKeys]
        let data5 = effectiveMap.axc.jsonSerializationData(writingOptions: writingOptions)
        XCTAssertNotNil(data5)
        // to obj测试反转
        if let obj5 = testJsonSerializationObj(data: data5) as? [String: Any] {
            XCTAssertEqual(obj5["name"] as? String, effectiveMap["name"] as? String)
            XCTAssertEqual(obj5["age"] as? Int, effectiveMap["age"] as? Int)
        } else {
            XCTFail("Unable to transform an object to [String: Any] type")
        }
        
        // 转字符串
        let jsonSerializationString = emptyMap.axc.jsonSerializationString
        XCTAssertNotNil(jsonSerializationString)
        
        let jsonSerializationString2 = effectiveMap.axc.jsonSerializationString
        XCTAssertNotNil(jsonSerializationString2)
        
        func testJsonSerializationObj(data: Data?) -> Any? {
            guard let data else { return nil }
            let jsonObj = data.axc.jsonSerializationObj
            return jsonObj
        }
    }

    func testCodable() {
        class TestClass: NSObject, Codable {
            var name: String
            var age: Int
            init(name: String, age: Int) {
                self.name = name
                self.age = age
            }
        }
        // json对象转模型
        let effectiveMap: [String: Any] = ["name": "John", "age": 30]
        if let _class = TestClass.Axc.Create(fromJsonObject: effectiveMap) {
            XCTAssertEqual(_class.name, effectiveMap["name"] as? String)
            XCTAssertEqual(_class.age, effectiveMap["age"] as? Int)
        }
        // jsonData转模型
        if let _class = TestClass.Axc.Create(fromJsonData: effectiveMap.axc.jsonSerializationData) {
            XCTAssertEqual(_class.name, effectiveMap["name"] as? String)
            XCTAssertEqual(_class.age, effectiveMap["age"] as? Int)
            // 模型转Data
            let jsonEncodeData = _class.axc.jsonEncodeData
            if let _class2 = TestClass.Axc.Create(fromJsonData: jsonEncodeData) {
                XCTAssertEqual(_class.name, _class2.name)
                XCTAssertEqual(_class.age, _class2.age)
            }
            // 转字符串
            let jsonEncodeString = _class.axc.jsonEncodeString
            XCTAssertNotNil(jsonEncodeString)
        }
    }
}
