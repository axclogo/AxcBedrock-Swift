//
//  AxcBedrock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

#if os(macOS)
import AppKit

public typealias AxcBedrockScreen = NSScreen

#elseif os(iOS) || os(tvOS)

import UIKit

public typealias AxcBedrockScreen = UIScreen
#endif

// MARK: - 数据转换

public extension AxcSpace where Base: AxcBedrockScreen { }

// MARK: - 类方法

public extension AxcSpace where Base: AxcBedrockScreen { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: AxcBedrockScreen {
    /// （💈跨平台标识）屏幕缩放值
    var scale: CGFloat {
        #if os(iOS) || os(tvOS)
        return base.scale

        #elseif os(macOS)

        return base.backingScaleFactor
        #endif
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: AxcBedrockScreen { }
