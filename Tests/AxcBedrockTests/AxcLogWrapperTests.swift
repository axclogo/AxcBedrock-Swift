import XCTest
@testable import AxcBedrockCore

final class AxcLogWrapperTests: XCTestCase {

    func testInitialValue() {
        @AxcLogWrapper var value = "hello"
        XCTAssertEqual(value, "hello")
    }

    func testSetAndGet() {
        @AxcLogWrapper var value = 0
        value = 42
        XCTAssertEqual(value, 42)
    }

    func testBoolValue() {
        @AxcLogWrapper var flag = false
        flag = true
        XCTAssertTrue(flag)
    }

    func testArrayValue() {
        @AxcLogWrapper var arr = [1, 2, 3]
        arr.append(4)
        XCTAssertEqual(arr, [1, 2, 3, 4])
    }

    func testOptionalValue() {
        @AxcLogWrapper var value: String? = nil
        XCTAssertNil(value)
        value = "test"
        XCTAssertEqual(value, "test")
    }
}
