//
//  AxcUIControlStateEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/11/22.
//

#if canImport(UIKit)

import UIKit

// MARK: - 扩展UIControl.State + AxcSpaceProtocol

extension UIControl.State: AxcSpaceProtocol {}

// MARK: - 数据转换

public extension AxcSpace where Base== UIControl.State {}

// MARK: - 类方法

public extension AxcSpace where Base== UIControl.State {}

// MARK: - 属性 & Api

public extension AxcSpace where Base == UIControl.State {
    /// 唯一值
    var identifier: String? {
        switch base {
        case .normal: return "normal"
        case .highlighted: return "highlighted"
        case .disabled: return "disabled"
        case .selected: return "selected"
        case .focused: return "focused"
        case .application: return "application"
        case .reserved: return "reserved"
        default: return nil
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base== UIControl.State {}

#endif
