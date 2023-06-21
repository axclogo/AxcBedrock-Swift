//
//  File.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/3.
//

import Foundation

/// weak对象持有者
public typealias AxcWeakObj = AxcBedrockLib.WeakObj

// MARK: - [AxcBedrockLib.WeakObj]

public extension AxcBedrockLib {
    /// weak对象管理。使用weak关键字来管理生命周期
    struct WeakObj<T: AnyObject>: Equatable, Hashable {
        /// 实例化一个weak对象
        public init(_ object: T) {
            self.object = object
            self.identifier = ObjectIdentifier(object)
        }

        public weak var object: T?

        /// Equatable协议实现
        public static func == (lhs: AxcWeakObj<T>, rhs: AxcWeakObj<T>) -> Bool {
            return lhs.identifier == rhs.identifier
        }

        /// Hashable协议实现
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.identifier)
        }

        // Private

        private let identifier: ObjectIdentifier
    }
}
