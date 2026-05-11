//
//  AxcLockWrapper.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/3/17.
//

import Foundation

/// 原子锁属性包装器
/// 读写操作均加锁，确保线程安全
@propertyWrapper
open class AxcLockWrapper<T> {
    public init(wrappedValue value: T) {
        self.value = value
    }

    open var wrappedValue: T {
        set { setValue(newValue: newValue) }
        get { return getValue() }
    }

    private var value: T

    /// 锁对象，使用指针分配确保地址稳定
    private let lock: UnsafeMutablePointer<os_unfair_lock> = {
        let lock = UnsafeMutablePointer<os_unfair_lock>.allocate(capacity: 1)
        lock.initialize(to: os_unfair_lock())
        return lock
    }()

    deinit {
        lock.deinitialize(count: 1)
        lock.deallocate()
    }

    /// 读锁
    private func getValue() -> T {
        os_unfair_lock_lock(lock)
        defer { os_unfair_lock_unlock(lock) }
        return value
    }

    /// 写锁
    private func setValue(newValue: T) {
        os_unfair_lock_lock(lock)
        defer { os_unfair_lock_unlock(lock) }
        value = newValue
    }
}
