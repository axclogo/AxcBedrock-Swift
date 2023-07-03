//
//  AxcCGSizeEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import CoreGraphics

// MARK: - CGSize + AxcSpaceProtocol

extension CGSize: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CGSize {
    /// 转换成CGRect
    var cgRect: CGRect {
        return CGRect(origin: .zero, size: base)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == CGSize {
    /// 无前缀实例化
    static func Create(_ width: AxcUnifiedNumber,
                       _ height: AxcUnifiedNumber) -> CGSize {
        var size = CGSize.zero
        size.width = CGFloat.Axc.Create(width)
        size.height = CGFloat.Axc.Create(height)
        return size
    }

    /// 统一实例化
    static func Create(_ all: AxcUnifiedNumber) -> CGSize {
        let all = CGFloat.Axc.Create(all)
        return CGSize(width: all, height: all)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == CGSize {
    /// 相加
    /// - Parameter size: 大小
    /// - Returns: 结果
    func add(size: CGSize) -> CGSize {
        var newSize: CGSize = base
        newSize.width += size.width
        newSize.height += size.height
        return newSize
    }

    /// 相加
    /// - Parameter size: 大小
    /// - Returns: 结果
    func add(edge: AxcBedrockEdgeInsets) -> CGSize {
        var newSize: CGSize = base
        newSize.width += edge.axc.horizontal
        newSize.height += edge.axc.vertical
        return newSize
    }

    /// 相减
    /// - Parameter size: 大小
    /// - Returns: 结果
    func subtract(size: CGSize) -> CGSize {
        var newSize: CGSize = base
        newSize.width -= size.width
        newSize.height -= size.height
        return newSize
    }

    /// 相减
    /// - Parameter size: 大小
    /// - Returns: 结果
    func subtract(edge: AxcBedrockEdgeInsets) -> CGSize {
        var newSize: CGSize = base
        newSize.width -= edge.axc.horizontal
        newSize.height -= edge.axc.vertical
        return newSize
    }

    /// 获取宽高中一个最大的
    var bigger: CGFloat {
        return Swift.max(base.width, base.height)
    }

    /// 获取宽高中一个最小的
    var smaller: CGFloat {
        return Swift.min(base.width, base.height)
    }

    /// 向上取整
    var ceilUp: CGSize {
        return CGSize(width: Darwin.ceil(base.width),
                      height: Darwin.ceil(base.height))
    }

    /// 向下取整
    var floorDown: CGSize {
        return CGSize(width: Darwin.floor(base.width),
                      height: Darwin.floor(base.height))
    }

    /// 缩放
    /// - Parameter scale: 缩放比例
    /// - Returns: 结果
    func scale(_ scale: CGFloat) -> CGSize {
        let sW = base.width * scale
        let sH = base.height * scale
        return CGSize(width: sW, height: sH)
    }

    /// 等比填充
    /// - Parameter boundingSize: 框大小
    /// - Returns: 结果
    func aspectFit(_ boundingSize: CGSize) -> CGSize {
        let aspectRatio = base
        var size = boundingSize
        let widthRatio = boundingSize.width / aspectRatio.width
        let heightRatio = boundingSize.height / aspectRatio.height
        if widthRatio < heightRatio {
            size.height = boundingSize.width / aspectRatio.width * aspectRatio.height
        } else if (heightRatio < widthRatio) {
            size.width = boundingSize.height / aspectRatio.height * aspectRatio.width
        }
        return size
    }

    /// 拉伸填充
    /// - Parameter boundingSize: 最小大小
    /// - Returns: 结果
    func aspectFill(_ minimumSize: CGSize) -> CGSize {
        let aspectRatio = base
        var size = minimumSize
        let widthRatio = minimumSize.width / aspectRatio.width
        let heightRatio = minimumSize.height / aspectRatio.height
        if widthRatio > heightRatio {
            size.height = minimumSize.width / aspectRatio.width * aspectRatio.height
        } else if heightRatio > widthRatio {
            size.width = minimumSize.height / aspectRatio.height * aspectRatio.width
        }
        return size
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == CGSize { }
