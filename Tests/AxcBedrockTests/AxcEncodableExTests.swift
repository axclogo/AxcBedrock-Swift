import XCTest
@testable import AxcBedrockCore

final class AxcEncodableExTests: XCTestCase {

    struct TestModel: Codable, Equatable {
        let name: String
        let age: Int
    }

    // MARK: - jsonEncodeData

    func testJsonEncodeData_array() {
        let arr = [1, 2, 3]
        let data = try? JSONEncoder().encode(arr)
        XCTAssertNotNil(data)
    }

    // MARK: - jsonEncodeString

    func testJsonEncodeString_array() {
        let arr = ["a", "b", "c"]
        let data = try? JSONEncoder().encode(arr)
        XCTAssertNotNil(data)
        if let data = data {
            let str = String(data: data, encoding: .utf8)
            XCTAssertNotNil(str)
        }
    }

    func testJsonEncodeString_dictionary() {
        let dict = ["key": "value"]
        let data = try? JSONEncoder().encode(dict)
        XCTAssertNotNil(data)
    }

    func testJsonEncodeString_model() {
        let model = TestModel(name: "Test", age: 25)
        let data = try? JSONEncoder().encode(model)
        XCTAssertNotNil(data)
        if let data = data {
            let str = String(data: data, encoding: .utf8)
            XCTAssertNotNil(str)
            XCTAssertTrue(str!.contains("Test"))
        }
    }

    func testJsonDecodeModel() {
        let model = TestModel(name: "Hello", age: 30)
        let data = try? JSONEncoder().encode(model)
        XCTAssertNotNil(data)
        if let data = data {
            let decoded = try? JSONDecoder().decode(TestModel.self, from: data)
            XCTAssertEqual(decoded, model)
        }
    }
}
