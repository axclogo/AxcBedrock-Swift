import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcCGSizeExTests: XCTestCase {

    // MARK: - Create

    func testCreate_wh() {
        let size = CGSize.Axc.Create(100, 200)
        XCTAssertEqual(size.width, 100)
        XCTAssertEqual(size.height, 200)
    }

    func testCreate_all() {
        let size = CGSize.Axc.Create(50)
        XCTAssertEqual(size.width, 50)
        XCTAssertEqual(size.height, 50)
    }

    func testCreate_fromDouble() {
        let size = CGSize.Axc.Create(1.5, 2.5)
        XCTAssertEqual(size.width, 1.5)
        XCTAssertEqual(size.height, 2.5)
    }

    func testCreate_zero() {
        let size = CGSize.Axc.Create(0, 0)
        XCTAssertEqual(size, CGSize.zero)
    }
}
