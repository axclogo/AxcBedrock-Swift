//
//  AxcStringEx+UIKit.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/13.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base == String {
    /// 获取工程中Bundle图片 具有默认值
    func uiImage(bundle: Bundle = .main,
                 tintColor: AxcUnifiedColor? = nil) -> UIImage {
        return uiImage_optional(bundle: bundle,
                                tintColor: tintColor) ?? UIImage()
    }

    /// 获取工程中Bundle图片 可选值
    func uiImage_optional(bundle: Bundle = .main,
                          tintColor: AxcUnifiedColor? = nil) -> UIImage? {
        guard base.count != 0 else { return UIImage() }
        var image = UIImage(named: base, in: bundle, compatibleWith: nil)
        if let tintColor = tintColor {
            image = image?.axc.set(tintUnifiedColor: tintColor)
        }
        return image
    }

    /// 字体名大小转UIFont
    func uiFont(size: AxcUnifiedNumber) -> UIFont {
        let fontSize = CGFloat.Axc.Create(size)
        return UIFont(name: base, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == String { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == String { }

// MARK: - 决策判断

public extension AxcSpace where Base == String {
    /// 判断拼写是否正确
    /// 语言为系统第一语言
    var isSpelledCorrectly: Bool {
        let checker = UITextChecker()
        let range = NSRange(base.startIndex ..< base.endIndex, in: base)
        let misspelledRange = checker.rangeOfMisspelledWord(in: base,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: Locale.preferredLanguages.first ?? "en")
        return misspelledRange.location == NSNotFound
    }
}

#endif
