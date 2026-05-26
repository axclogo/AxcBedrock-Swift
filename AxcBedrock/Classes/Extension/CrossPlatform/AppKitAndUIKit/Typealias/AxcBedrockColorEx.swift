//
//  AxcBedrock.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/2/11.
//

/// （💈跨平台标识）颜色类型
public typealias AxcBedrockColor = AxcBedrockLib.Color

#if os(macOS)
import AppKit

public extension AxcBedrockLib {
    typealias Color = NSColor
}

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

public extension AxcBedrockLib {
    typealias Color = UIColor
}
#endif

fileprivate extension AxcLazyCache.TableKey {
    /// （💈跨平台标识）颜色转换缓存表，启用缓存
    static let platformColorTable = AxcLazyCache.Table("platformColorTable", enableCache: true)
}

// MARK: - 数据转换

public extension AxcSpace where Base: AxcBedrockColor {
    /// 转换成颜色的十六进制大写字符串
    var hexString: String {
        let key = "\(base.hashValue)"
        let hexString: String = AxcLazyCache.MemoryCache(table: .platformColorTable,
                                                         key: key) {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            let multiplier = CGFloat(255.999999)
            guard !base.isEqual(AxcBedrockColor.clear) else { return "none" }
            #if os(macOS)
            base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

            #elseif os(iOS) || os(tvOS) || os(watchOS)

            let isSuccess = base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            guard isSuccess else { return "none" }
            #endif

            if alpha == 1.0 {
                return String(format: "#%02lX%02lX%02lX",
                              Int(red * multiplier),
                              Int(green * multiplier),
                              Int(blue * multiplier))
            } else {
                return String(format: "#%02lX%02lX%02lX%02lX",
                              Int(red * multiplier),
                              Int(green * multiplier),
                              Int(blue * multiplier),
                              Int(alpha * multiplier))
            }
        }
        return hexString
    }
}

// MARK: - 类方法

public extension AxcSpace where Base: AxcBedrockColor {
    // MARK: 配合协议用创建方法

    /// （💈跨平台标识）配合协议用创建方法-非可选
    static func Create(_ unifiedValue: AxcUnifiedColor?,
                       alpha: AxcUnifiedNumber = 1) -> AxcBedrockColor {
        return CreateOptional(unifiedValue, alpha: alpha) ?? .black
    }

    /// （💈跨平台标识）配合协议用创建方法
    /// - Parameters:
    ///   - unified:通用颜色类型
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(_ unifiedValue: AxcUnifiedColor?,
                               alpha: AxcUnifiedNumber = 1) -> AxcBedrockColor? {
        guard let unifiedValue = unifiedValue else { return nil }
        var _color: AxcBedrockColor?
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
            _color = AxcBedrockColor.Axc.Create(hexInt: hexInt)
        }

