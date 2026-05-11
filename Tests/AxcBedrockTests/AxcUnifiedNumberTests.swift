import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcUnifiedNumberTests: XCTestCase {

    // MARK: - Protocol conformance

    func testIntConformsToUnifiedNumber() {
        let value: AxcUnifiedNumber = 42
        XCTAssertNotNil(value)
    }

    func testDoubleConformsToUnifiedNumber() {
        let value: AxcUnifiedNumber = 3.14
        XCTAssertNotNil(value)
    }

    func testBoolConformsToUnifiedNumber() {
        let value: AxcUnifiedNumber = true
        XCTAssertNotNil(value)
    }

    func testStringConformsToUnifiedNumber() {
        let value: AxcUnifiedNumber = "123"
        XCTAssertNotNil(value)
    }

    // MARK: - Int conversions

    func testIntToInt() {
        XCTAssertEqual(Int.Axc.Create(42), 42)
    }

    func testInt8ToInt() {
        XCTAssertEqual(Int.Axc.Create(Int8(100)), 100)
    }

    func testInt16ToInt() {
        XCTAssertEqual(Int.Axc.Create(Int16(1000)), 1000)
    }

    func testInt32ToInt() {
        XCTAssertEqual(Int.Axc.Create(Int32(100000)), 100000)
    }

    func testInt64ToInt() {
        XCTAssertEqual(Int.Axc.Create(Int64(999999)), 999999)
    }

    func testUIntToInt() {
        XCTAssertEqual(Int.Axc.Create(UInt(50)), 50)
    }

    func testUInt8ToInt() {
        XCTAssertEqual(Int.Axc.Create(UInt8(255)), 255)
    }

    func testUInt16ToInt() {
        XCTAssertEqual(Int.Axc.Create(UInt16(65535)), 65535)
    }

    func testUInt32ToInt() {
        XCTAssertEqual(Int.Axc.Create(UInt32(100000)), 100000)
    }

    func testFloatToInt() {
        XCTAssertEqual(Int.Axc.Create(Float(3.7)), 3)
    }

    func testDoubleToInt() {
        XCTAssertEqual(Int.Axc.Create(Double(9.99)), 9)
    }

    func testCGFloatToInt() {
        XCTAssertEqual(Int.Axc.Create(CGFloat(5.5)), 5)
    }

    func testBoolToInt() {
        XCTAssertEqual(Int.Axc.Create(true), 1)
        XCTAssertEqual(Int.Axc.Create(false), 0)
    }

    func testStringToInt() {
        XCTAssertEqual(Int.Axc.Create("42"), 42)
        XCTAssertEqual(Int.Axc.Create("invalid"), 0)
    }

    func testNSNumberToInt() {
        XCTAssertEqual(Int.Axc.Create(NSNumber(value: 77)), 77)
    }

    func testNilToInt() {
        XCTAssertEqual(Int.Axc.Create(nil), 0)
        XCTAssertNil(Int.Axc.CreateOptional(nil))
    }

    // MARK: - Narrow type overflow protection

    func testInt8_overflowFromLargeInt() {
        let result = Int8.Axc.Create(1000)
        XCTAssertEqual(result, Int8.max)
    }

    func testInt8_underflowFromNegativeInt() {
        let result = Int8.Axc.Create(-1000)
        XCTAssertEqual(result, Int8.min)
    }

    func testInt16_overflowFromLargeInt() {
        let result = Int16.Axc.Create(100000)
        XCTAssertEqual(result, Int16.max)
    }

    func testInt16_underflowFromNegativeInt() {
        let result = Int16.Axc.Create(-100000)
        XCTAssertEqual(result, Int16.min)
    }

    func testInt32_overflowFromLargeInt64() {
        let result = Int32.Axc.Create(Int64(Int32.max) + 100)
        XCTAssertEqual(result, Int32.max)
    }

    func testInt64_overflowFromUInt64Max() {
        let result = Int64.Axc.Create(UInt64.max)
        XCTAssertEqual(result, Int64.max)
    }

    // MARK: - Edge cases

    func testInt_fromEmptyString() {
        XCTAssertEqual(Int.Axc.Create(""), 0)
    }

    func testInt_fromWhitespaceString() {
        XCTAssertEqual(Int.Axc.Create(" "), 0)
    }

    func testInt8_fromZero() {
        XCTAssertEqual(Int8.Axc.Create(0), 0)
    }

    func testInt8_fromBoundaryValues() {
        XCTAssertEqual(Int8.Axc.Create(127), 127)
        XCTAssertEqual(Int8.Axc.Create(-128), -128)
    }

    func testInt16_fromBoundaryValues() {
        XCTAssertEqual(Int16.Axc.Create(32767), Int16.max)
        XCTAssertEqual(Int16.Axc.Create(-32768), Int16.min)
    }
}
