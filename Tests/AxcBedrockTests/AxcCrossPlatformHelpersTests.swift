import XCTest
import AxcBedrockCore
#if os(macOS)
import AppKit
#else
import UIKit
#endif

final class AxcCrossPlatformHelpersTests: XCTestCase {
    func testExistingInsetsTotalsAndAddition() {
        let edge = AxcBedrockEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        XCTAssertEqual(edge.axc.horizontal, 6)
        XCTAssertEqual(edge.axc.vertical, 4)
        let sum = edge.axc.add(edge: .init(top: -1, left: 1, bottom: 2, right: -2))
        XCTAssertEqual(sum.top, 0)
        XCTAssertEqual(sum.left, 3)
        XCTAssertEqual(sum.bottom, 5)
        XCTAssertEqual(sum.right, 2)
        let size = CGSize(width: 10, height: 20)
        XCTAssertEqual(size.axc.add(edge: edge), CGSize(width: 16, height: 24))
        XCTAssertEqual(size.axc.subtract(edge: edge), CGSize(width: 4, height: 16))
    }

    func testExistingInsetsCreationAndInset() {
        let edge = AxcBedrockEdgeInsets.Axc.Create(horizontal: 2, vertical: 3)
        XCTAssertEqual(edge.axc.horizontal, 4)
        XCTAssertEqual(edge.axc.vertical, 6)
        XCTAssertEqual(edge.axc.inset(rect: CGRect(x: 0, y: 0, width: 10, height: 20)),
                       CGRect(x: 2, y: 3, width: 6, height: 14))
    }

    func testExistingImageAliasPreservesNativeIdentity() {
        #if os(macOS)
        let native = NSImage(size: CGSize(width: 1, height: 1))
        #else
        let native = UIImage()
        #endif
        let unified: AxcBedrockImage = native
        XCTAssertTrue(unified === native)
    }
}
