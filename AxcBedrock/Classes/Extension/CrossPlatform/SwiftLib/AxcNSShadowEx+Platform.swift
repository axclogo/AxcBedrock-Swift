//
//  AxcNSShadowEx+Platform.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

// MARK: - 数据转换

public extension AxcSpace where Base: NSShadow { }

// MARK: - 类方法

public extension AxcSpace where Base: NSShadow {
    /// 生成文本附件
    static func CreateShadow(_ makeBlock: AxcBlock.Maker<AxcMaker.Shadow>)
        -> NSShadow {
        return .init().axc.makeShadow(makeBlock)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: NSShadow {
    /// 设置文本附件属性
    func makeShadow(_ makeBlock: AxcBlock.Maker<AxcMaker.Shadow>)
        -> NSShadow {
        let handle: AxcMaker.Shadow = .init(shadow: base)
        makeBlock(handle)
        return handle.shadow
    }
}
