//
//  AxcNSAttributedStringEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/25.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: NSAttributedString { }

// MARK: - 类方法

public extension AxcSpace where Base: NSAttributedString {
    /// 配合协议用创建方法
    static func Create(_ unifiedValue: AxcUnifiedString?) -> Base {
        return CreateOptional(unifiedValue) ?? .init()
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedString?) -> Base? {
        guard let unifiedValue = unifiedValue else { return nil }
        let str = AssertTransformString(unifiedValue)
        return .init(string: str)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSAttributedString {
    /// 为这段富文本新增一种属性
    @discardableResult
    func applying(_ attributes: [NSAttributedString.Key: Any],
                  range: AxcUnifiedRange? = nil) -> NSAttributedString {
        guard !base.string.isEmpty else { return base }
        let copy = mutableAttributedString()
        var attRange = NSRange(0 ..< base.length)
        if let r = range,
           let nsRange = NSRange.Axc.CreateOptional(r) {
            attRange = nsRange
        }
        if attRange.upperBound > base.length { // 超出长度
            let log = "所设置的Range超出字符串长度上限！\nRange:\(attRange)\nLength:\(base.length)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            let newLength = base.length - attRange.location
            attRange = .init(location: attRange.location, length: newLength)
            #endif
        }
        copy.addAttributes(attributes, range: attRange)
        return copy
    }

    /// 为这段富文本移除多种属性
    @discardableResult
    func remove(attributeKeyRanges: [NSAttributedString.Key: AxcUnifiedRange?]) -> NSAttributedString {
        guard !base.string.isEmpty else { return base }
        let copy = mutableAttributedString()
        attributeKeyRanges.forEach { arrKey, range in
            var attRange = NSRange(0 ..< base.length)
            if let range,
               let nsRange = NSRange.Axc.CreateOptional(range) {
                attRange = nsRange
            }
            if attRange.upperBound > base.length { // 超出长度
                let log = "所设置的Range超出字符串长度上限！\nRange:\(attRange)\nLength:\(base.length)"
                AxcBedrockLib.Log(log)
                #if DEBUG
                AxcBedrockLib.FatalLog(log)
                #else
                let newLength = base.length - attRange.location
                attRange = .init(location: attRange.location, length: newLength)
                #endif
            }
            copy.removeAttribute(arrKey, range: attRange)
        }
        return copy
    }

    /// 为这段富文本移除单个属性
    @discardableResult
    func remove(attributeKey: NSAttributedString.Key,
                range: AxcUnifiedRange? = nil) -> NSAttributedString {
        guard !base.string.isEmpty else { return base }
        let copy = mutableAttributedString()
        var attRange = NSRange(0 ..< base.length)
        if let range,
           let nsRange = NSRange.Axc.CreateOptional(range) {
            attRange = nsRange
        }
        if attRange.upperBound > base.length { // 超出长度
            let log = "所设置的Range超出字符串长度上限！\nRange:\(attRange)\nLength:\(base.length)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            let newLength = base.length - attRange.location
            attRange = .init(location: attRange.location, length: newLength)
            #endif
        }
        copy.removeAttribute(attributeKey, range: attRange)
        return copy
    }

    /// 拷贝可变
    func mutableAttributedString() -> NSMutableAttributedString {
        var copy = NSMutableAttributedString()
        if let mutable = base as? NSMutableAttributedString {
            copy = mutable
        } else {
            copy = NSMutableAttributedString(attributedString: base)
        }
        return copy
    }

    /// 获取富文本全部属性
    func attributes(_ range: AxcUnifiedRange? = nil) -> [NSAttributedString.Key: Any] {
        guard string.count > 0 else { return [:] }
        if var nsRange = NSRange.Axc.CreateOptional(range) {
            return base.attributes(at: 0, effectiveRange: &nsRange)
        } else {
            return base.attributes(at: 0, effectiveRange: nil)
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: NSAttributedString { }

// MARK: - 运算符

public extension AxcSpace where Base: NSMutableAttributedString {
    /// 设置、获取属性
    subscript(_ key: NSAttributedString.Key, range: AxcUnifiedRange? = nil) -> Any? {
        set {
            guard let value = newValue else { return }
            applying([key: value], range: range)
        }
        get { return attributes(range)[key] }
    }
}
