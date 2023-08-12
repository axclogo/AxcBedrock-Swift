//
//  StringTest.swift
//  CoreTests
//
//  Created by 赵新 on 2023/8/12.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
@testable import AxcBedrock

final class StringTest: XCTestCase {
    override func tearDownWithError() throws {
        print("=======开始StringTest单元测试=======")
        test_isJSONString()
        testJSONSerialization()
    }

    func test_isJSONString() {
        // 测试空字符串
        let result = ""
            .axc.isJSONString(encoding: .utf8)
        XCTAssertFalse(result, "Empty string should not be considered as a JSON string")

        // 测试非 JSON 格式的字符串
        let result2 = "Hello, world!"
            .axc.isJSONString(encoding: .utf8)
        XCTAssertFalse(result2, "Non-JSON string should not be considered as a JSON string")

        // 测试有效的 JSON 字符串
        let result3 = "{\"name\":\"John\", \"age\":30}"
            .axc.isJSONString(encoding: .utf8)
        XCTAssertTrue(result3, "Valid JSON string should be recognized as a JSON string")

        // 测试包含无效字符的字符串
        let result4 = "{\"name\":\"John\", \"age\":30, \"address\": \"New\nYork\"}"
            .axc.isJSONString(encoding: .utf8)
        XCTAssertFalse(result4, "String with invalid characters should not be considered as a JSON string")

        // 测试使用不同的字符编码
        let result5 = "{\"name\":\"John\", \"age\":30}"
            .axc.isJSONString(encoding: .utf16)
        XCTAssertTrue(result5, "JSON string should be recognized as a JSON string regardless of the encoding")
    }

    func testJSONSerialization() {
        print("JSONSerialization正反序列化测试")
        print("普通字符串转换")
        let string = "start=123456789=end"
        let serializationData = string.axc.jsonSerializationData
        print(serializationData)
        let serializationObj = serializationData?.axc.jsonSerializationObj
        print(serializationObj)
        let serializationString = serializationData?.axc.string(encoding: .utf8)
        print(serializationString)

        print("JSON字符串转换")
        let jsonString = "{\"name\":\"John\",\"age\":25,\"city\":\"New York\"}"
        let serializationJsonData = jsonString.axc.jsonSerializationData
        print(serializationJsonData)
        let serializationJsonObj = serializationJsonData?.axc.jsonSerializationObj
        print(serializationJsonObj)
    }
}
