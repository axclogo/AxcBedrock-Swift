//
//  AxcEnum+CoreGraphics.swift
//  Pods
//
//  Created by 赵新 on 2023/2/24.
//

import CoreGraphics

// MARK: - [AxcBedrockLib.PathElement]

// 暂时内部私有使用，等合适成熟后可随时开放

extension AxcEnum {
    /// Swifty version of `CGPathElement` & `CGPathElementType`
    enum PathElement {
        /// 开始一个新的子路径，该元素只包含一个目标点
        case move(to: CGPoint)
        /// 添加从当前点到新点的直线，该元素只包含一个目标点
        case addLine(to: CGPoint)
        /// 添加从当前点到指定点的二次贝塞尔曲线，该元素包含一个控制点和一个目标点
        case addQuadCurve(CGPoint, to: CGPoint)
        /// 添加从当前点到指定点的三次贝塞尔曲线，该元素包含两个控制点和一个目标点
        case addCurve(CGPoint, CGPoint, to: CGPoint)
        /// 关闭并完成子路径，该元素不包含任何点
        case closeSubpath

        init(element: CGPathElement) {
            switch element.type {
            case .moveToPoint:
                self = .move(to: element.points[0])
            case .addLineToPoint:
                self = .addLine(to: element.points[0])
            case .addQuadCurveToPoint:
                self = .addQuadCurve(element.points[0], to: element.points[1])
            case .addCurveToPoint:
                self = .addCurve(element.points[0], element.points[1], to: element.points[2])
            case .closeSubpath:
                self = .closeSubpath
            @unknown default:
                AxcBedrockLib.FatalLog("没有找到对应的CGPathElement：\(element)")
            }
        }
    }
}
