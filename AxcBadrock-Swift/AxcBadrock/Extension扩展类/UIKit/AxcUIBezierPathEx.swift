//
//  AxcUIBezierPathEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/9.
//

import UIKit

// MARK: - 数据转换
public extension UIBezierPath {
    /// 转换成CGPath
    var axc_cgPath: CGPath {
        return cgPath
    }
}

// MARK: - 类方法/属性
public extension UIBezierPath {
    /// 绘制两点的线
    /// - Parameters:
    ///   - from: 起点
    ///   - otherPoint: 终点
    ///   - isReversing: 是否反向（倒叙绘制）
    convenience init(from: CGPoint, to otherPoint: CGPoint,
                     isReversing: Bool = false) {
        self.init(groupPoint: [[from,otherPoint]],
                  isReversing: isReversing)
    }
    
    /// 绘制一组折线
    /// - Parameters:
    ///   - points: 折线点
    ///   - isReversing: 是否反向（倒叙绘制）
    ///   - isClose: 是否闭合
    convenience init(points: [CGPoint],
                     isReversing: Bool = false,
                     isClose: Bool = false) {
        self.init(groupPoint: [points],
                  isReversing: isReversing,
                  isClose: isClose)
    }
    
    /// 绘制一组折线
    /// - Parameters:
    ///   - groupPoint: 折线组集合
    ///   - isReversing: 是否每组反向（倒叙绘制）
    ///   - isClose: 是否每组是否闭合
    convenience init(groupPoint: [[CGPoint]],
                     isReversing: Bool = false,
                     isClose: Bool = false) {
        self.init()
        guard !groupPoint.axc_isEmpty else { return }
        for i_pointArr in groupPoint {
            if let firstPoint = i_pointArr.first { // 有第一个
                move(to: firstPoint)
                for point in i_pointArr[1...] {
                    addLine(to: point)
                }
            }
            if isReversing { reversing() } // 倒叙
            if isClose { close() }  // 闭合
        }
    }
    
    ///  绘制一个十字准星
    /// - Parameters:
    ///   - reticleCenter: 中心
    ///   - size: 大小默认1024
    convenience init(reticle: CGPoint,
                     size: CGSize = .axc_1024Size) {
        self.init(groupPoint: [[
            CGPoint(reticle.x - size.width/2, reticle.y),
            CGPoint(reticle.x + size.width/2, reticle.y)
        ],[
            CGPoint(reticle.x , reticle.y - size.height/2),
            CGPoint(reticle.x , reticle.y + size.height/2)
        ]])
    }
    
    /// 绘制出文字边框的路径
    /// - Parameter textPath: 文字路径
    convenience init(textPath: CGPath) {
        self.init(cgPath: textPath)
        apply(CGAffineTransform(scaleX: 1, y: -1))
        apply(CGAffineTransform(translationX: 0, y: textPath.boundingBox.height))
    }
}

// MARK: - 属性 & Api
public extension UIBezierPath {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 决策判断
public extension UIBezierPath {
    /// 是否为空
    var axc_isEmpty: Bool { return isEmpty }
}

// MARK: - 操作符
public extension UIBezierPath {
}

// MARK: - 运算符
public extension UIBezierPath {
    /// 贝塞尔曲线相加，拼接
    /// - Parameters:
    ///   - leftValue: UIBezierPath
    ///   - rightValue: UIBezierPath
    /// - Returns: UIBezierPath
    static func + (leftValue: UIBezierPath, rightValue: UIBezierPath) -> UIBezierPath {
        let bezierPath = leftValue
        bezierPath.append(rightValue)
        return bezierPath
    }
    
    /// 左边的贝塞尔曲线拼接
    /// - Parameters:
    ///   - leftValue: UIBezierPath
    ///   - rightValue: UIBezierPath
    static func += (leftValue: inout UIBezierPath, rightValue: UIBezierPath) {
        leftValue.append(rightValue)
    }
}
