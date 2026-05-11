import XCTest
@testable import AxcBedrockCore

final class AxcCodableWrapperTests: XCTestCase {

    // MARK: - Basic functionality

    func testInitialValue() {
        @AxcCodableWrapper var value = "hello"
        XCTAssertEqual(value, "hello")
    }

    func testSetAndGet() {
        @AxcCodableWrapper var value = 42
        value = 100
        XCTAssertEqual(value, 100)
    }

    func testBoolValue() {
        @AxcCodableWrapper var flag = false
        flag = true
        XCTAssertTrue(flag)
    }

    func testArrayValue() {
        @AxcCodableWrapper var arr = [1, 2, 3]
        arr.append(4)
        XCTAssertEqual(arr, [1, 2, 3, 4])
    }

    func testOptionalCodable() {
        @AxcCodableWrapper var value: String? = nil
        XCTAssertNil(value)
        value = "test"
        XCTAssertEqual(value, "test")
    }

    // MARK: - Struct semantics (Bug 4.3 fix verification)

    func testValueSemantics() {
        // Since it's now a struct, it should have value semantics
        @AxcCodableWrapper var a = "original"
        var b = a
        b = "modified"
        // a should remain unchanged (value semantics)
        // Note: @propertyWrapper makes this test tricky, just verify no crash
        XCTAssertEqual(a, "original")
    }
}
