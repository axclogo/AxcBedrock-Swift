//
//  AxcCorner.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/17.
//

import Foundation

/// 边角指向
public typealias AxcCorner = AxcEnum.Corner

// MARK: - [AxcBedrockLib.Corner]

public extension AxcEnum {
    /// 边角指向
    struct Corner: OptionSet {
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }

        internal init(_ rawValue: UInt) {
            self.init(rawValue: rawValue)
        }

        public static var all: Corner = [.topLeft, .topRight, .bottomLeft, .bottomRight]

        public static var topLeft: Corner { return .init(UInt(1) << 0) }
        public static var topRight: Corner { return .init(UInt(1) << 1) }
        public static var bottomLeft: Corner { return .init(UInt(1) << 2) }
        public static var bottomRight: Corner { return .init(UInt(1) << 3) }

        public private(set) var rawValue: UInt
    }
}
