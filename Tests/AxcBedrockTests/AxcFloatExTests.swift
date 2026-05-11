import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcFloatExTests: XCTestCase {

    // MARK: - Float Create

    func testCreate_fromInt() {
        XCTAssertEqual(Float.Axc.Create(42), 42.0)
    }

    func testCreate_fromDouble() {
        XCTAssertEqual(Float.Axc.Create(3.14), 3.14, accuracy: 0.01)
    }

    func testCreate_fromCGFloat() {
        XCTAssertEqual(Float.Axc.Create(CGFloat(2.5)), 2.5)
    }

    func testCreate_fromBool() {
        XCTAssertEqual(Float.Axc.Create(true), 1.0)
        XCTAssertEqual(Float.Axc.Create(false), 0.0)
    }

    func testCreate_fromString() {
        XCTAssertEqual(Float.Axc.Create("3.14"), 3.14, accuracy: 0.01)
    }

    func testCreate_fromInvalidString() {
        XCTAssertEqual(Float.Axc.Create("abc"), 0.0)
    }

    func testCreate_fromNil() {
        XCTAssertEqual(Float.Axc.Create(nil), 0.0)
    }

    func testCreateOptional_fromNil() {
        XCTAssertNil(Float.Axc.CreateOptional(nil))
    }

    func testCreate_fromNSNumber() {
        XCTAssertEqual(Float.Axc.Create(NSNumber(value: 7.5)), 7.5, accuracy: 0.001)
    }

    func testCreate_fromInt8() {
        XCTAssertEqual(Float.Axc.Create(Int8(100)), 100.0)
    }

    func testCreate_fromUInt() {
        XCTAssertEqual(Float.Axc.Create(UInt(500)), 500.0)
    }

    // MARK: - Edge cases

    func testCreate_fromZero() {
        XCTAssertEqual(Float.Axc.Create(0), 0.0)
    }

    func testCreate_fromNegative() {
        XCTAssertEqual(Float.Axc.Create(-5.5), -5.5, accuracy: 0.001)
    }
}
