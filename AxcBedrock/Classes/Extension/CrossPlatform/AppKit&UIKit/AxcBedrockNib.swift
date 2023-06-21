//
//  AxcBedrockNib.swift
//  Pods
//
//  Created by 赵新 on 2023/2/28.
//

#if os(macOS)
import AppKit

public typealias AxcBedrockNib = NSNib

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

public typealias AxcBedrockNib = UINib
#endif

// MARK: - 数据转换

public extension AxcSpace where Base: AxcBedrockNib { }

// MARK: - 类方法

public extension AxcSpace where Base: AxcBedrockNib {
    /// （💈跨平台标识）创建一个跨平台Nib
    /// - Parameters:
    ///   - nibName: 名称
    ///   - bundle: 资源包
    /// - Returns: Nib
    static func Create(nibName: String, bundle: Bundle?) -> AxcBedrockNib {
        #if os(macOS)
        let nib = NSNib(nibNamed: nibName, bundle: bundle)
        guard let nib else {
            #if DEBUG
            AxcBedrockLib.FatalLog("创建Nib失败！")
            #else
            return NSNib()
            #endif
        }
        return nib
        
        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return UINib(nibName: nibName, bundle: bundle)
        #endif
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AxcBedrockNib { }

// MARK: - 决策判断

public extension AxcSpace where Base: AxcBedrockNib { }
