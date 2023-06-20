//
//  AxcCGSizeEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/11.
//

import UIKit

// MARK: - 数据转换
public extension CGSize {
    
    // MARK: 扩展
    /// 转换成元组 (width,height)
    var axc_tuples: (CGFloat,CGFloat) {
        return (width,height)
    }
    
    /// 转换成CGRect
    var axc_cgRect: CGRect {
        return CGRect(origin: .zero, size: self)
    }
}

// MARK: - 类方法/属性
extension CGSize: AxcInitializeZero {
    // MARK: 协议
    /// 直接获取0，0
    public static var axc_zero: CGSize {
        return CGSize.zero
    }
    /// 直接获取1，1
    public static var axc_one: CGSize {
        return 1.axc_cgSize
    }
    
    // MARK: 扩展
    /// 无前缀实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ width: AxcUnifiedNumberTarget, _ height: AxcUnifiedNumberTarget){
        var size = CGSize.zero
        size.width = width.axc_cgFloat
        size.height = height.axc_cgFloat
        self = size
    }
    /// 统一实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ all: AxcUnifiedNumberTarget){
        self = CGSize(width: all.axc_cgFloat, height: all.axc_cgFloat)
    }
    
    /// 通过元组实例化
    @available(*, deprecated, message: "AxcLogo：此api已经废弃，请使用系统实例化")
    public init(_ tuples: (AxcUnifiedNumberTarget,AxcUnifiedNumberTarget)){
        self = CGSize(width: tuples.0.axc_cgFloat, height: tuples.1.axc_cgFloat)
    }
    
    /// 直接获取CGFloat.axc_min,CGFloat.axc_min
    public static var axc_minSize: CGSize {
        return CGSize(width: CGFloat.axc_min, height: CGFloat.axc_min)
    }
    /// 直接获取256,256
    public static var axc_byteMaxSize: CGSize {
        return CGSize(width: Axc_ByteMax, height: Axc_ByteMax)
    }
    /// 直接获取1024，1024
    public static var axc_1024Size: CGSize {
        return CGSize(width: 1024, height: 1024)
    }
}

// MARK: - 属性 & Api
public extension CGSize {
    /// 返回宽高比
    var axc_widthHeightRatio: CGFloat {
        guard height != 0 else { return 0 }
        return width / height
    }
    /// 返回高宽比
    var axc_heightWidthRatio: CGFloat {
        guard width != 0 else { return 0 }
        return height / width
    }
    /// 获取宽高中一个最大的
    var axc_bigger: CGFloat {
        return max(width, height)
    }
    /// 获取宽高中一个最小的
    var axc_smaller: CGFloat {
        return min(width, height)
    }
    /// 按比例缩放
    func axc_scale(_ scale: CGFloat) -> CGSize {
        return CGSize(width: width * scale, height: height * scale)
    }
}

// MARK: - 填充计算
public extension CGSize {
    /// 适应性填充 - 将自己本身Size适应到一个框后，实际需要的大小
    ///
    ///     let size = CGSize(width: 120, height: 80)
    ///     let parentSize  = CGSize(width: 100, height: 50)
    ///     let newSize = size.axc_aspectFit(to: parentSize)
    ///     // newSize.width = 75 , newSize.height = 50
    ///
    /// - Parameter boundingSize: 框大小
    /// - Returns: 自适应到给定的边界尺寸
    func axc_aspectFit(to frameSize: CGSize) -> CGSize {
        let minRatio = min(frameSize.width / width, frameSize.height / height)
        return CGSize(width: width * minRatio, height: height * minRatio)
    }
    
    /// 全填充 - 将自己本身Size适应到一个框后，实际填充需要的大小
    ///
    ///     let size = CGSize(width: 20, height: 120)
    ///     let parentSize  = CGSize(width: 100, height: 60)
    ///     let newSize = size.aspectFit(to: parentSize)
    ///     // newSize.width = 100 , newSize.height = 60
    ///
    /// - Parameter boundingSize: 框大小
    /// - Returns: 自适应到给定的边界尺寸
    func axc_aspectFill(to frameSize: CGSize) -> CGSize {
        let minRatio = max(frameSize.width / width, frameSize.height / height)
        let aWidth = min(width * minRatio, frameSize.width)
        let aHeight = min(height * minRatio, frameSize.height)
        return CGSize(width: aWidth, height: aHeight)
    }
}

// MARK: - 决策判断
extension CGSize: AxcDecisionIsZero {
    /// 是否都为0
    public var axc_isZero: Bool { return self == CGSize.axc_zero }
}

// MARK: - 运算符
public extension CGSize {
    /// 两个CGSize相加
    /// - Parameters:
    ///   - leftValue: CGSize
    ///   - rightValue: CGSize
    /// - Returns: 相加后的Size
    static func + (leftValue: CGSize, rightValue: CGSize) -> CGSize {
        return CGSize(width: leftValue.width + rightValue.width,
                      height: leftValue.height + rightValue.height)
    }
    /// 两个CGSize相加
    /// - Parameters:
    ///   - leftValue: CGSize
    ///   - rightValue: CGSize
    static func += (leftValue: inout CGSize, rightValue: CGSize) {
        leftValue = leftValue + rightValue
    }
    
    /// 使用元组相加
    /// - Parameters:
    ///   - leftValue: CGSize
    ///   - rightValue: tuple value.
    /// - Returns: 相加后的Size
    static func + (leftValue: CGSize, rightValue: (width: CGFloat, height: CGFloat)) -> CGSize {
        return CGSize(width: leftValue.width + rightValue.width,
                      height: leftValue.height + rightValue.height)
    }
    /// 使用元组相加
    /// - Parameters:
    ///   - leftValue: CGSize
    ///   - rightValue: tuple value.
    static func += (leftValue: inout CGSize, rightValue: (width: CGFloat, height: CGFloat)) {
        leftValue = leftValue + rightValue
    }
    
    /// 两个CGSize相减
    /// - Parameters:
    ///   - leftValue: CGSize
    ///   - rightValue: CGSize
    /// - Returns: 相减后的Size
    static func - (leftValue: CGSize, rightValue: CGSize) -> CGSize {
        return CGSize(width: leftValue.width - rightValue.width,
                      height: leftValue.height - rightValue.height)
    }
    
    /// 使用元组相减
    /// - Parameters:
    ///   - leftValue: CGSize
    ///   - rightValue: tuple value.
    /// - Returns: 相加后的Size
    static func - (leftValue: CGSize, rightValue: (width: CGFloat, height: CGFloat)) -> CGSize {
        return CGSize(width: leftValue.width - rightValue.width,
                      height: leftValue.height - rightValue.height)
    }
    
    /// 点点两个左边都乘以多少
    /// - Parameters:
    ///   - leftValue: CGSize
    ///   - rightValue: 倍数、标量
    /// - Returns: 计算后的CGSize
    static func * (leftValue: CGSize, rightValue: CGFloat) -> CGSize {
        return CGSize(width: leftValue.width * rightValue,
                      height: leftValue.height * rightValue)
    }
    
    /// 点点两个右边都乘以多少
    /// - Parameters:
    ///   - leftValue: 倍数、标量
    ///   - rightValue: CGSize
    /// - Returns: 计算后的CGSize
    static func * (leftValue: CGFloat, rightValue: CGSize) -> CGSize {
        return CGSize(width: rightValue.width * leftValue,
                      height: rightValue.height * leftValue)
    }
}
