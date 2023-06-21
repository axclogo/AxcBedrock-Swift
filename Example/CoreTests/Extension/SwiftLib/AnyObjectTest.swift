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
        let caseStr = NSString().yp.stringFromClass
        let caseStr1 = NSString.YP.StringFromClass
        XCTAssertEqual(caseStr, caseStr1)
    }

    /// 字符串转类
    func testClassFromString() {
        let anyClass = "NSString".yp.classFromString as? NSString.Type
        let caseStr1 = NSString.YP.StringFromClass
        let caseStr2 = anyClass?.YP.StringFromClass ?? ""
        XCTAssertEqual(caseStr1, caseStr2)
    }
}
