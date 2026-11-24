import XCTest
import Dispatch
import AxcBedrockCore

final class AxcAssociationKeyTests: XCTestCase {
    func testTypedValuesKeysAndHostsAreIndependent() {
        let host = NSObject()
        let otherHost = NSObject()
        let first = AxcAssociationKey<Int>()
        let second = AxcAssociationKey<Int>()
        let text = AxcAssociationKey<String>()
        XCTAssertNil(AxcRuntime.GetObject(host, key: first))
        AxcRuntime.Set(object: host, key: first, value: 1)
        AxcRuntime.Set(object: host, key: second, value: 2)
        AxcRuntime.Set(object: host, key: text, value: "值")
        AxcRuntime.Set(object: otherHost, key: first, value: 3)
        XCTAssertEqual(AxcRuntime.GetObject(host, key: first), 1)
        XCTAssertEqual(AxcRuntime.GetObject(host, key: text), "值")
        XCTAssertEqual(AxcRuntime.GetObject(otherHost, key: first), 3)
        AxcRuntime.Remove(object: host, key: first)
        XCTAssertNil(AxcRuntime.GetObject(host, key: first))
        XCTAssertEqual(AxcRuntime.GetObject(host, key: second), 2)
        AxcRuntime.Set(object: host, key: second, value: nil)
        XCTAssertNil(AxcRuntime.GetObject(host, key: second))
        AxcRuntime.Remove(object: host, key: second)
    }

    func testStrongValueReleasedOnReplacementAndRemoval() {
        let host = NSObject()
        let key = AxcAssociationKey<NSObject>()
        weak var original: NSObject?
        autoreleasepool {
            let value = NSObject()
            original = value
            AxcRuntime.Set(object: host, key: key, value: value)
        }
        XCTAssertNotNil(original)
        autoreleasepool {
            AxcRuntime.Set(object: host, key: key, value: NSObject())
        }
        XCTAssertNil(original)
        weak var replacement = AxcRuntime.GetObject(host, key: key)
        XCTAssertNotNil(replacement)
        autoreleasepool { AxcRuntime.Remove(object: host, key: key) }
        XCTAssertNil(replacement)
    }

    func testHostReleaseReleasesValueAndLocallyCreatedKey() {
        weak var savedKey: AxcAssociationKey<NSObject>?
        weak var savedValue: NSObject?
        autoreleasepool {
            let host = NSObject()
            autoreleasepool {
                let key = AxcAssociationKey<NSObject>()
                let value = NSObject()
                savedKey = key
                savedValue = value
                AxcRuntime.Set(object: host, key: key, value: value)
            }
            // 活跃关联持有键，防止局部键地址复用而导致串值。
            XCTAssertNotNil(savedKey)
            XCTAssertNotNil(savedValue)
            withExtendedLifetime(host) { }
        }
        XCTAssertNil(savedKey)
        XCTAssertNil(savedValue)
    }

    func testWeakValueZeroesAfterRelease() {
        let host = NSObject()
        let key = AxcAssociationKey<NSObject>.Weak()
        weak var savedValue: NSObject?
        autoreleasepool {
            let value = NSObject()
            savedValue = value
            AxcRuntime.Set(object: host, key: key, value: value)
            XCTAssertTrue(AxcRuntime.GetObject(host, key: key) === value)
        }
        XCTAssertNil(savedValue)
        XCTAssertNil(AxcRuntime.GetObject(host, key: key))
        AxcRuntime.Remove(object: host, key: key)
    }

    func testOptionalValueDistinguishesStoredNilFromRemoval() {
        let host = NSObject()
        let key = AxcAssociationKey<Int?>()
        AxcRuntime.Set(object: host, key: key, value: .some(nil))
        let stored: Int?? = AxcRuntime.GetObject(host, key: key)
        switch stored {
        case .some(.none): break
        default: XCTFail("应保留已写入的可选空值")
        }
        AxcRuntime.Remove(object: host, key: key)
        let removed: Int?? = AxcRuntime.GetObject(host, key: key)
        XCTAssertNil(removed as Any?)
    }

    func testConcurrentReadWriteAndRemove() {
        let host = NSObject()
        let key = AxcAssociationKey<Int>()
        DispatchQueue.concurrentPerform(iterations: 500) { index in
            AxcRuntime.Set(object: host, key: key, value: index)
            if let value = AxcRuntime.GetObject(host, key: key) {
                XCTAssertTrue((0..<500).contains(value))
            }
            AxcRuntime.Remove(object: host, key: key)
        }
        XCTAssertNil(AxcRuntime.GetObject(host, key: key))
    }
}
