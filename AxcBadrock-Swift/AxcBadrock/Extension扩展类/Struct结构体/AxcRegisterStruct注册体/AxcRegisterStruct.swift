//
//  AxcRegisterStruct.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/4.
//

import UIKit

/// 注册结构体
public struct AxcRegisterStruct {
    /// 注册位置
    public enum Style {
        case cell, header, footer
    }
    /// 类
    public var classType = UIView.self
    /// id
    public var identifier = ""
    /// 注册位置
    public var style: Style = .cell
    /// 是否使用nib加载
    public var useNib = false

    public init(_ classType: UIView.Type = UIView.self,
                identifier: String? = nil,
                style: Style = .cell,
                useNib: Bool = false) {
        self.classType = classType
        self.identifier = identifier ?? "\(classType)"
        self.style = style
        self.useNib = useNib
    }
}
