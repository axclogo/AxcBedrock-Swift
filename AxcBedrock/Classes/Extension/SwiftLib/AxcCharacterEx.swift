//
//  AxcCharacterEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation
import CoreGraphics

// MARK: - Character + AxcSpaceProtocol

extension Character: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == Character {
    /// 转小写
    var lowercased: Character {
        if let lowercased = base.axc.string.lowercased().first {
            return lowercased
        } else {
            let log = "转换小写失败！Character:\(base)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return base
            #endif
        }
    }

    /// 转大写
    var uppercased: Character {
        if let uppercased = base.axc.string.uppercased().first {
            return uppercased
        } else {
            let log = "转换大写失败！Character:\(base)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return base
            #endif
        }
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == Character {
    /// 最大的ASCII码对应的字符
    static var Max: Character {
        return Character(UnicodeScalar(127)!)
    }

    /// 最小的ASCII码对应的字符
    static var Min: Character {
        return Character(UnicodeScalar(0)!)
    }

    /// 获取一个随机的字符
    static func RandomCharacter() -> Character {
        return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == Character {
    /// 判断是否是Emoji
    @available(iOS 10.2, *)
    @available(iOSApplicationExtension 10.2, *)
    func isEmoji() -> Bool {
        for scalar in base.unicodeScalars {
            if scalar.properties.isEmoji {
                return true
            }
        }
        return false
    }
}
