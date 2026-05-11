import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcStringCreateTests: XCTestCase {

    // MARK: - Create from AxcUnifiedString

    func testCreate_fromString() {
        let value: AxcUnifiedString = "hello"
        XCTAssertEqual(String.Axc.Create(value), "hello")
    }

    func testCreate_fromInt() {
        XCTAssertEqual(String.Axc.Create(42), "42")
    }

    func testCreate_fromDouble() {
        let result = String.Axc.Create(3.14)
        XCTAssertTrue(result.contains("3.14"))
    }

    func testCreate_fromBool() {
        XCTAssertEqual(String.Axc.Create(true), "true")
        XCTAssertEqual(String.Axc.Create(false), "false")
    }

    func testCreate_fromNSNumber() {
        // NSNumber conforms to AxcUnifiedNumber, test via Int conversion
        let num = NSNumber(value: 99)
        let intResult = Int.Axc.Create(num)
        XCTAssertEqual(intResult, 99)
    }

    func testCreate_fromNil() {
        let nilValue: AxcUnifiedString? = nil
        XCTAssertEqual(String.Axc.Create(nilValue), "")
    }

    func testCreateOptional_fromNil() {
        XCTAssertNil(String.Axc.CreateOptional(nil as AxcUnifiedString?))
    }

    func testCreate_fromInt8() {
        XCTAssertEqual(String.Axc.Create(Int8(127)), "127")
    }

    func testCreate_fromUInt() {
        XCTAssertEqual(String.Axc.Create(UInt(100)), "100")
    }

    func testCreate_fromFloat() {
        let result = String.Axc.Create(Float(1.5))
        XCTAssertTrue(result.contains("1.5"))
    }

    func testCreate_fromCGFloat() {
        let result = String.Axc.Create(CGFloat(2.5))
        XCTAssertTrue(result.contains("2.5"))
    }

    func testCreate_fromCharacter() {
        let char: Character = "A"
        XCTAssertEqual(String.Axc.Create(char), "A")
    }

    func testCreate_fromSubstring() {
        let str = "Hello World"
        let sub = str.prefix(5)
        XCTAssertEqual(String.Axc.Create(sub), "Hello")
    }

    func testCreate_fromData() {
        let data = "test".data(using: .utf8)!
        let value: AxcUnifiedString = data
        XCTAssertEqual(String.Axc.Create(value), "test")
    }

    func testCreate_fromURL() {
        let url = URL(string: "https://example.com")!
        let value: AxcUnifiedUrl = url
        XCTAssertEqual(String.Axc.Create(value), "https://example.com")
    }

    // MARK: - RandomString

    func testRandomString_length() {
        let str = String.Axc.RandomString(10)
        XCTAssertEqual(str.count, 10)
    }

    func testRandomString_zeroLength() {
        let str = String.Axc.RandomString(0)
        XCTAssertEqual(str, "")
    }

    func testRandomString_uniqueness() {
        let str1 = String.Axc.RandomString(20)
        let str2 = String.Axc.RandomString(20)
        // Extremely unlikely to be equal
        XCTAssertNotEqual(str1, str2)
    }

    // MARK: - Create from AxcUnifiedUrl

    func testCreateFromUrl_string() {
        let result = String.Axc.CreateOptional("https://example.com" as AxcUnifiedUrl?)
        XCTAssertEqual(result, "https://example.com")
    }

    func testCreateFromUrl_url() {
        let url = URL(string: "https://example.com")!
        let result = String.Axc.CreateOptional(url as AxcUnifiedUrl?)
        XCTAssertEqual(result, "https://example.com")
    }

    func testCreateFromUrl_nil() {
        XCTAssertNil(String.Axc.CreateOptional(nil as AxcUnifiedUrl?))
    }
}
