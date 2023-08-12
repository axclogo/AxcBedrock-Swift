//
//  ArrayTest.swift
//  CoreTests
//
//  Created by 赵洋 on 2023/2/25.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
@testable import AxcBedrock

final class ArrayTest: XCTestCase {
    override func tearDownWithError() throws {
        print("=======开始Array单元测试=======")
        testRandom()
        testAppend()
        testInsert()
        testRemoveAtIndex()
        testRemoveLast()
    }

    // MARK: - 以下测试用例由OpenAI生成

    /// 随机
    func testRandom() {
        let list = [1, 2, 3, 4]
        let listRandom = list.axc.random
        XCTAssertNotNil(listRandom)
        XCTAssertTrue(list.contains(listRandom!))
    }

    func testAppend() {
        let base = [1, 2, 3]
        let newElements = [4, 5]
        let result = base.axc.append(newElements)
        XCTAssertEqual(result, [1, 2, 3, 4, 5])
    }

    func testInsert() {
        // 测试索引正常插入
        let arr = ["a", "b", "c"]
        let new = arr.axc.insert("d", at: 2)
        XCTAssertEqual(new, ["a", "b", "d", "c"])

        // 测试索引小于0
        let arr2 = ["a", "b", "c"]
        let new2 = arr2.axc.insert("d", at: -1)
        XCTAssertEqual(new2, ["d", "a", "b", "c"])

        // 测试索引越界
        let arr3 = ["a", "b", "c"]
        let new3 = arr3.axc.insert("d", at: 5)
        XCTAssertEqual(new3, ["a", "b", "c", "d"])
    }

    func testRemoveAtIndex() {
        let array = ["a", "b", "c"]
        XCTAssertEqual(array.axc.remove(at: 0), ["b", "c"])
        XCTAssertEqual(array.axc.remove(at: 3), ["a", "b", "c"])
    }

    func testRemoveLast() {
        var array = [1, 2, 3, 4]
        XCTAssertEqual(array.axc.removeLast { $0 > 0 }, [1, 2, 3])
        XCTAssertEqual(array.axc.removeLast { $0 > 2 }, [1, 2])
        XCTAssertEqual(array.axc.removeLast { $0 > 3 }, [1, 2])
    }
}
