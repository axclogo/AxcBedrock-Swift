//
//  AxcStringEx+AppKit.swift
//  Pods-AxcBedrock_Example
//
//  Created by 赵新 on 2023/2/21.
//

#if canImport(AppKit)

import AppKit

// MARK: - 数据转换

public extension AxcSpace where Base == String {
    /// 获取工程中Bundle图片 具有默认值
    func nsImage(bundle: Bundle = .main,
                 tintColor: AxcUnifiedColor? = nil) -> NSImage {
        return nsImage_optional(bundle: bundle,
                                tintColor: tintColor) ?? NSImage()
    }

    /// 获取工程中Bundle图片
    func nsImage_optional(bundle: Bundle = .main,
                          tintColor: AxcUnifiedColor? = nil) -> NSImage? {
        guard base.count != 0 else { return NSImage() }
        var image = NSImage.Axc.CreateOptional(base)
        if let tintColor = tintColor {
            image = image?.axc.set(tintUnifiedColor: tintColor)
        }
        return image
    }

    /// 转换NSUserInterfaceItemIdentifier
    var nsUserInterfaceItemIdentifier: NSUserInterfaceItemIdentifier {
        return .init(base)
    }
    
    /// 字体名大小转NSFont
    func nsFontSize(_ size: AxcUnifiedNumber) -> NSFont {
        let fontSize = CGFloat.Axc.Create(size)
        return NSFont(name: base, size: fontSize) ?? NSFont.systemFont(ofSize: fontSize)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == String { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == String { }

// MARK: - 决策判断

public extension AxcSpace where Base == String { }

#endif
