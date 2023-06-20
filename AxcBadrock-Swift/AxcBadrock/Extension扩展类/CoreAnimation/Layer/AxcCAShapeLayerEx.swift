//
//  AxcCAShapeLayerEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/9.
//

import UIKit

// MARK: - 数据转换
public extension CAShapeLayer {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 类方法/属性
public extension CAShapeLayer {
    /// 快速贝塞尔实例化
    /// - Parameter path: 路径
    convenience init(_ frame: CGRect? = nil, path: UIBezierPath) {
        self.init(frame, cgPath: path.cgPath)
    }
    /// 快速CGPath实例化
    /// - Parameter CGPath: 路径
    convenience init(_ frame: CGRect? = nil, cgPath: CGPath) {
        self.init()
        self.frame = frame ?? .zero
        path = cgPath
        axc_setPathLayer()
    }
}

// MARK: - 属性 & Api
public extension CAShapeLayer {
    /// 快速设置路径图层
    /// - Parameters:
    ///   - strokeColor: 线色
    ///   - fillColor: 填充色
    ///   - lineWidth: 线宽
    ///   - lineJoin: 线折角处理
    ///   - bounds: bounds
    ///   - isGeometryFlipped: 翻转坐标
    func axc_setPathLayer(strokeColor: AxcUnifiedColorTarget = UIColor.black,
                          fillColor: AxcUnifiedColorTarget? = nil,
                          lineWidth: CGFloat = 1,
                          lineJoin: CAShapeLayerLineJoin = .bevel,
                          isGeometryFlipped: Bool = false) {
        self.strokeColor = strokeColor.axc_cgColor
        self.fillColor = fillColor?.axc_cgColor
        self.lineWidth = lineWidth
        self.lineJoin = lineJoin
        self.isGeometryFlipped = isGeometryFlipped
    }
    
    /// 绘制动画
    /// - Parameters:
    ///   - ratio: 绘制比率，默认1
    ///   - duration: 绘制时间，默认 Axc_Duration
    ///   - timingFunction: 时间函数曲线
    ///   - completion: 结束回调
    /// - Returns: 动画对象
    func axc_drawAnimation(_ ratio: CGFloat = 1,
                           duration: TimeInterval? = nil,
                           timingFunction: CAMediaTimingFunctionName = .linear,
                           completion: CAAnimation.AxcBoolBlock<Void>? = nil) -> CAAnimation {
        let animation = CABasicAnimation(.strokeEnd).axc_setDuration(duration)
            .axc_setFromValue(0).axc_setToValue(ratio)
            .axc_setTimingFunction(timingFunction)
        axc_addAnimation(animation, completeBlock: completion)
        return animation
    }
    
    /// 设置路径
    var axc_path: UIBezierPath? {
        set { if let cgPath = newValue?.cgPath { path = cgPath } }
        get { guard let cgPath = path else { return nil }
            return UIBezierPath(cgPath: cgPath)
        }
    }
    
}


// MARK: - 决策判断
public extension CAShapeLayer {
}

// MARK: - 操作符
public extension CAShapeLayer {
}

// MARK: - 运算符
public extension CAShapeLayer {
}
