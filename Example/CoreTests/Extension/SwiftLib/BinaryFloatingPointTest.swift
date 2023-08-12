//
//  BinaryFloatingPointTest.swift
//  CoreTests
//
//  Created by 赵洋 on 2023/2/25.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
@testable import AxcBedrock

final class BinaryFloatingPointTest: XCTestCase {
    override func tearDownWithError() throws {
        print("=======开始BidirectionalCollection单元测试=======")
        testRounded()
    }

    func testRounded() {
        let num = 3.1415927
        XCTAssertEqual(num.axc.rounded(numPlaces: 3, rule: .up), 3.142)
        XCTAssertEqual(num.axc.rounded(numPlaces: 3, rule: .down), 3.141)
        XCTAssertEqual(num.axc.rounded(numPlaces: 2, rule: .awayFromZero), 3.15)
        XCTAssertEqual(num.axc.rounded(numPlaces: 4, rule: .towardZero), 3.1415)
        XCTAssertEqual(num.axc.rounded(numPlaces: -1, rule: .toNearestOrEven), 3)
    }
}
