import XCTest
@testable import AxcBedrockCore

final class AxcLockWrapperTests: XCTestCase {

    // MARK: - Basic functionality

    func testInitialValue() {
        @AxcLockWrapper var value = 42
        XCTAssertEqual(value, 42)
    }

    func testSetAndGet() {
        @AxcLockWrapper var value = 0
        value = 100
        XCTAssertEqual(value, 100)
    }

    func testStringValue() {
        @AxcLockWrapper var value = "hello"
        value = "world"
        XCTAssertEqual(value, "world")
    }

    func testOptionalValue() {
        @AxcLockWrapper var value: Int? = nil
        XCTAssertNil(value)
        value = 42
        XCTAssertEqual(value, 42)
    }

    // MARK: - Thread safety (Bug 9.1 & 9.2 fix verification)

    func testConcurrentReadWrite() {
        @AxcLockWrapper var counter = 0
        let iterations = 1000
        let expectation = XCTestExpectation(description: "Concurrent access")
        let group = DispatchGroup()

        for _ in 0..<iterations {
            group.enter()
            DispatchQueue.global().async {
                counter += 1
                group.leave()
            }
        }

        group.notify(queue: .main) {
            // Due to race conditions in += (read-modify-write),
            // the final value may not be exactly iterations,
            // but it should not crash (which was the original bug)
            XCTAssertTrue(counter > 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testConcurrentReads() {
        @AxcLockWrapper var value = "test_string"
        let expectation = XCTestExpectation(description: "Concurrent reads")
        let group = DispatchGroup()

        for _ in 0..<100 {
            group.enter()
            DispatchQueue.global().async {
                // Should not crash - reads are now locked
                let _ = value
                group.leave()
            }
        }

        group.notify(queue: .main) {
            XCTAssertEqual(value, "test_string")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testConcurrentWritesDontCrash() {
        @AxcLockWrapper var value = 0
        let expectation = XCTestExpectation(description: "Concurrent writes")
        let group = DispatchGroup()

        for i in 0..<100 {
            group.enter()
            DispatchQueue.global().async {
                value = i
                group.leave()
            }
        }

        group.notify(queue: .main) {
            // Value should be one of the written values
            XCTAssertTrue(value >= 0 && value < 100)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    // MARK: - Value types

    func testArrayValue() {
        @AxcLockWrapper var arr = [1, 2, 3]
        arr.append(4)
        XCTAssertEqual(arr, [1, 2, 3, 4])
    }

    func testDictionaryValue() {
        @AxcLockWrapper var dict = ["key": "value"]
        dict["key2"] = "value2"
        XCTAssertEqual(dict.count, 2)
    }

    func testBoolValue() {
        @AxcLockWrapper var flag = false
        flag = true
        XCTAssertTrue(flag)
    }
}
