//
//  AxcBedrock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

#if os(macOS)
import AppKit

public typealias AxcBedrockEdgeInsets = NSEdgeInsets
#else
import UIKit

public typealias AxcBedrockEdgeInsets = UIEdgeInsets
#endif

// MARK: - [AxcBedrockEdgeInsetsSpace]

public struct AxcBedrockEdgeInsetsSpace {
    init(_ base: AxcBedrockEdgeInsets) {
        self.base = base
    }

    var base: AxcBedrockEdgeInsets
}

public extension AxcBedrockEdgeInsets {
    /// 命名空间
    var axc: AxcBedrockEdgeInsetsSpace {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcBedrockEdgeInsetsSpace.Type {
        return AxcBedrockEdgeInsetsSpace.self
    }
}

// MARK: - 数据转换

public extension AxcBedrockEdgeInsetsSpace { }

// MARK: - 类方法

public extension AxcBedrockEdgeInsetsSpace {
    /// （💈跨平台标识）无前缀实例化 AxcBedrockEdgeInsets
    @available(*, deprecated, renamed: "Create(top:left:bottom:right:)")
    static func Create(_ top: AxcUnifiedNumber,
                       _ left: AxcUnifiedNumber,
                       _ bottom: AxcUnifiedNumber,
                       _ right: AxcUnifiedNumber) -> AxcBedrockEdgeInsets {
        let top = CGFloat.Axc.Create(top)
        let left = CGFloat.Axc.Create(left)
        let bottom = CGFloat.Axc.Create(bottom)
        let right = CGFloat.Axc.Create(right)
        return AxcBedrockEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    /// （💈跨平台标识）实例化 AxcBedrockEdgeInsets
    static func Create(top: AxcUnifiedNumber,
                       left: AxcUnifiedNumber,
                       bottom: AxcUnifiedNumber,
                       right: AxcUnifiedNumber) -> AxcBedrockEdgeInsets {
        let top = CGFloat.Axc.Create(top)
        let left = CGFloat.Axc.Create(left)
        let bottom = CGFloat.Axc.Create(bottom)
        let right = CGFloat.Axc.Create(right)
        return AxcBedrockEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    /// （💈跨平台标识）统一实例化
    @available(*, deprecated, renamed: "Create(all:)")
    static func Create(_ all: AxcUnifiedNumber) -> AxcBedrockEdgeInsets {
        let all = CGFloat.Axc.Create(all)
        return AxcBedrockEdgeInsets(top: all, left: all, bottom: all, right: all)
    }

    /// （💈跨平台标识）统一实例化
    static func Create(all: AxcUnifiedNumber) -> AxcBedrockEdgeInsets {
        let all = CGFloat.Axc.Create(all)
        return AxcBedrockEdgeInsets(top: all, left: all, bottom: all, right: all)
    }

    /// （💈跨平台标识）水平垂直实例化 AxcBedrockEdgeInsets
    static func Create(horizontal: AxcUnifiedNumber,
                       vertical: AxcUnifiedNumber) -> AxcBedrockEdgeInsets {
        let top = CGFloat.Axc.Create(vertical)
        let left = CGFloat.Axc.Create(horizontal)
        let bottom = CGFloat.Axc.Create(vertical)
        let right = CGFloat.Axc.Create(horizontal)
        return AxcBedrockEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    /// （💈跨平台标识）水平实例化 AxcBedrockEdgeInsets
    static func Create(horizontal: AxcUnifiedNumber) -> AxcBedrockEdgeInsets {
        return Create(horizontal: horizontal, vertical: 0)
    }

    /// （💈跨平台标识）垂直实例化 AxcBedrockEdgeInsets
    static func Create(vertical: AxcUnifiedNumber) -> AxcBedrockEdgeInsets {
        return Create(horizontal: 0, vertical: vertical)
    }

    /// （💈跨平台标识）零
    static var Zero: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 属性 & Api

public extension AxcBedrockEdgeInsetsSpace {
    /// （💈跨平台标识）垂直值
    var vertical: CGFloat {
        return base.top + base.bottom
    }

    /// （💈跨平台标识）水平值
    var horizontal: CGFloat {
        return base.left + base.right
    }

    /// （💈跨平台标识）设置顶部
    func set(top: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.top = top
        return newEdge
    }

    /// （💈跨平台标识）设置左侧
    func set(left: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.left = left
        return newEdge
    }

    /// （💈跨平台标识）设置底部
    func set(bottom: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.bottom = bottom
        return newEdge
    }

    /// （💈跨平台标识）设置右侧
    func set(right: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.right = right
        return newEdge
    }

    /// （💈跨平台标识）设置垂直方向（上下）
    func set(vertical: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.top = vertical
        newEdge.bottom = vertical
        return newEdge
    }

    /// （💈跨平台标识）设置水平方向（左右）
    func set(horizontal: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.left = horizontal
        newEdge.right = horizontal
        return newEdge
    }

    /// （💈跨平台标识）边缘值相加
    /// - Parameter edge: 边缘
    /// - Returns: 结果
    func add(edge: AxcBedrockEdgeInsets) -> AxcBedrockEdgeInsets {
        return .init(top: base.top + edge.top,
                     left: base.left + edge.left,
                     bottom: base.bottom + edge.bottom,
                     right: base.right + edge.right)
    }

    /// （💈跨平台标识）设置垂直方向（上下）
    func add(vertical: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.top += vertical
        newEdge.bottom += vertical
        return newEdge
    }

    /// （💈跨平台标识）设置水平方向（左右）
    func add(horizontal: CGFloat) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.left += horizontal
        newEdge.right += horizontal
        return newEdge
    }

    /// （💈跨平台标识）设置水平方向（左右）
    func add(size: CGSize) -> AxcBedrockEdgeInsets {
        var newEdge = base
        newEdge.top += size.height
        newEdge.bottom += size.height
        newEdge.left += size.width
        newEdge.right += size.width
        return newEdge
    }

    /// （💈跨平台标识）一组边缘值相加
    /// - Parameter edges: 边缘组
    /// - Returns: 结果
    func add(edges: [AxcBedrockEdgeInsets]) -> AxcBedrockEdgeInsets {
        var resultEdge = base
        for edge in edges {
            resultEdge = resultEdge.axc.add(edge: edge)
        }
        return resultEdge
    }

    /// （💈跨平台标识）翻转
    /// - Parameter axis: 轴向
    /// - Returns: 结果
    func flip(axis: AxcAxis2D) -> AxcBedrockEdgeInsets {
        var edge = base
        switch axis {
        case .horizontal:
            edge.left = base.right
            edge.right = base.left
        case .vertical:
            edge.top = base.bottom
            edge.bottom = base.top
        }
        return edge
    }

    /// （💈跨平台标识）向内计算边距
    /// - Parameter rect: 框
    /// - Returns: 结果
    func inset(rect: CGRect) -> CGRect {
        #if os(macOS)
        if (base.top + base.bottom > rect.size.height) || (base.left + base.right > rect.size.width) {
            return .null
        }
        var insetRect = rect
        insetRect.origin.x += base.left
        insetRect.origin.y += base.top
        insetRect.size.height -= base.top + base.bottom
        insetRect.size.width -= base.left + base.right
        return insetRect

        #else

        return rect.inset(by: base)
        #endif
    }
}

// MARK: - 决策判断

public extension AxcBedrockEdgeInsetsSpace { }
