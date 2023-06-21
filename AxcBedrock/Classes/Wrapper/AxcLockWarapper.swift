//
//  AxcLockWarapper.swift
//  Pods
//
//  Created by 赵新 on 2023/3/17.
//

import Foundation

/// 原子锁属性包装器
@propertyWrapper
open class AxcLockWarapper<T> {
    public init(wrappedValue value: T) {
        self.value = value
    }

    open var wrappedValue: T {
        set { setValue(newValue: newValue) }
        get {
            if isUseReadLock {
                return getValue()
            } else {
                return value
            }
        }
    }

    /// 设置是否使用读锁
    /// 一般多用写锁多读，默认false不开启读锁
    /// - Parameter isUseReadLock: Bool
    open func set(isUseReadLock: Bool) {
        self.isUseReadLock = isUseReadLock
    }

    /// 是否使用读锁
    private var isUseReadLock: Bool = false
    private var value: T
    /// 锁对象
    private var lock = os_unfair_lock_s()

    /// 读锁
    private func getValue() -> T {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }
        return value
    }

    /// 写锁
    private func setValue(newValue: T) {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }
        value = newValue
    }
}