        if let string = unifiedValue as? String {
            _color = AxcBedrockColor.Axc.Create(hexStr: string)

        } else if let nsString = unifiedValue as? NSString {
            _color = AxcBedrockColor.Axc.Create(hexStr: nsString.axc.string)

        } else if let platformColor = unifiedValue as? AxcBedrockColor {
            _color = platformColor

        } else if let cgColor = AxcBedrockLib.Func.CFType(unifiedValue, as: CGColor.self) {
            _color = AxcBedrockColor(cgColor: cgColor)

        } else if let ciColor = unifiedValue as? CIColor {
            _color = AxcBedrockColor(ciColor: ciColor)
        }
        if alpha != 1 { // 优化透明度计算
            _color = _color?.axc.alpha(alpha)
        }
        return _color
    }

    // MARK: 灰色创建方法

    /// （💈跨平台标识）生成一个灰色 不会为空
    /// - Parameters:
    ///   - gray: 灰色度
    ///   - alpha: 阿尔法通道值
    static func Create(gray: CGFloat,
                       alpha: CGFloat = 1) -> AxcBedrockColor {
        return Create(red: gray, green: gray, blue: gray, alpha: alpha)
    }

    // MARK: HexString创建

    /// （💈跨平台标识）通过HexString创建 具有默认值
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 阿尔法通道值
    static func Create(hexStr: String,
                       alpha: CGFloat = 1) -> AxcBedrockColor {
        return CreateOptional(hexStr: hexStr, alpha: alpha) ?? AxcBedrockColor.black
    }

    /// （💈跨平台标识）通过HexString创建 可选
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 阿尔法通道值
    static func CreateOptional(hexStr: String,
                               alpha: CGFloat = 1) -> AxcBedrockColor? {
        var formatted = hexStr.trimmingCharacters(in: .whitespacesAndNewlines)
        if formatted.hasPrefix("#") {
            formatted.removeFirst()
        }
        if formatted.lowercased().hasPrefix("0x") {
            formatted.removeFirst(2)
        }

        if formatted.count == 3 || formatted.count == 4 {
            formatted = formatted.map { "\($0)\($0)" }.joined()
        }

        guard formatted.count == 6 || formatted.count == 8,
              let hex = UInt64(formatted, radix: 16) else { return nil }

        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let finalAlpha: CGFloat
        if formatted.count == 8 {
            red = CGFloat((hex & 0xFF000000) >> 24)
            green = CGFloat((hex & 0x00FF0000) >> 16)
            blue = CGFloat((hex & 0x0000FF00) >> 8)
            finalAlpha = CGFloat(hex & 0x000000FF) / 255.0
        } else {
            red = CGFloat((hex & 0xFF0000) >> 16)
            green = CGFloat((hex & 0x00FF00) >> 8)
            blue = CGFloat(hex & 0x0000FF)
            finalAlpha = alpha
        }
        return AxcBedrockColor.Axc.Create(red: red, green: green, blue: blue, alpha: finalAlpha)
    }

    // MARK: hexInt创建

    /// （💈跨平台标识）通过HexInt创建 不会为空
    /// - Parameters:
    ///   - hexInt: 十六进制长整型
    ///   - alpha: 阿尔法通道值
    static func Create(hexInt: Int,
                       alpha: CGFloat = 1) -> AxcBedrockColor {
        let color = Create(red: CGFloat((hexInt & 0xFF0000) >> 16),
                           green: CGFloat((hexInt & 0xFF00) >> 8),
                           blue: CGFloat((hexInt & 0xFF)), alpha: alpha)
        return color
    }

    // MARK: RGBA创建

    /// （💈跨平台标识）通过RGBA创建，内部会自动除以255 不会为空
    /// - Parameters:
    ///   - r: 红色值
    ///   - g: 绿色值
    ///   - b: 蓝色值
    ///   - a: 透明度值
    static func Create(red: AxcUnifiedNumber,
                       green: AxcUnifiedNumber,
                       blue: AxcUnifiedNumber,
                       alpha: AxcUnifiedNumber = 1) -> AxcBedrockColor {
        let _255 = 255.axc.cgFloat
        let red = CGFloat.Axc.Create(red) / _255
        let green = CGFloat.Axc.Create(green) / _255
        let blue = CGFloat.Axc.Create(blue) / _255
        let alpha = CGFloat.Axc.Create(alpha)
        #if os(macOS)
        return NSColor(srgbRed: red,
                       green: green,
                       blue: blue,
                       alpha: alpha)

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return UIColor(red: red,
                       green: green,
                       blue: blue,
                       alpha: alpha)
        #endif
    }

    // MARK: 随机色

    /// （💈跨平台标识）获取一个随机色
    static var RandomUIColor: AxcBedrockColor {
        return Create(red: CGFloat.Axc.Random(255),
                      green: CGFloat.Axc.Random(255),
                      blue: CGFloat.Axc.Random(255))
    }

    // MARK: 主题色

    /// （💈跨平台标识）创建一个Color，在明暗模式下使用不同的颜色
    /// 无了大语，这个都没统一命名
    /// - Parameters:
    ///   - light: 明亮模式下颜色
    ///   - dark: 暗黑模式下颜色
    @available(iOS 13.0, OSX 10.15, *)
    static func Create(light: AxcUnifiedColor,
                       dark: AxcUnifiedColor) -> AxcBedrockColor {
        #if os(macOS)
        return NSColor(name: nil, dynamicProvider: { appearance in
            switch appearance.name {
            case .darkAqua: return AssertTransformColor(dark)
            default: return AssertTransformColor(light)
            }
        })

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return UIColor(dynamicProvider: { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark: return AssertTransformColor(dark)
            default: return AssertTransformColor(light)
            }
        })
        #endif
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AxcBedrockColor {
    /// （💈跨平台标识）设置自身颜色的透明度
    func alpha(_ alpha: AxcUnifiedNumber) -> AxcBedrockColor {
        if base == .clear {
            return base
        }
        return base.withAlphaComponent(CGFloat.Axc.Create(alpha))
    }

    /// （💈跨平台标识）获取该颜色的反色
    var inverseColor: AxcBedrockColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        base.getRed(&r, green: &g, blue: &b, alpha: nil)
        #if os(macOS)
        return NSColor(red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b, alpha: 1)
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        return UIColor(red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b, alpha: 1)
        #endif
    }
}

// MARK: - 获取

public extension AxcSpace where Base: AxcBedrockColor {
    // MARK: R

    /// （💈跨平台标识）获取红色值CGFloat
    var red_cgFloat: CGFloat {
        var r: CGFloat = 0
        base.getRed(&r, green: nil, blue: nil, alpha: nil)
        return r
    }

    /// （💈跨平台标识）获取红色值Int
    var red_int: Int {
        return Int(red_cgFloat * 255)
    }

    // MARK: G

    /// （💈跨平台标识）获取绿色值CGFloat
    var green_cgFloat: CGFloat {
        var g: CGFloat = 0
        base.getRed(nil, green: &g, blue: nil, alpha: nil)
        return g
    }

    /// （💈跨平台标识）获取绿色值Int
    var green_int: Int {
        return Int(green_cgFloat * 255)
    }

    // MARK: B

    /// （💈跨平台标识）获取蓝色值CGFloat
    var blue_cgFloat: CGFloat {
        var b: CGFloat = 0
        base.getRed(nil, green: nil, blue: &b, alpha: nil)
        return b
    }

    /// （💈跨平台标识）获取蓝色值Int
    var blue_int: Int {
        return Int(blue_cgFloat * 255)
    }

    // MARK: A

    /// （💈跨平台标识）获取透明值Int
    var alpha_cgFloat: CGFloat {
        var a: CGFloat = 0
        base.getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: AxcBedrockColor {
    /// （💈跨平台标识）是否浅色、淡色
    var isLight: Bool {
        let redValue = Float(red_cgFloat) * 0.299
        let greenValue = Float(green_cgFloat) * 0.578
        let blueValue = Float(blue_cgFloat) * 0.114
        return (redValue + greenValue + blueValue) >= 192
    }
}
