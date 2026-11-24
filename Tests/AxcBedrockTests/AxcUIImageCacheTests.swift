#if canImport(UIKit)
import UIKit
import XCTest
@testable import AxcBedrockCore

final class AxcUIImageCacheTests: XCTestCase {
    func testRoundedImageProducesDecodableCachedPNG() throws {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 12, height: 12), false, 1)
        UIColor.red.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 12, height: 12))
        let source = try XCTUnwrap(UIGraphicsGetImageFromCurrentImageContext())
        UIGraphicsEndImageContext()
        let file = URL(fileURLWithPath: AxcLazyCache.Shared.diskCachePath)
            .appendingPathComponent("uiImage_table").appendingPathComponent(String(source.hashValue))
        defer { try? FileManager.default.removeItem(at: file) }

        let rounded = try XCTUnwrap(source.axc.set(cornerRadius: 3))
        XCTAssertEqual(rounded.size, source.size)
        let bytes = try Data(contentsOf: file)
        XCTAssertNotNil(UIImage(data: bytes))
        XCTAssertEqual(source.axc.set(cornerRadius: 3)?.pngData(), rounded.pngData())
    }

    func testZeroRadiusReturnsOriginalImage() {
        let source = UIImage()
        XCTAssertTrue(source.axc.set(cornerRadius: 0) === source)
    }
}
#endif
