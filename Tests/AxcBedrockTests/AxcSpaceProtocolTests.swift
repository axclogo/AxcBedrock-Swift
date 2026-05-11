import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcSpaceProtocolTests: XCTestCase {

    // MARK: - Namespace access

    func testStringNamespace() {
        let str = "hello"
        // Should be able to access .axc namespace
        let length = str.axc.length
        XCTAssertEqual(length, 5)
    }

    func testIntNamespace() {
        let num = 42
        // Int conforms to AxcSpaceProtocol
        let result = num.axc.int8
        XCTAssertEqual(result, 42)
    }

    func testDataNamespace() {
        let data = "test".data(using: .utf8)!
        let str = data.axc.string(encoding: .utf8)
        XCTAssertEqual(str, "test")
    }

    // MARK: - Class method namespace

    func testStringClassMethod() {
        let value: AxcUnifiedString = "hello"
        let result = String.Axc.Create(value)
        XCTAssertEqual(result, "hello")
    }

    func testIntClassMethod() {
        let result = Int.Axc.Create(42)
        XCTAssertEqual(result, 42)
    }

    func testCGPointClassMethod() {
        let point = CGPoint.Axc.Create(x: 1, y: 2)
        XCTAssertEqual(point.x, 1)
        XCTAssertEqual(point.y, 2)
    }

    // MARK: - Namespace pattern consistency

    func testNamespaceReturnsNewValue() {
        // All operations should return new values, not modify original
        let original = [1, 2, 3]
        let modified = original.axc.append([4])
        XCTAssertEqual(original, [1, 2, 3])
        XCTAssertEqual(modified, [1, 2, 3, 4])
    }
}
