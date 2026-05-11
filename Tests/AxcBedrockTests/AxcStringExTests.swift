import XCTest
@testable import AxcBedrockCore

final class AxcStringExTests: XCTestCase {

    // MARK: - hexData (Bug 9.7 fix verification)

    func testHexData_validHex() {
        let hex = "48656c6c6f"
        let data = hex.axc.hexData
        XCTAssertNotNil(data)
        XCTAssertEqual(String(data: data!, encoding: .utf8), "Hello")
    }

    func testHexData_invalidHex() {
        let hex = "ZZZZ"
        let data = hex.axc.hexData
        XCTAssertNil(data)
    }

    func testHexData_emptyString() {
        let hex = ""
        let data = hex.axc.hexData
        XCTAssertNil(data)
    }

    func testHexData_mixedCase() {
        let hex = "4a6F"
        let data = hex.axc.hexData
        XCTAssertNotNil(data)
    }

    // MARK: - uppercased (Bug 9.11 fix verification)

    func testUppercased_firstChar() {
        let str = "hello"
        let result = str.axc.uppercased(0)
        XCTAssertEqual(result, "Hello")
    }

    func testUppercased_middleChar() {
        let str = "hello"
        let result = str.axc.uppercased(2)
        XCTAssertEqual(result, "heLlo")
    }

    func testUppercased_lastChar() {
        let str = "hello"
        let result = str.axc.uppercased(4)
        XCTAssertEqual(result, "hellO")
    }

    // MARK: - encodingType (Bug 9.12 fix verification)

    func testEncodingType_utf8() {
        let str = "Hello World"
        let encoding = str.axc.encodingType
        XCTAssertEqual(encoding, .utf8)
    }

    func testEncodingType_chinese() {
        let str = "你好世界"
        let encoding = str.axc.encodingType
        XCTAssertNotNil(encoding)
    }

    // MARK: - data

    func testData_utf8() {
        let str = "Hello"
        let data = str.axc.data
        XCTAssertNotNil(data)
        XCTAssertEqual(String(data: data!, encoding: .utf8), "Hello")
    }

    func testData_emptyString() {
        let str = ""
        XCTAssertNil(str.axc.data)
    }

    func testData_encoding() {
        let str = "Hello"
        let data = str.axc.data(encoding: .ascii)
        XCTAssertNotNil(data)
    }

    // MARK: - base64

    func testBase64EncodedString() {
        let str = "Hello"
        let encoded = str.axc.base64EncodedString
        XCTAssertNotNil(encoded)
    }

    func testBase64DecodedString() {
        let str = "SGVsbG8="
        let decoded = str.axc.base64DecodedString
        XCTAssertEqual(decoded, "Hello")
    }

    func testBase64DecodedString_invalid() {
        let str = "!!invalid!!"
        let decoded = str.axc.base64DecodedString
        // Should not crash, may return nil
        _ = decoded
    }

    // MARK: - URL encoding

    func testUrlEncodedString() {
        let str = "hello world"
        let encoded = str.axc.urlEncodedString
        XCTAssertNotNil(encoded)
        XCTAssertTrue(encoded!.contains("%20") || encoded!.contains("+"))
    }

    func testUrlDecodedString() {
        let str = "hello%20world"
        let decoded = str.axc.urlDecodedString
        XCTAssertEqual(decoded, "hello world")
    }

    // MARK: - length

    func testLength() {
        XCTAssertEqual("Hello".axc.length, 5)
        XCTAssertEqual("".axc.length, 0)
        XCTAssertEqual("你好".axc.length, 2)
    }

    // MARK: - string(at:)

    func testStringAt_validIndex() {
        let str = "Hello"
        XCTAssertEqual(str.axc.string(at: 0), "H")
        XCTAssertEqual(str.axc.string(at: 4), "o")
    }

    func testStringAt_invalidIndex() {
        let str = "Hello"
        XCTAssertNil(str.axc.string(at: -1))
        XCTAssertNil(str.axc.string(at: 10))
    }

    // MARK: - prefix/suffix operations

    func testKeepPrefix() {
        XCTAssertEqual("AxcLogo".axc.keepPrefix(count: 3), "Axc")
        XCTAssertEqual("AxcLogo".axc.keepPrefix(count: 3, suffix: "..."), "Axc...")
        XCTAssertEqual("Hi".axc.keepPrefix(count: 5), "Hi")
    }

