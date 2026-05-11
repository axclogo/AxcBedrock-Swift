import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcCGFloatExTests: XCTestCase {

    // MARK: - Create

    func testCreate_fromInt() {
        let value = CGFloat.Axc.Create(42)
        XCTAssertEqual(value, 42.0)
    }

    func testCreate_fromDouble() {
        let value = CGFloat.Axc.Create(3.14)
        XCTAssertEqual(value, 3.14, accuracy: 0.001)
    }

    func testCreate_fromFloat() {
        let value = CGFloat.Axc.Create(Float(2.5))
        XCTAssertEqual(value, 2.5, accuracy: 0.001)
    }

    func testCreate_fromBool() {
        XCTAssertEqual(CGFloat.Axc.Create(true), 1.0)
        XCTAssertEqual(CGFloat.Axc.Create(false), 0.0)
    }

    func testCreate_fromString() {
        let value = CGFloat.Axc.Create("3.14")
        XCTAssertEqual(value, 3.14, accuracy: 0.01)
    }

    func testCreate_fromInvalidString() {
        let value = CGFloat.Axc.Create("abc")
        XCTAssertEqual(value, 0.0)
    }

    func testCreate_fromNil() {
        let value = CGFloat.Axc.Create(nil)
        XCTAssertEqual(value, 0.0)
    }

    func testCreateOptional_fromNil() {
        XCTAssertNil(CGFloat.Axc.CreateOptional(nil))
    }

    func testCreate_fromNSNumber() {
        let value = CGFloat.Axc.Create(NSNumber(value: 7.5))
        XCTAssertEqual(value, 7.5, accuracy: 0.001)
    }

    // MARK: - Edge cases

    func testCreate_fromZero() {
        XCTAssertEqual(CGFloat.Axc.Create(0), 0.0)
    }

    func testCreate_fromNegative() {
        XCTAssertEqual(CGFloat.Axc.Create(-5), -5.0)
    }

    func testCreate_fromLargeValue() {
        let value = CGFloat.Axc.Create(Int.max)
        XCTAssertTrue(value > 0)
    }
}
