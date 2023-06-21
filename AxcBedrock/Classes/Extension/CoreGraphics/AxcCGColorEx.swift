//
//  AxcCGColorEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/1/18.
//

import CoreGraphics
import CoreImage
import Foundation

fileprivate extension AxcLazyCache.TableKey {
    /// 颜色转换缓存表，启用缓存
    static let cgColorTable = AxcLazyCache.Table("cgColor_table", enableCache: true)
}

// MARK: - CGColor + AxcSpaceProtocol

extension CGColor: AxcSpaceProtocol { }

public extension AxcSpace where Base == CGColor {
    // MARK: 配合协议用创建方法

    /// 配合协议用创建方法 具有默认值
    static func Create(_ unifiedValue: AxcUnifiedColor?,
                       alpha: AxcUnifiedNumber = 1) -> CGColor {
        return CreateOptional(unifiedValue, alpha: alpha) ?? AxcBedrockColor.black.cgColor
    }

    /// 配合协议用创建方法 可选
    /// - Parameters:
    ///   - unifiedValue: 通用颜色类型
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(_ unifiedValue: AxcUnifiedColor?,
                               alpha: AxcUnifiedNumber = 1) -> CGColor? {
        guard let unifiedValue = unifiedValue else { return nil }
        var _color: CGColor?
        let alpha = CGFloat.Axc.CreateOptional(alpha) ?? 1
        var hexInt: Int?
        if let int = unifiedValue as? Int { hexInt = int } else
        if let int8 = unifiedValue as? Int8 { hexInt = int8.axc.int } else
        if let int16 = unifiedValue as? Int16 { hexInt = int16.axc.int } else
        if let int32 = unifiedValue as? Int32 { hexInt = int32.axc.int } else
        if let int64 = unifiedValue as? Int64 { hexInt = int64.axc.int } else
        if let uInt = unifiedValue as? UInt { hexInt = uInt.axc.int } else
        if let uInt8 = unifiedValue as? UInt8 { hexInt = uInt8.axc.int } else
        if let uInt16 = unifiedValue as? UInt16 { hexInt = uInt16.axc.int } else
        if let uInt32 = unifiedValue as? UInt32 { hexInt = uInt32.axc.int } else
        if let uInt64 = unifiedValue as? UInt64 { hexInt = uInt64.axc.int }
        if let hexInt = hexInt {
            return CGColor.Axc.CreateOptional(hexInt: hexInt)
        }
        if let string = unifiedValue as? String {
            _color = CGColor.Axc.Create(hexStr: string)
 
        } else if let nsString = unifiedValue as? NSString {
            _color = CGColor.Axc.Create(hexStr: nsString.axc.string)

        } else if let platformColor = unifiedValue as? AxcBedrockColor {
            _color = platformColor.cgColor

        } else if let cgColor = AxcBedrockLib.Func.CFType(unifiedValue, as: CGColor.self) {
            _color = cgColor

        } else if let ciColor = unifiedValue as? CIColor {
            _color = AxcBedrockColor(ciColor: ciColor).cgColor
        }
        if alpha != 1 { // 优化透明度计算
            _color = _color?.copy(alpha: alpha)
        }
        return _color
    }

    // MARK: 灰色创建方法

    /// 生成一个灰色 具有默认值
    /// - Parameters:
    ///   - gray: 灰色度
    ///   - alpha: 阿尔法通道值
    static func Create(gray: CGFloat,
                       alpha: CGFloat = 1) -> CGColor {
        return CreateOptional(gray: gray, alpha: alpha) ?? AxcBedrockColor.black.cgColor
    }

    /// 生成一个灰色 可选
    /// - Parameters:
    ///   - gray: 灰色度
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(gray: CGFloat,
                               alpha: CGFloat = 1) -> CGColor? {
        return CreateOptional(gray, gray, gray, alpha: alpha)
    }

    // MARK: HexString创建

