//
//  AxcUIEdgeInsetsEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/20.
//

import UIKit

// MARK: - 类方法/属性
public extension UIEdgeInsets {
    /// 统一实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    init(_ all: AxcUnifiedNumberTarget) {
        self.init(top: all.axc_cgFloat, left: all.axc_cgFloat,
                  bottom: all.axc_cgFloat, right: all.axc_cgFloat)
    }
    
    /// 设置水平和垂直边距
    /// - Parameters:
    ///   - horizontal: 水平左右间距
    ///   - verticality: 垂直上下间距
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    init(horizontal: AxcUnifiedNumberTarget, verticality: AxcUnifiedNumberTarget) {
        self.init(top: verticality.axc_cgFloat,
                  left: horizontal.axc_cgFloat,
                  bottom: verticality.axc_cgFloat,
                  right: horizontal.axc_cgFloat)
    }
    
    /// 无前缀实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    init(_ top: AxcUnifiedNumberTarget, _ left: AxcUnifiedNumberTarget,
         _ bottom: AxcUnifiedNumberTarget, _ right: AxcUnifiedNumberTarget) {
        self.init(top: top.axc_cgFloat, left: left.axc_cgFloat,
                  bottom: bottom.axc_cgFloat, right: right.axc_cgFloat)
    }
}

// MARK: - 属性 & Api
public extension UIEdgeInsets {
    /// 获取水平值
    var axc_horizontal: CGFloat {
        return left + right
    }
    /// 获取垂直值
    var axc_verticality: CGFloat {
        return top + bottom
    }
}

// MARK: - 链式语法
public extension UIEdgeInsets {
    /// 设置Top
    @discardableResult
    func axc_setTop(_ value: AxcUnifiedNumberTarget) -> Self { var edge = self
        edge.top = value.axc_cgFloat
        return edge
    }
    
    /// 设置Left
    @discardableResult
    func axc_setLeft(_ value: AxcUnifiedNumberTarget) -> Self {  var edge = self
        edge.left = value.axc_cgFloat
        return edge
    }
    
    /// 设置Bottom
    @discardableResult
    func axc_setBottom(_ value: AxcUnifiedNumberTarget) -> Self {  var edge = self
        edge.bottom = value.axc_cgFloat
        return edge
    }
    
    /// 设置Right
    @discardableResult
    func axc_setRight(_ value: AxcUnifiedNumberTarget) -> Self {  var edge = self
        edge.right = value.axc_cgFloat
        return edge
    }
    
    /// 设置垂直
    @discardableResult
    func axc_setVerticality(_ value: AxcUnifiedNumberTarget) -> Self {
        return self.axc_setTop(value).axc_setBottom(value)
    }
    /// 设置水平
    @discardableResult
    func axc_setHorizontal(_ value: AxcUnifiedNumberTarget) -> Self {
        return self.axc_setLeft(value).axc_setRight(value)
    }
}
