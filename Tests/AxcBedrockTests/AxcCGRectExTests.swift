import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcCGRectExTests: XCTestCase {

    // MARK: - Create

    func testCreate_xywh() {
        let rect = CGRect.Axc.Create(10, 20, 100, 200)
        XCTAssertEqual(rect.origin.x, 10)
        XCTAssertEqual(rect.origin.y, 20)
        XCTAssertEqual(rect.size.width, 100)
        XCTAssertEqual(rect.size.height, 200)
    }

    func testCreate_all() {
        let rect = CGRect.Axc.Create(all: 5)
        XCTAssertEqual(rect.origin.x, 5)
        XCTAssertEqual(rect.origin.y, 5)
        XCTAssertEqual(rect.size.width, 5)
        XCTAssertEqual(rect.size.height, 5)
    }

    func testCreate_centerSize() {
        let rect = CGRect.Axc.Create(center: CGPoint(x: 50, y: 50), size: CGSize(width: 20, height: 20))
        XCTAssertEqual(rect.origin.x, 40)
        XCTAssertEqual(rect.origin.y, 40)
        XCTAssertEqual(rect.size.width, 20)
        XCTAssertEqual(rect.size.height, 20)
    }

    func testCreate_zero() {
        let rect = CGRect.Axc.Create(0, 0, 0, 0)
        XCTAssertEqual(rect, CGRect.zero)
    }

    func testCreate_fromDouble() {
        let rect = CGRect.Axc.Create(1.5, 2.5, 3.5, 4.5)
        XCTAssertEqual(rect.origin.x, 1.5)
        XCTAssertEqual(rect.origin.y, 2.5)
        XCTAssertEqual(rect.size.width, 3.5)
        XCTAssertEqual(rect.size.height, 4.5)
    }
}
