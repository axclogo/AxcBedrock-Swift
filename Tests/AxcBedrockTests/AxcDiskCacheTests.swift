import XCTest
@testable import AxcBedrockCore

private final class TestDiskCache: NSObject, AxcLazyCacheTarget {
    typealias TableKey = AxcLazyCache.Table
    var logPrefix: String { return "AxcDiskCacheTests" }
    var diskCachePath: String {
        return FileManager.default.temporaryDirectory
            .appendingPathComponent("AxcBedrockDiskCacheTests").path
    }
}

final class AxcDiskCacheTests: XCTestCase {
    private enum LoadError: Error { case failed }
    private var table: AxcLazyCache.Table!
    private var directory: URL!

    override func setUp() {
        super.setUp()
        table = AxcLazyCache.Table(UUID().uuidString, enableCache: true)
        directory = URL(fileURLWithPath: TestDiskCache.Shared.diskCachePath)
            .appendingPathComponent(table.cacheKey)
    }

    override func tearDown() {
        try? FileManager.default.removeItem(at: directory)
        super.tearDown()
    }

    func testFailedLoadDoesNotCreateEntryAndCanRetry() throws {
        XCTAssertThrowsError(try TestDiskCache.DiskCache(table: table, fileName: "image") {
            throw LoadError.failed
        }) { XCTAssertTrue($0 is LoadError) }
        XCTAssertFalse(FileManager.default.fileExists(atPath: directory.appendingPathComponent("image").path))

        let expected = Data([1, 2, 3])
        XCTAssertEqual(TestDiskCache.DiskCache(table: table, fileName: "image") { expected }, expected)
        XCTAssertEqual(try Data(contentsOf: directory.appendingPathComponent("image")), expected)
        XCTAssertEqual(try TestDiskCache.DiskCache(table: table, fileName: "image") {
            throw LoadError.failed // 命中有效缓存时不调用加载器。
        }, expected)
    }

    func testExpiredReloadFailurePropagatesWithoutReplacingFile() throws {
        let original = Data([1])
        _ = TestDiskCache.DiskCache(table: table, fileName: "image") { original }
        let file = directory.appendingPathComponent("image")
        try FileManager.default.setAttributes([.modificationDate: Date(timeIntervalSinceNow: -120)],
                                              ofItemAtPath: file.path)
        XCTAssertThrowsError(try TestDiskCache.DiskCache(table: table, fileName: "image",
                                                       expiry: AxcTimeMark(second: 1)) {
            throw LoadError.failed
        }) { XCTAssertTrue($0 is LoadError) }
        XCTAssertEqual(try Data(contentsOf: file), original)

        let replacement = Data([2])
        XCTAssertEqual(TestDiskCache.DiskCache(table: table, fileName: "image",
                                              expiry: AxcTimeMark(second: 1)) { replacement }, replacement)
        XCTAssertEqual(try Data(contentsOf: file), replacement)
    }

    func testWriteFailureStillReturnsLoadedData() {
        let expected = Data([3])
        XCTAssertEqual(TestDiskCache.DiskCache(table: table, fileName: "missing/image") { expected }, expected)
        XCTAssertFalse(FileManager.default.fileExists(atPath: directory.appendingPathComponent("missing/image").path))
    }

    func testEmptyDataIsAValidCacheValue() {
        XCTAssertEqual(TestDiskCache.DiskCache(table: table, fileName: "empty") { Data() }, Data())
        XCTAssertEqual(TestDiskCache.DiskCache(table: table, fileName: "empty") {
            XCTFail("空 Data 不是加载失败标记")
            return Data([1])
        }, Data())
    }
}
