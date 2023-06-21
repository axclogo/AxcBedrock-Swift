//
//  AxcBoolEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/16.
//

import Foundation
import CoreGraphics

// MARK: - Bool + AxcSpaceProtocol

extension Bool: AxcSpaceProtocol { }

public extension AxcSpace where Base == Bool {
    /// 配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedNumber?) -> Bool {
        return CreateOptional(unifiedValue) ?? false
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedNumber?) -> Bool? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let int = unifiedValue as? Int { return int != 0 } else
        if let int8 = unifiedValue as? Int8 { return int8 != 0 } else
        if let int32 = unifiedValue as? Int32 { return int32 != 0 } else
        if let int64 = unifiedValue as? Int64 { return int64 != 0 } else
        if let uInt = unifiedValue as? UInt { return uInt != 0 } else
        if let uInt8 = unifiedValue as? UInt8 { return uInt8 != 0 } else
        if let uInt32 = unifiedValue as? UInt32 { return uInt32 != 0 } else
        if let uInt64 = unifiedValue as? UInt64 { return uInt64 != 0 } else
        if let float = unifiedValue as? Float { return float != 0 } else
        if let double = unifiedValue as? Double { return double != 0 } else
        if let cgFloat = unifiedValue as? CGFloat { return cgFloat != 0 } else
        if let bool = unifiedValue as? Bool { return bool } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.boolValue } else
        if let char = unifiedValue as? Character { return char != "0" } else
        if let string = unifiedValue as? String {
            switch string.axc.trimmed.lowercased() {
            case "true", "yes", "1": return true
            case "false", "no", "0": return false
            default: break
            }
        } else if let nsString = unifiedValue as? NSString { return String(nsString).axc.bool }
        return nil
    }
}
