//
//  AxcArraySortWeightProtocol.swift
//  Pods
//
//  Created by 赵新 on 2023/3/29.
//

import Foundation

// MARK: - [AxcArraySortWeightProtocol]

/// 排序协议
public protocol AxcArraySortWeightProtocol {
    /// 排序权重
    var sortWeight: Int { get }
}

// MARK: - Int + AxcArraySortWeightProtocol

extension Int: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return self }
}

// MARK: - Int8 + AxcArraySortWeightProtocol

extension Int8: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - Int16 + AxcArraySortWeightProtocol

extension Int16: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - Int32 + AxcArraySortWeightProtocol

extension Int32: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - Int64 + AxcArraySortWeightProtocol

extension Int64: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - UInt + AxcArraySortWeightProtocol

extension UInt: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - UInt8 + AxcArraySortWeightProtocol

extension UInt8: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - UInt16 + AxcArraySortWeightProtocol

extension UInt16: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - UInt32 + AxcArraySortWeightProtocol

extension UInt32: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - UInt64 + AxcArraySortWeightProtocol

extension UInt64: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - Float + AxcArraySortWeightProtocol

extension Float: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - Float80 + AxcArraySortWeightProtocol

#if arch(x86_64)
extension Float80: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}
#endif

// MARK: - Double + AxcArraySortWeightProtocol

extension Double: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return Int(self) }
}

// MARK: - Bool + AxcArraySortWeightProtocol

extension Bool: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return self ? 1 : 0 }
}

// MARK: - NSNumber + AxcArraySortWeightProtocol

extension NSNumber: AxcArraySortWeightProtocol {
    public var sortWeight: Int { return self.intValue }
}
