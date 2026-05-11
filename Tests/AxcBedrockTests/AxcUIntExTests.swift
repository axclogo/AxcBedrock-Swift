import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcUIntExTests: XCTestCase {

    // MARK: - UInt Create

    func testUIntCreate_fromInt() {
        XCTAssertEqual(UInt.Axc.Create(42), 42)
    }

    func testUIntCreate_fromDouble() {
        XCTAssertEqual(UInt.Axc.Create(3.7), 3)
    }

    func testUIntCreate_fromBool() {
        XCTAssertEqual(UInt.Axc.Create(true), 1)
        XCTAssertEqual(UInt.Axc.Create(false), 0)
    }

    func testUIntCreate_fromString() {
        XCTAssertEqual(UInt.Axc.Create("100"), 100)
    }

    func testUIntCreate_fromNil() {
        XCTAssertEqual(UInt.Axc.Create(nil), 0)
    }

    func testUIntCreateOptional_fromNil() {
        XCTAssertNil(UInt.Axc.CreateOptional(nil))
    }

    func testUIntCreate_fromNSNumber() {
        XCTAssertEqual(UInt.Axc.Create(NSNumber(value: 50)), 50)
    }

    func testUIntCreate_fromCGFloat() {
        XCTAssertEqual(UInt.Axc.Create(CGFloat(7.9)), 7)
    }

    // MARK: - UInt8 Create

    func testUInt8Create_fromInt() {
        XCTAssertEqual(UInt8.Axc.Create(200), 200)
    }

    func testUInt8Create_overflow() {
        let result = UInt8.Axc.Create(300)
        XCTAssertEqual(result, 255) // clamped to max
    }

    func testUInt8Create_fromBool() {
        XCTAssertEqual(UInt8.Axc.Create(true), 1)
    }

    // MARK: - UInt16 Create

    func testUInt16Create_fromInt() {
        XCTAssertEqual(UInt16.Axc.Create(60000), 60000)
    }

    func testUInt16Create_overflow() {
        let result = UInt16.Axc.Create(70000)
        XCTAssertEqual(result, UInt16.max)
    }

    // MARK: - UInt32 Create

    func testUInt32Create_fromInt() {
        XCTAssertEqual(UInt32.Axc.Create(100000), 100000)
    }

    func testUInt32Create_fromNil() {
        XCTAssertEqual(UInt32.Axc.Create(nil), 0)
    }

    // MARK: - UInt64 Create

    func testUInt64Create_fromInt() {
        XCTAssertEqual(UInt64.Axc.Create(999999), 999999)
    }

    func testUInt64Create_fromBool() {
        XCTAssertEqual(UInt64.Axc.Create(true), 1)
    }

    func testUInt64Create_fromNil() {
        XCTAssertEqual(UInt64.Axc.Create(nil), 0)
    }
}
