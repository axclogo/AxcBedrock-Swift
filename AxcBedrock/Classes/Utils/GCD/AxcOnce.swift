import Foundation

// MARK: - 实例级一次性执行

/// 每个令牌实例最多执行一次同步闭包。
/// 将令牌保存为对象属性可实现对象级语义，保存为 static let 可在该静态属性范围共享。
/// 并发调用仅一个调用者执行；其余调用立即返回，不等待闭包完成，不作为初始化完成屏障。
public final class AxcOnce {
    private let lock = NSLock()
    private var hasStarted = false

    /// 创建独立的一次性执行令牌，不提供重置操作。
    public init() { }

    /// 首次调用在当前线程同步执行并返回 true，后续调用（包括重入）返回 false。
    /// 执行前即占用令牌，闭包在锁外执行；异步派发的任务不在此方法的完成保证范围内。
    @discardableResult
    public func run(_ body: () -> Void) -> Bool {
        lock.lock()
        guard !hasStarted else {
            lock.unlock()
            return false
        }
        hasStarted = true
        lock.unlock()
        body()
        return true
    }
}