    /// 通过HexString创建 具有默认值
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 阿尔法通道值
    static func Create(hexStr: String,
                       alpha: CGFloat = 1) -> CGColor {
        return CreateOptional(hexStr: hexStr, alpha: alpha) ?? AxcBedrockColor.black.cgColor
    }

    /// 通过HexString创建 可选
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(hexStr: String,
                               alpha: CGFloat = 1) -> CGColor? {
        var formatted = hexStr.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        guard let hex = Int(formatted, radix: 16) else { return nil }
        let red = CGFloat((hex & 0xFF0000) >> 16)
        let green = CGFloat((hex & 0xFF00) >> 8)
        let blue = CGFloat((hex & 0xFF) >> 0)
        guard let color = CGColor.Axc.CreateOptional(red, green, blue, alpha: alpha) else { return nil }
        return color
    }

    // MARK: HexInt创建

    /// 通过HexInt创建 具有默认值
    /// - Parameters:
    ///   - hexInt: 十六进制长整型
    ///   - alpha: 阿尔法通道值
    static func Create(hexInt: Int,
                       alpha: CGFloat = 1) -> CGColor {
        return CreateOptional(hexInt: hexInt, alpha: alpha) ?? AxcBedrockColor.black.cgColor
    }

    /// 通过HexInt创建 可选
    /// - Parameters:
    ///   - hexInt: 十六进制长整型
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(hexInt: Int,
                               alpha: CGFloat = 1) -> CGColor? {
        let color = CreateOptional(CGFloat((hexInt & 0xFF0000) >> 16),
                                   CGFloat((hexInt & 0xFF00) >> 8),
                                   CGFloat((hexInt & 0xFF)), alpha: alpha)
        return color
    }

    // MARK: RGBA创建

    /// 通过RGBA创建，内部会自动除以255 具有默认值
    /// - Parameters:
    ///   - r: 红色值
    ///   - g: 绿色值
    ///   - b: 蓝色值
    ///   - a: 透明度值
    static func Create(_ r: AxcUnifiedNumber,
                       _ g: AxcUnifiedNumber,
                       _ b: AxcUnifiedNumber,
                       alpha: AxcUnifiedNumber = 1) -> CGColor {
        return CreateOptional(r, g, b, alpha: alpha) ?? AxcBedrockColor.black.cgColor
    }

    /// 通过RGBA创建，内部会自动除以255 可选
    /// - Parameters:
    ///   - r: 红色值
    ///   - g: 绿色值
    ///   - b: 蓝色值
    ///   - a: 透明度值
    static func CreateOptional(_ r: AxcUnifiedNumber,
                               _ g: AxcUnifiedNumber,
                               _ b: AxcUnifiedNumber,
                               alpha: AxcUnifiedNumber = 1) -> CGColor? {
        let _255 = 255.axc.cgFloat
        let red = CGFloat.Axc.Create(r) / _255
        let green = CGFloat.Axc.Create(g) / _255
        let blue = CGFloat.Axc.Create(b) / _255
        let alpha = CGFloat.Axc.Create(alpha)
        if #available(iOS 13.0, *) {
            return CGColor(red: red,
                           green: green,
                           blue: blue,
                           alpha: alpha)
        } else if let cgcolor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(),
                                        components: [red, green, blue, alpha]) {
            return cgcolor
        } else {
            return nil
        }
    }

    // MARK: 随机色

    /// 获取一个随机色
    static var RandomUIColor: CGColor {
        return Create(CGFloat.Axc.Random(255),
                      CGFloat.Axc.Random(255),
                      CGFloat.Axc.Random(255))
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == CGColor {
    /// 设置自身颜色的透明度
    func alpha(_ alpha: AxcUnifiedNumber) -> CGColor {
        if base == AxcBedrockColor.black.cgColor {
            return base
        }
        let alpha = CGFloat.Axc.Create(alpha)
        return base.copy(alpha: alpha) ?? AxcBedrockColor.black.cgColor
    }
}
