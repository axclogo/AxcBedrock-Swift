import XCTest
import CoreGraphics
@testable import AxcBedrockCore

final class AxcCGPointExTests: XCTestCase {

    // MARK: - Create

    func testCreate_xy() {
        let point = CGPoint.Axc.Create(x: 10, y: 20)
        XCTAssertEqual(point.x, 10)
        XCTAssertEqual(point.y, 20)
    }

    func testCreate_all() {
        let point = CGPoint.Axc.Create(all: 5)
        XCTAssertEqual(point.x, 5)
        XCTAssertEqual(point.y, 5)
    }

    func testCreate_fromDouble() {
        let point = CGPoint.Axc.Create(x: 1.5, y: 2.5)
        XCTAssertEqual(point.x, 1.5)
        XCTAssertEqual(point.y, 2.5)
    }

    func testCreate_fromInt() {
        let point = CGPoint.Axc.Create(x: 3, y: 7)
        XCTAssertEqual(point.x, 3.0)
        XCTAssertEqual(point.y, 7.0)
    }

    func testCreate_zero() {
        let point = CGPoint.Axc.Create(x: 0, y: 0)
        XCTAssertEqual(point, CGPoint.zero)
    }

    // MARK: - Distance

    func testDistance_samePoint() {
        let p = CGPoint(x: 5, y: 5)
        XCTAssertEqual(p.axc.distance(to: p), 0)
    }

    func testDistance_horizontal() {
        let p1 = CGPoint(x: 0, y: 0)
        let p2 = CGPoint(x: 3, y: 0)
        XCTAssertEqual(p1.axc.distance(to: p2), 3.0, accuracy: 0.001)
    }

    func testDistance_vertical() {
        let p1 = CGPoint(x: 0, y: 0)
        let p2 = CGPoint(x: 0, y: 4)
        XCTAssertEqual(p1.axc.distance(to: p2), 4.0, accuracy: 0.001)
    }

    func testDistance_diagonal() {
        let p1 = CGPoint(x: 0, y: 0)
        let p2 = CGPoint(x: 3, y: 4)
        XCTAssertEqual(p1.axc.distance(to: p2), 5.0, accuracy: 0.001)
    }
}
