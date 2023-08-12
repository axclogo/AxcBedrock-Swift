//
//  AnyObjectTest.swift
//  CoreTests
//
//  Created by 赵新 on 2023/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
@testable import AxcBedrock

final class AnyObjectTest: XCTestCase {
    override func tearDownWithError() throws {
        print("=======开始AnyObject单元测试=======")
        testStringFromClass()
        testClassFromString()
    }

    /// 类转字符串
    func testStringFromClass() {
        let caseStr = NSString().axc.stringFromClass
        let caseStr1 = NSString.Axc.StringFromClass
        XCTAssertEqual(caseStr, caseStr1)
    }

    /// 字符串转类
    func testClassFromString() {
        let anyClass = "NSString".axc.classFromString as? NSString.Type
        let caseStr1 = NSString.Axc.StringFromClass
        let caseStr2 = anyClass?.Axc.StringFromClass ?? ""
        XCTAssertEqual(caseStr1, caseStr2)
    }
}
