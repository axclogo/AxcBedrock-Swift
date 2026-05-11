import XCTest
@testable import AxcBedrockCore

final class AxcDataExTests: XCTestCase {

    // MARK: - string(encoding:)

    func testString_utf8() {
        let data = "Hello".data(using: .utf8)!
        XCTAssertEqual(data.axc.string(encoding: .utf8), "Hello")
    }

    func testString_ascii() {
        let data = "Hello".data(using: .ascii)!
        XCTAssertEqual(data.axc.string(encoding: .ascii), "Hello")
    }

    func testString_invalidEncoding() {
        let data = "Hello".data(using: .utf8)!
        // UTF-16 decoding of UTF-8 data may return nil or garbage
        let result = data.axc.string(encoding: .utf16)
        // Just verify it doesn't crash
        _ = result
    }

    // MARK: - base64

    func testBase64Str() {
        let data = "Hello".data(using: .utf8)!
        let base64 = data.axc.base64Str
        XCTAssertEqual(base64, "SGVsbG8=")
    }

    func testBase64String_withOptions() {
        let data = "Hello World".data(using: .utf8)!
        let base64 = data.axc.base64String(options: [])
        XCTAssertFalse(base64.isEmpty)
    }

    // MARK: - hexString

    func testHexString() {
        let data = Data([0x48, 0x65, 0x6C, 0x6C, 0x6F])
        XCTAssertEqual(data.axc.hexString, "48656c6c6f")
    }

    func testHexString_empty() {
        let data = Data()
        XCTAssertEqual(data.axc.hexString, "")
    }

    func testHexString_singleByte() {
        let data = Data([0xFF])
        XCTAssertEqual(data.axc.hexString, "ff")
    }

    // MARK: - nsData / cfData

    func testNsData() {
        let data = "test".data(using: .utf8)!
        let nsData = data.axc.nsData
        XCTAssertEqual(nsData.length, data.count)
    }

    func testCfData() {
        let data = "test".data(using: .utf8)!
        let cfData = data.axc.cfData
        XCTAssertEqual(CFDataGetLength(cfData), data.count)
    }

    // MARK: - byteArray

    func testByteArray() {
        let data = Data([0x01, 0x02, 0x03])
        let bytes = data.axc.byteArray()
        XCTAssertEqual(bytes, [0x01, 0x02, 0x03])
    }

    // MARK: - Hash

    func testHashStr_md5() {
        let data = "Hello".data(using: .utf8)!
        let md5 = data.axc.hashStr(.md5)
        XCTAssertEqual(md5.count, 32)
        XCTAssertEqual(md5, "8b1a9953c4611296a827abf8c47804d7")
    }

    func testHashStr_sha256() {
        let data = "Hello".data(using: .utf8)!
        let sha = data.axc.hashStr(.sha256)
        XCTAssertEqual(sha.count, 64)
    }

    func testHashData_md5() {
        let data = "Hello".data(using: .utf8)!
        let hashData = data.axc.hashData(.md5)
        XCTAssertEqual(hashData.count, 16)
    }

    func testHashBase64_sha1() {
        let data = "Hello".data(using: .utf8)!
        let base64 = data.axc.hashBase64(.sha1)
        XCTAssertFalse(base64.isEmpty)
    }

    // MARK: - HMAC

    func testHmacStr_sha256() {
        let data = "Hello".data(using: .utf8)!
        let hmac = data.axc.hamcStr(.sha256, key: "secret")
        XCTAssertEqual(hmac.count, 64)
    }

    func testHmacBytes_md5() {
        let data = "Hello".data(using: .utf8)!
        let bytes = data.axc.hamcBytes(.md5, key: "key")
        XCTAssertEqual(bytes.count, 16)
    }
}
