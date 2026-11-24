import XCTest
import Dispatch
import AxcBedrockCore

final class AxcOnceTests: XCTestCase {
    func testRunsSynchronouslyOncePerInstance() {
        let once = AxcOnce()
        var count = 0
        XCTAssertTrue(once.run { count += 1 })
        XCTAssertEqual(count, 1)
        XCTAssertFalse(once.run { count += 1 })
        XCTAssertTrue(AxcOnce().run { count += 1 })
        XCTAssertEqual(count, 2)
    }

    func testReentrySkipsWithoutDeadlock() {
        let once = AxcOnce()
        XCTAssertTrue(once.run {
            XCTAssertFalse(once.run { XCTFail("重入不应执行") })
        })
    }

    func testConcurrentCallersExecuteOnlyOneBody() {
        let once = AxcOnce()
        let countLock = NSLock()
        var bodyCount = 0
        var winnerCount = 0
        DispatchQueue.concurrentPerform(iterations: 1000) { _ in
            let executed = once.run {
                countLock.lock()
                bodyCount += 1
                countLock.unlock()
            }
            if executed {
                countLock.lock()
                winnerCount += 1
                countLock.unlock()
            }
        }
        XCTAssertEqual(bodyCount, 1)
        XCTAssertEqual(winnerCount, 1)
    }

    func testOtherCallersDoNotWaitForBodyCompletion() {
        let once = AxcOnce()
        let started = DispatchSemaphore(value: 0)
        let release = DispatchSemaphore(value: 0)
        let returned = expectation(description: "后续调用在首次闭包完成前返回")
        let finished = expectation(description: "首次闭包完成")
        DispatchQueue.global().async {
            once.run {
                started.signal()
                _ = release.wait(timeout: .now() + 5)
            }
            finished.fulfill()
        }
        XCTAssertEqual(started.wait(timeout: .now() + 2), .success)
        DispatchQueue.global().async {
            XCTAssertFalse(once.run { XCTFail("重复执行") })
            returned.fulfill()
        }
        wait(for: [returned], timeout: 2)
        release.signal()
        wait(for: [finished], timeout: 2)
    }
}
