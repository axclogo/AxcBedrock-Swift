//
//  AxcCIColorEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

import CoreImage

fileprivate extension AxcLazyCache.TableKey {
    /// 颜色转换缓存表，启用缓存
    static let ciColorTable = AxcLazyCache.Table("ciColor_table", enableCache: true)
}

// MARK: - 数据转换

public extension AxcSpace where Base: CIColor { }

// MARK: - 类方法

public extension AxcSpace where Base: CIColor {
    // MARK: 配合协议用创建方法

    /// 配合协议用创建方法 具有默认值
    static func Create(_ unifiedValue: AxcUnifiedColor?,
                       alpha: AxcUnifiedNumber = 1) -> CIColor {
        return CreateOptional(unifiedValue, alpha: alpha) ?? .black
    }

    /// 配合协议用创建方法 可选
    /// - Parameters:
    ///   - unifiedValue: 通用颜色类型
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(_ unifiedValue: AxcUnifiedColor?,
                               alpha: AxcUnifiedNumber = 1) -> CIColor? {
        guard let unifiedValue = unifiedValue else { return nil }
        var _color: CIColor?
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
            _color = CIColor.Axc.Create(hexInt: hexInt)
        }
        if let string = unifiedValue as? String {
            _color = CIColor.Axc.Create(hexStr: string)

        } else if let nsString = unifiedValue as? NSString {
            _color = CIColor.Axc.Create(hexStr: nsString.axc.string)

        } else if let platformColor = unifiedValue as? AxcBedrockColor {
            #if os(macOS)
            _color = CIColor(color: platformColor)
            #elseif os(iOS)
            _color = platformColor.ciColor
            #endif

        } else if let cgColor = AxcBedrockLib.Func.CFType(unifiedValue, as: CGColor.self) {
            _color = CIColor(cgColor: cgColor)

        } else if let ciColor = unifiedValue as? CIColor {
            _color = ciColor
        }
        if alpha != 1 { // 优化透明度计算
            _color = _color?.axc.copy(alpha: alpha)
        }
        return _color
    }

    // MARK: 灰色创建方法

    /// 生成一个灰色 不会为空
    /// - Parameters:
    ///   - gray: 灰色度
    ///   - alpha: 阿尔法通道值
    static func Create(gray: CGFloat,
                       alpha: CGFloat = 1) -> CIColor {
        return Create(gray, gray, gray, alpha: alpha)
    }

    // MARK: HexString创建

    /// 通过HexString创建 具有默认值
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 阿尔法通道值
    static func Create(hexStr: String,
                       alpha: CGFloat = 1) -> CIColor {
        return CreateOptional(hexStr: hexStr, alpha: alpha) ?? CIColor.black
    }

    /// 通过HexString创建 可选
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(hexStr: String,
                               alpha: CGFloat = 1) -> CIColor? {
        var formatted = hexStr.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        guard let hex = Int(formatted, radix: 16) else { return nil }
        let red = CGFloat((hex & 0xFF0000) >> 16)
        let green = CGFloat((hex & 0xFF00) >> 8)
        let blue = CGFloat((hex & 0xFF) >> 0)
        return CIColor.Axc.Create(red, green, blue, alpha: alpha)
    }

    // MARK: HexInt创建

    /// 通过HexInt创建
    /// - Parameters:
    ///   - hexInt: 十六进制长整型
    ///   - alpha: 阿尔法通道值
    static func Create(hexInt: Int,
                       alpha: CGFloat = 1) -> CIColor {
        let color = Create(CGFloat((hexInt & 0xFF0000) >> 16),
                           CGFloat((hexInt & 0xFF00) >> 8),
                           CGFloat((hexInt & 0xFF)), alpha: alpha)
        return color
    }

    // MARK: RGBA创建

    /// 通过RGBA创建，内部会自动除以255 不会为空
    /// - Parameters:
    ///   - r: 红色值
    ///   - g: 绿色值
    ///   - b: 蓝色值
    ///   - a: 透明度值
    static func Create(_ r: AxcUnifiedNumber,
                       _ g: AxcUnifiedNumber,
                       _ b: AxcUnifiedNumber,
                       alpha: AxcUnifiedNumber = 1) -> CIColor {
        let _255 = 255.axc.cgFloat
        let red = CGFloat.Axc.Create(r) / _255
        let green = CGFloat.Axc.Create(g) / _255
        let blue = CGFloat.Axc.Create(b) / _255
        let alpha = CGFloat.Axc.Create(alpha)
        return CIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    // MARK: 随机色

    /// 获取一个随机色
    static var RandomCIColor: CIColor {
        return Create(CGFloat.Axc.Random(255),
                      CGFloat.Axc.Random(255),
                      CGFloat.Axc.Random(255))
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CIColor {
    /// 复制一个颜色
    /// - Parameter alpha: 阿尔法通道值
    /// - Returns: 复制的颜色
    func copy(alpha: AxcUnifiedNumber) -> CIColor {
        return CIColor.Axc.Create(base.red,
                                 base.green,
                                 base.blue,
                                 alpha: alpha)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CIColor { }