    func testKeepSuffix() {
        XCTAssertEqual("12345".axc.keepSuffix(count: 3), "345")
        XCTAssertEqual("Hi".axc.keepSuffix(count: 5), "Hi")
    }

    func testRemovePrefix_count() {
        XCTAssertEqual("Hello".axc.removePrefix(count: 2), "llo")
        XCTAssertNil("Hi".axc.removePrefix(count: 5))
    }

    func testRemovePrefix_string() {
        XCTAssertEqual("Hello".axc.removePrefix(string: "He"), "llo")
        XCTAssertEqual("Hello".axc.removePrefix(string: "XX"), "Hello")
    }

    func testRemoveSuffix_count() {
        XCTAssertEqual("Hello".axc.removeSuffix(count: 2), "Hel")
        XCTAssertNil("Hi".axc.removeSuffix(count: 5))
    }

    func testRemoveSuffix_string() {
        XCTAssertEqual("Hello".axc.removeSuffix(string: "lo"), "Hel")
        XCTAssertEqual("Hello".axc.removeSuffix(string: "XX"), "Hello")
    }

    // MARK: - split

    func testSplit_separator() {
        let result = "a-b-c".axc.split(separator: "-")
        XCTAssertEqual(result, ["a", "b", "c"])
    }

    func testSplit_emptyResult() {
        let result = "---".axc.split(separator: "-")
        XCTAssertEqual(result, [])
    }

    // MARK: - trimmed

    func testTrimmed() {
        XCTAssertEqual("  hello  ".axc.trimmed, "hello")
        XCTAssertEqual("\n\thello\n\t".axc.trimmed, "hello")
    }

    // MARK: - replacing

    func testReplacing() {
        XCTAssertEqual("hello world".axc.replacing("world", with: "swift"), "hello swift")
    }

    func testReplacing_multiple() {
        XCTAssertEqual("a-b-c".axc.replacing(strings: ["-"], with: "_"), "a_b_c")
    }

    // MARK: - count(of:)

    func testCountOf() {
        XCTAssertEqual("hello".axc.count(of: "l"), 2)
        XCTAssertEqual("hello".axc.count(of: "x"), 0)
    }

    func testCountOf_caseInsensitive() {
        XCTAssertEqual("Hello HELLO".axc.count(of: "hello", caseSensitive: false), 2)
    }

    // MARK: - first/last

    func testFirst() {
        XCTAssertEqual("Hello".axc.first, "H")
        XCTAssertNil("".axc.first)
    }

    func testLast() {
        XCTAssertEqual("Hello".axc.last, "o")
        XCTAssertNil("".axc.last)
    }

    // MARK: - camelCased

    func testCamelCased() {
        XCTAssertEqual("hello world".axc.camelCased, "helloWorld")
    }

    // MARK: - isConform

    func testIsConform_email() {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        XCTAssertTrue("test@example.com".axc.isConform(pattern: emailPattern))
        XCTAssertFalse("not-an-email".axc.isConform(pattern: emailPattern))
    }

    // MARK: - isContantChinese

    func testIsContantChinese() {
        XCTAssertTrue("Hello你好".axc.isContantChinese())
        XCTAssertFalse("Hello World".axc.isContantChinese())
    }

    // MARK: - pinYin

    func testPinYin() {
        let result = "你好".axc.pinYin
        XCTAssertNotNil(result)
        XCTAssertTrue(result!.lowercased().contains("ni"))
    }

    // MARK: - fullRange / fullNSRange

    func testFullRange() {
        let str = "Hello"
        let range = str.axc.fullRange
        XCTAssertEqual(str[range], "Hello")
    }

    func testFullNSRange() {
        let str = "Hello"
        let nsRange = str.axc.fullNSRange
        XCTAssertEqual(nsRange.location, 0)
        XCTAssertEqual(nsRange.length, 5)
    }

    // MARK: - hash

    func testHashStr_md5() {
        let str = "Hello"
        let md5 = str.axc.hashStr(.md5)
        XCTAssertNotNil(md5)
        XCTAssertEqual(md5?.count, 32)
    }

    func testHashStr_sha256() {
        let str = "Hello"
        let sha = str.axc.hashStr(.sha256)
        XCTAssertNotNil(sha)
        XCTAssertEqual(sha?.count, 64)
    }
}
