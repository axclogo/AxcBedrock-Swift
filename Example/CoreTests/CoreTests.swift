//
//  CoreTests.swift
//  CoreTests
//
//  Created by 赵新 on 2023/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
import AxcBedrock

final class CoreTests: XCTestCase {
    override func setUpWithError() throws {
        // 把设置代码放在这里。在调用类中的每个测试方法之前调用此方法。
        print(AxcLogoBanner.orge.banner)
    }

    override func tearDownWithError() throws {
        // 在这里放置拆卸代码。在类中的每个测试方法调用之后调用此方法。
    }

    func testPerformanceExample() throws {
        // 这是一个性能测试用例
        measure {
            // 把你想测量时间的代码放在这里
        }
    }
    
    func testAxcBedrock() throws {
        print("+++++++++++++👇🏻👇🏻👇🏻开始AxcBedrock单元测试👇🏻👇🏻👇🏻+++++++++++++")
        AnyObjectTest().invokeTest()
        ArrayTest().invokeTest()
        BinaryFloatingPointTest().invokeTest()
    }
}


