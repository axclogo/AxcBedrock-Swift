import XCTest
import CoreGraphics
import AxcBedrockCore

final class AxcGeometryHelpersTests: XCTestCase {
    func testClampingIntegersAndBoundaries() {
        XCTAssertEqual((-1).axc.clamped(to: 0...10), 0)
        XCTAssertEqual(11.axc.clamped(to: 0...10), 10)
        for value in [0, 5, 10] {
            XCTAssertEqual(value.axc.clamped(to: 0...10), value)
        }
        XCTAssertEqual(Int.min.axc.clamped(to: -1...1), -1)
        XCTAssertEqual(Int.max.axc.clamped(to: -1...1), 1)
        XCTAssertEqual(UInt.max.axc.clamped(to: 0...10), 10)
        XCTAssertEqual(Int8(-5).axc.clamped(to: 2...2), 2)
    }

    func testClampingFloatingPointValues() {
        XCTAssertEqual(Float(0.5).axc.clamped(to: 0...1), 0.5)
        XCTAssertEqual(CGFloat(2).axc.clamped(to: 0...1), 1)
        XCTAssertEqual(Double.infinity.axc.clamped(to: -1...1), 1)
        XCTAssertEqual((-Double.infinity).axc.clamped(to: -1...1), -1)
        XCTAssertTrue(Double.nan.axc.clamped(to: -1...1).isNaN)
        XCTAssertEqual(Double.infinity.axc.clamped(to: -Double.infinity...Double.infinity), .infinity)
    }

    func testPointAndSizeFiniteness() {
        XCTAssertTrue(CGPoint.zero.axc.isFinite)
        XCTAssertTrue(CGSize.zero.axc.isFinite)
        XCTAssertTrue(CGPoint(x: -1, y: 2).axc.isFinite)
        XCTAssertTrue(CGSize(width: -1, height: 2).axc.isFinite)
        for invalid in [CGFloat.nan, .infinity, -.infinity] {
            XCTAssertFalse(CGPoint(x: invalid, y: 0).axc.isFinite)
            XCTAssertFalse(CGPoint(x: 0, y: invalid).axc.isFinite)
            XCTAssertFalse(CGSize(width: invalid, height: 0).axc.isFinite)
            XCTAssertFalse(CGSize(width: 0, height: invalid).axc.isFinite)
        }
    }

    func testRectFinitenessIncludesEdgesAndSystemSentinels() {
        XCTAssertTrue(CGRect.zero.axc.isFinite)
        XCTAssertTrue(CGRect(x: 10, y: 10, width: -5, height: -5).axc.isFinite)
        XCTAssertFalse(CGRect.null.axc.isFinite)
        XCTAssertFalse(CGRect.infinite.axc.isFinite)
        for invalid in [CGFloat.nan, .infinity, -.infinity] {
            XCTAssertFalse(CGRect(x: invalid, y: 0, width: 1, height: 1).axc.isFinite)
            XCTAssertFalse(CGRect(x: 0, y: invalid, width: 1, height: 1).axc.isFinite)
            XCTAssertFalse(CGRect(x: 0, y: 0, width: invalid, height: 1).axc.isFinite)
            XCTAssertFalse(CGRect(x: 0, y: 0, width: 1, height: invalid).axc.isFinite)
        }
        let large = CGFloat.greatestFiniteMagnitude
        XCTAssertFalse(CGRect(x: large, y: 0, width: large, height: 1).axc.isFinite)
        XCTAssertFalse(CGRect(x: 0, y: -large, width: 1, height: -large).axc.isFinite)
    }
}
