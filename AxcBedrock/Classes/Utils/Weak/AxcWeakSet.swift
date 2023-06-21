//
//  AxcWeakObjSet.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/3.
//

import Foundation

/// weak对象管理集合
public typealias AxcWeakSet = AxcBedrockLib.WeakSet

// MARK: - [AxcBedrockLib.WeakSet]

public extension AxcBedrockLib {
    /// weak对象管理。使用weak关键字来管理生命周期
    struct WeakSet<T: AnyObject> {
        /// 实例化一个空的weak合集
        public init() {
            self.objects = Set<AxcWeakObj<T>>([])
        }

        /// 实例化一个单合集
        public init(_ object: T) {
            self.objects = Set<AxcWeakObj<T>>([AxcWeakObj(object)])
        }

        /// 实例化一组的weak合集
        public init(_ objects: [T]) {
            self.objects = Set<AxcWeakObj<T>>(objects.map {
                AxcWeakObj($0)
            })
        }

        public var objects: Set<AxcWeakObj<T>>

        /// 所有的持有对象
        public var allObjects: [T] {
            return objects.compactMap { $0.object }
        }

        /// 是否包含
        public func contains(_ object: T) -> Bool {
            return self.objects.contains(AxcWeakObj(object))
        }

        /// 添加一个持有对象
        public mutating func addObject(_ object: T) {
            if self.contains(object) {
                self.removeObject(object)
            }
            self.objects.insert(AxcWeakObj(object))
        }

        /// 添加一组持有对象
        public mutating func addObjects(_ objects: [T]) {
            objects.forEach { self.addObject($0) }
        }

        /// 移除一个持有对象
        public mutating func removeObject(_ object: T) {
            self.objects.remove(AxcWeakObj<T>(object))
        }

        /// 移除一组有对象
        public mutating func removeObjects(_ objects: [T]) {
            objects.forEach { self.removeObject($0) }
        }
    }
}

// MARK: - AxcWeakSet + Sequence

extension AxcWeakSet: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        let objects = self.allObjects
        var index = 0
        return AnyIterator {
            defer { index += 1 }
            return index < objects.count ? objects[index] : nil
        }
    }
}
