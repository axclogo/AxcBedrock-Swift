import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcDoubleExTests: XCTestCase {

    // MARK: - Create

    func testCreate_fromInt() {
        let value = Double.Axc.Create(42)
        XCTAssertEqual(value, 42.0)
    }

    func testCreate_fromFloat() {
        let value = Double.Axc.Create(Float(3.14))
        XCTAssertEqual(value, 3.14, accuracy: 0.01)
    }

    func testCreate_fromCGFloat() {
        let value = Double.Axc.Create(CGFloat(2.5))
        XCTAssertEqual(value, 2.5)
    }

    func testCreate_fromBool() {
        XCTAssertEqual(Double.Axc.Create(true), 1.0)
        XCTAssertEqual(Double.Axc.Create(false), 0.0)
    }

    func testCreate_fromString() {
        XCTAssertEqual(Double.Axc.Create("3.14"), 3.14, accuracy: 0.001)
    }

    func testCreate_fromInvalidString() {
        XCTAssertEqual(Double.Axc.Create("abc"), 0.0)
    }

    func testCreate_fromNil() {
        XCTAssertEqual(Double.Axc.Create(nil), 0.0)
    }

    func testCreateOptional_fromNil() {
        XCTAssertNil(Double.Axc.CreateOptional(nil))
    }

    func testCreate_fromNSNumber() {
        XCTAssertEqual(Double.Axc.Create(NSNumber(value: 9.99)), 9.99, accuracy: 0.001)
    }

    func testCreate_fromInt8() {
        XCTAssertEqual(Double.Axc.Create(Int8(100)), 100.0)
    }

    func testCreate_fromUInt() {
        XCTAssertEqual(Double.Axc.Create(UInt(500)), 500.0)
    }

    // MARK: - Edge cases

    func testCreate_fromZero() {
        XCTAssertEqual(Double.Axc.Create(0), 0.0)
    }

    func testCreate_fromNegative() {
        XCTAssertEqual(Double.Axc.Create(-3.14), -3.14, accuracy: 0.001)
    }

    func testCreate_fromMaxInt() {
        let value = Double.Axc.Create(Int.max)
        XCTAssertTrue(value > 0)
    }
}
