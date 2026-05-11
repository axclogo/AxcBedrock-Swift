import XCTest
@testable import AxcBedrockCore

final class AxcBoolExTests: XCTestCase {

    // MARK: - Int conversion

    func testBoolToInt_true() {
        XCTAssertEqual(true.axc.int, 1)
    }

    func testBoolToInt_false() {
        XCTAssertEqual(false.axc.int, 0)
    }

    // MARK: - String conversion

    func testBoolToString_true() {
        let str = String.Axc.Create(true)
        XCTAssertEqual(str, "true")
    }

    func testBoolToString_false() {
        let str = String.Axc.Create(false)
        XCTAssertEqual(str, "false")
    }

    // MARK: - Number conversion

    func testBoolToNumber() {
        XCTAssertEqual(Int.Axc.Create(true), 1)
        XCTAssertEqual(Int.Axc.Create(false), 0)
    }

    func testBoolToInt8() {
        XCTAssertEqual(Int8.Axc.Create(true), 1)
        XCTAssertEqual(Int8.Axc.Create(false), 0)
    }

    func testBoolToInt16() {
        XCTAssertEqual(Int16.Axc.Create(true), 1)
        XCTAssertEqual(Int16.Axc.Create(false), 0)
    }

    func testBoolToInt32() {
        XCTAssertEqual(Int32.Axc.Create(true), 1)
        XCTAssertEqual(Int32.Axc.Create(false), 0)
    }

    func testBoolToInt64() {
        XCTAssertEqual(Int64.Axc.Create(true), 1)
        XCTAssertEqual(Int64.Axc.Create(false), 0)
    }
}
