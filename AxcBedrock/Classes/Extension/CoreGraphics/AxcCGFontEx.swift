//
//  AxcCGFontEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/25.
//

import CoreGraphics
import Foundation
import CoreText

// MARK: - CGFont + AxcSpaceProtocol

extension CGFont: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base: CGFont { }

// MARK: - 类方法

public extension AxcSpace where Base: CGFont {
    /// 配合协议用创建方法 具有默认值
    static func Create(_ unifiedValue: AxcUnifiedFont?,
                       weight: AxcBedrockFontWeight = .regular) -> CGFont {
        // CGFont只能通过名称创建，并且实例化方法是可选的
        // 所以在可选分支直接设置FatalError即可
        let fontName = ".SFUI-Regular".axc.cfString
        guard let cgFont = CGFont(fontName) else {
            let log = "内部创建默认CGFont失败！fontName: \(fontName)"
            AxcBedrockLib.FatalLog(log)
        }
        return CreateOptional(unifiedValue, weight: weight) ?? cgFont
    }

    /// 配合协议用创建方法 可选
    static func CreateOptional(_ unifiedValue: AxcUnifiedFont?,
                               weight: AxcBedrockFontWeight = .regular) -> CGFont? {
        guard let unifiedValue = unifiedValue else { return nil }
        var fontPoint: AxcUnifiedNumber?
        if let int = unifiedValue as? Int { fontPoint = int } else
        if let int8 = unifiedValue as? Int8 { fontPoint = int8 } else
        if let int16 = unifiedValue as? Int16 { fontPoint = int16 } else
        if let int32 = unifiedValue as? Int32 { fontPoint = int32 } else
        if let int64 = unifiedValue as? Int64 { fontPoint = int64 } else
        if let uInt = unifiedValue as? UInt { fontPoint = uInt } else
        if let uInt8 = unifiedValue as? UInt8 { fontPoint = uInt8 } else
        if let uInt16 = unifiedValue as? UInt16 { fontPoint = uInt16 } else
        if let uInt32 = unifiedValue as? UInt32 { fontPoint = uInt32 } else
        if let uInt64 = unifiedValue as? UInt64 { fontPoint = uInt64 } else
        if let float = unifiedValue as? Float { fontPoint = float } else
        if let double = unifiedValue as? Double { fontPoint = double } else
        if let cgFloat = unifiedValue as? CGFloat { fontPoint = cgFloat } else
        if let string = unifiedValue as? String { fontPoint = string } else
        if let char = unifiedValue as? Character { fontPoint = char }
        else if let nsNumber = unifiedValue as? NSNumber { fontPoint = nsNumber } else
        if let nsString = unifiedValue as? NSString { fontPoint = nsString }
        
        if let _ = fontPoint,
           let baseFont = unifiedValue as? AxcBedrockFont {
            // CTFont和CGFont并不像UIFont一样包含点大小
            // 这个例子会告诉你如何将UIFont转换成CGFont
            let fontName = baseFont.fontName.axc.cfString
            return CGFont(fontName)

        } else if let cgFont = AxcBedrockLib.Func.CFType(unifiedValue, as: CGFont.self) {
            return cgFont

        } else if let ctFont = AxcBedrockLib.Func.CFType(unifiedValue, as: CTFont.self) {
            let fontName = ctFont.axc.postScriptName.axc.cfString
            return CGFont(fontName)
        }
        return nil
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CGFont { }

// MARK: - 决策判断

public extension AxcSpace where Base: CGFont { }
