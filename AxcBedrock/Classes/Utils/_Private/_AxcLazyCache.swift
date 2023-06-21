//
//  AxcLazyCache.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

import Foundation

/// 懒加载缓存器
typealias AxcLazyCache = AxcBedrockLib.LazyCache

// MARK: AxcLazyCache.Table

extension AxcLazyCache {
    /// 存储键值
    class Table: NSObject, AxcLazyCacheTableKeyProtocol {
        /// 值
        public var cacheKey: String
        /// 缓存开关
        public var enableCache: Bool

        init(_ cacheKey: String,
             enableCache: Bool) {
            self.cacheKey = cacheKey
            self.enableCache = enableCache
        }
    }
}

// MARK: - [AxcBedrockLib.LazyCache]

extension AxcBedrockLib {
    /// 懒加载缓存器
    class LazyCache: NSObject { }
}

// MARK: - AxcLazyCache + AxcLazyCacheTarget

extension AxcLazyCache: AxcLazyCacheTarget {
    public typealias TableKey = Table
    
    var logPrefix: String {
        return AxcBedrockLib.Shared.logPrefix
    }
}

extension AxcLazyCache.Table {
    /// 默认缓存表，启用缓存
    static let defaultTable = AxcLazyCache.Table("default_table", enableCache: true)
}
