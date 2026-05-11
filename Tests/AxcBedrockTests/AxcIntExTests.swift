import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcIntExTests: XCTestCase {

    // MARK: - Int Create

    func testIntCreate_fromInt() {
        XCTAssertEqual(Int.Axc.Create(42), 42)
    }

    func testIntCreate_fromInt8() {
        XCTAssertEqual(Int.Axc.Create(Int8(127)), 127)
    }

    func testIntCreate_fromDouble() {
        XCTAssertEqual(Int.Axc.Create(3.14), 3)
    }

    func testIntCreate_fromBool() {
        XCTAssertEqual(Int.Axc.Create(true), 1)
        XCTAssertEqual(Int.Axc.Create(false), 0)
    }

    func testIntCreate_fromString() {
        XCTAssertEqual(Int.Axc.Create("123"), 123)
        XCTAssertEqual(Int.Axc.Create("abc"), 0)
    }

    func testIntCreate_fromNil() {
        XCTAssertEqual(Int.Axc.Create(nil), 0)
    }

    func testIntCreateOptional_fromNil() {
        XCTAssertNil(Int.Axc.CreateOptional(nil))
    }

    func testIntCreate_fromNSNumber() {
        XCTAssertEqual(Int.Axc.Create(NSNumber(value: 99)), 99)
    }

    func testIntCreate_fromCGFloat() {
        XCTAssertEqual(Int.Axc.Create(CGFloat(7.8)), 7)
    }

    func testIntCreate_fromFloat() {
        XCTAssertEqual(Int.Axc.Create(Float(3.9)), 3)
    }

    // MARK: - Int8 Create (Bug 9.6 fix verification)

    func testInt8Create_overflow() {
        // Int(1000) should clamp to Int8.max (127), not crash
        let result = Int8.Axc.Create(1000)
        XCTAssertEqual(result, 127)
    }

    func testInt8Create_underflow() {
        // Int(-200) should clamp to Int8.min (-128)
        let result = Int8.Axc.Create(-200)
        XCTAssertEqual(result, -128)
    }

    func testInt8Create_withinRange() {
        XCTAssertEqual(Int8.Axc.Create(50), 50)
        XCTAssertEqual(Int8.Axc.Create(-50), -50)
    }

    func testInt8Create_fromBool() {
        XCTAssertEqual(Int8.Axc.Create(true), 1)
        XCTAssertEqual(Int8.Axc.Create(false), 0)
    }

    func testInt8Create_fromDouble() {
        XCTAssertEqual(Int8.Axc.Create(3.7), 3)
    }

    func testInt8Create_fromLargeUInt() {
        let result = Int8.Axc.Create(UInt(300))
        XCTAssertEqual(result, 127) // clamped
    }

    func testInt8Create_fromNil() {
        XCTAssertEqual(Int8.Axc.Create(nil), 0)
    }

    func testInt8CreateOptional_fromNil() {
        XCTAssertNil(Int8.Axc.CreateOptional(nil))
    }

    // MARK: - Int16 Create

    func testInt16Create_overflow() {
        let result = Int16.Axc.Create(100000)
        XCTAssertEqual(result, Int16.max)
    }

    func testInt16Create_underflow() {
        let result = Int16.Axc.Create(-100000)
        XCTAssertEqual(result, Int16.min)
    }

    func testInt16Create_withinRange() {
        XCTAssertEqual(Int16.Axc.Create(1000), 1000)
    }

    func testInt16Create_fromInt8() {
        XCTAssertEqual(Int16.Axc.Create(Int8(100)), 100)
    }

    func testInt16Create_fromBool() {
        XCTAssertEqual(Int16.Axc.Create(true), 1)
    }

    func testInt16Create_fromString() {
        XCTAssertEqual(Int16.Axc.Create("500"), 500)
    }

    // MARK: - Int32 Create

    func testInt32Create_overflow() {
        let result = Int32.Axc.Create(Int64(Int32.max) + 1)
        XCTAssertEqual(result, Int32.max)
    }

    func testInt32Create_withinRange() {
        XCTAssertEqual(Int32.Axc.Create(12345), 12345)
    }

    func testInt32Create_fromDouble() {
        XCTAssertEqual(Int32.Axc.Create(99.9), 99)
    }

    func testInt32Create_fromNil() {
        XCTAssertEqual(Int32.Axc.Create(nil), 0)
    }

    // MARK: - Int64 Create

    func testInt64Create_fromInt() {
        XCTAssertEqual(Int64.Axc.Create(999999), 999999)
    }

    func testInt64Create_fromUInt64_overflow() {
        let result = Int64.Axc.Create(UInt64.max)
        XCTAssertEqual(result, Int64.max) // clamped
    }

    func testInt64Create_fromBool() {
        XCTAssertEqual(Int64.Axc.Create(true), 1)
    }

    func testInt64Create_fromString() {
        XCTAssertEqual(Int64.Axc.Create("123456789"), 123456789)
    }

    func testInt64Create_fromNil() {
        XCTAssertEqual(Int64.Axc.Create(nil), 0)
    }

    func testInt64CreateOptional_fromNil() {
        XCTAssertNil(Int64.Axc.CreateOptional(nil))
    }
}
