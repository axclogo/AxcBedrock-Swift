import XCTest
@testable import AxcBedrockCore

final class AxcArrayExTests: XCTestCase {

    // MARK: - isContent

    func testIsContent_findsMatchingElement() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertTrue(arr.axc.isContent { $0 == 3 })
    }

    func testIsContent_returnsFalseWhenNoMatch() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertFalse(arr.axc.isContent { $0 == 99 })
    }

    func testIsContent_emptyArray() {
        let arr: [Int] = []
        XCTAssertFalse(arr.axc.isContent { $0 == 1 })
    }

    func testIsContent_checksAllElements() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertTrue(arr.axc.isContent { $0 == 5 })
    }

    // MARK: - duplicates

    func testDuplicates_findsDuplicateElements() {
        let arr = [1, 1, 2, 2, 3, 3, 3, 4, 5]
        let result = arr.axc.duplicates().sorted()
        XCTAssertEqual(result, [1, 2, 3])
    }

    func testDuplicates_noDuplicates() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(arr.axc.duplicates(), [])
    }

    func testDuplicates_allSame() {
        let arr = [1, 1, 1, 1]
        XCTAssertEqual(arr.axc.duplicates(), [1])
    }

    func testDuplicates_emptyArray() {
        let arr: [Int] = []
        XCTAssertEqual(arr.axc.duplicates(), [])
    }

    func testDuplicates_strings() {
        let arr = ["h", "e", "l", "l", "o"]
        XCTAssertEqual(arr.axc.duplicates(), ["l"])
    }

    // MARK: - remove(at:)

    func testRemoveAt_validIndex() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(arr.axc.remove(at: 2), [1, 2, 4, 5])
    }

    func testRemoveAt_firstIndex() {
        let arr = [1, 2, 3]
        XCTAssertEqual(arr.axc.remove(at: 0), [2, 3])
    }

    func testRemoveAt_lastIndex() {
        let arr = [1, 2, 3]
        XCTAssertEqual(arr.axc.remove(at: 2), [1, 2])
    }

    func testRemoveAt_negativeIndex() {
        let arr = [1, 2, 3]
        let result = arr.axc.remove(at: -1)
        XCTAssertEqual(result, [1, 2, 3]) // Should not crash, returns original
    }

    func testRemoveAt_outOfBoundsIndex() {
        let arr = [1, 2, 3]
        let result = arr.axc.remove(at: 10)
        XCTAssertEqual(result, [1, 2, 3])
    }

    // MARK: - object(reversed:by:)

    func testObject_findsFirst() {
        let arr = [1, 2, 3, 4, 5]
        let result = arr.axc.object { $0 > 2 }
        XCTAssertEqual(result, 3) // Should find first match, not last
    }

    func testObject_reversed() {
        let arr = [1, 2, 3, 4, 5]
        let result = arr.axc.object(reversed: true) { $0 > 2 }
        XCTAssertEqual(result, 5) // Reversed, first match from end
    }

    func testObject_noMatch() {
        let arr = [1, 2, 3]
        let result = arr.axc.object { $0 > 10 }
        XCTAssertNil(result)
    }

    // MARK: - index(of:)

    func testIndexOf_findsFirstMatch() {
        let arr = [10, 20, 30, 20, 40]
        let result = arr.axc.index { $0 == 20 }
        XCTAssertEqual(result, 1) // Should be first occurrence
    }

    func testIndexOf_noMatch() {
        let arr = [1, 2, 3]
        let result = arr.axc.index { $0 == 99 }
        XCTAssertNil(result)
    }

    func testIndexOf_emptyArray() {
        let arr: [Int] = []
        let result = arr.axc.index { $0 == 1 }
        XCTAssertNil(result)
    }

    // MARK: - object(at:)

    func testObjectAt_validIndex() {
        let arr = [10, 20, 30]
        XCTAssertEqual(arr.axc.object(at: 1), 20)
    }

    func testObjectAt_negativeIndex() {
        let arr = [10, 20, 30]
        XCTAssertNil(arr.axc.object(at: -1))
    }

    func testObjectAt_outOfBounds() {
        let arr = [10, 20, 30]
        XCTAssertNil(arr.axc.object(at: 5))
    }

    // MARK: - insert

    func testInsert_validIndex() {
        let arr = [1, 2, 3]
        XCTAssertEqual(arr.axc.insert(99, at: 1), [1, 99, 2, 3])
    }

    func testInsert_negativeIndex() {
        let arr = [1, 2, 3]
        let result = arr.axc.insert(99, at: -1)
        XCTAssertEqual(result.first, 99)
    }

    func testInsert_beyondBounds() {
        let arr = [1, 2, 3]
        let result = arr.axc.insert(99, at: 10)
        XCTAssertEqual(result.last, 99)
    }

    // MARK: - isCrossing

    func testIsCrossing_validIndex() {
        let arr = [1, 2, 3]
        XCTAssertFalse(arr.axc.isCrossing(0))
        XCTAssertFalse(arr.axc.isCrossing(2))
    }

    func testIsCrossing_invalidIndex() {
        let arr = [1, 2, 3]
        XCTAssertTrue(arr.axc.isCrossing(-1))
        XCTAssertTrue(arr.axc.isCrossing(3))
    }

    // MARK: - random

    func testRandom_nonEmpty() {
        let arr = [1, 2, 3, 4, 5]
        let result = arr.axc.random
        XCTAssertNotNil(result)
        XCTAssertTrue(arr.contains(result!))
    }

    func testRandom_empty() {
        let arr: [Int] = []
        XCTAssertNil(arr.axc.random)
    }

    // MARK: - append

    func testAppend_elements() {
        let arr = [1, 2, 3]
        XCTAssertEqual(arr.axc.append([4, 5]), [1, 2, 3, 4, 5])
    }

    func testAppend_emptyArray() {
        let arr = [1, 2, 3]
        XCTAssertEqual(arr.axc.append([]), [1, 2, 3])
    }

    // MARK: - sum

    func testSum_integers() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertEqual(arr.axc.sum(), 15)
    }

    func testSum_empty() {
        let arr: [Int] = []
        XCTAssertEqual(arr.axc.sum(), 0)
    }

    // MARK: - chunked

    func testChunked_evenSplit() {
        let arr = [1, 2, 3, 4, 5, 6]
        let result = arr.axc.chunked(by: 3)
        XCTAssertEqual(result, [[1, 2, 3], [4, 5, 6]])
    }

    func testChunked_unevenSplit() {
        let arr = [1, 2, 3, 4, 5, 6, 7]
        let result = arr.axc.chunked(by: 3)
        XCTAssertEqual(result, [[1, 2, 3], [4, 5, 6], [7]])
    }

    // MARK: - Quick access

    func testFirst() {
        XCTAssertEqual([1, 2, 3].axc.first, 1)
    }

    func testSecond() {
        XCTAssertEqual([1, 2, 3].axc.second, 2)
    }

    func testLast() {
        XCTAssertEqual([1, 2, 3].axc.last, 3)
    }

    // MARK: - contains

    func testContains_equatable() {
        let arr = [1, 2, 3, 4, 5]
        XCTAssertTrue(arr.axc.contains([1, 2]))
        XCTAssertFalse(arr.axc.contains([1, 6]))
    }

    // MARK: - containsDuplicates

    func testContainsDuplicates_true() {
        XCTAssertTrue([1, 2, 2, 3].axc.containsDuplicates())
    }

    func testContainsDuplicates_false() {
        XCTAssertFalse([1, 2, 3, 4].axc.containsDuplicates())
    }

    // MARK: - filter

    func testFilter_removesMatching() {
        let arr = [1, 2, 3, 4, 5]
        let result = arr.axc.filter { $0 % 2 == 0 }
        XCTAssertEqual(result, [1, 3, 5])
    }

    // MARK: - count(where:)

    func testCountWhere() {
        let arr = [1, 2, 3, 4, 5, 6]
        XCTAssertEqual(arr.axc.count { $0 % 2 == 0 }, 3)
    }

    // MARK: - sort

    func testSortByAscend() {
        struct Item { let value: Int }
        let items = [Item(value: 3), Item(value: 1), Item(value: 2)]
        let sorted = items.axc.sortByAscend(\.value)
        XCTAssertEqual(sorted.map(\.value), [1, 2, 3])
    }

    func testSortByDescend() {
        struct Item { let value: Int }
        let items = [Item(value: 3), Item(value: 1), Item(value: 2)]
        let sorted = items.axc.sortByDescend(\.value)
        XCTAssertEqual(sorted.map(\.value), [3, 2, 1])
    }
}
