//
//  AxcBedrock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

#if os(macOS)
import AppKit

/// （💈跨平台标识）贝塞尔曲线类型
public typealias AxcBedrockBezierPath = NSBezierPath

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

/// （💈跨平台标识）贝塞尔曲线类型
public typealias AxcBedrockBezierPath = UIBezierPath
#endif

// MARK: - 数据转换

public extension AxcSpace where Base: AxcBedrockBezierPath {
    /// （💈跨平台标识）获取CGPath
    var cgPath: CGPath {
        #if os(macOS)
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< base.elementCount {
            let type = base.element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default: break
            }
        }
        return path

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return base.cgPath
        #endif
    }
}

// MARK: - 类方法

// MARK: 常规绘图Api

public extension AxcSpace where Base: AxcBedrockBezierPath {
    /// （💈跨平台标识）绘制一个十字准星
    /// - Parameters:
    ///   - reticleCenter: 中心
    ///   - size: 大小默认1024
    static func CreateReticle(center: CGPoint,
                              size: CGSize = CGSize(width: 1024, height: 1024)) -> AxcBedrockBezierPath {
        return Create(groupPoints: [
            [
                CGPoint(x: center.x - size.width / 2, y: center.y),
                CGPoint(x: center.x + size.width / 2, y: center.y),
            ], [
                CGPoint(x: center.x, y: center.y - size.height / 2),
                CGPoint(x: center.x, y: center.y + size.height / 2),
            ],
        ])
    }

    /// （💈跨平台标识）绘制刻度线尺
    /// - Parameters:
    ///   - startPoint: 起始点位
    ///   - groupCount: 刻度中组个数
    ///   - groupScaleHeight: 每组起始刻度的最高值
    ///   - scaleLineCount: 每组的刻度线个数
    ///   - scaleLineHeight: 每组的刻度最高值
    ///   - spacing: 刻度间距
    ///   - directionVertical: 垂直方向
    ///   - isReversing: 是否反向绘制
    /// - Returns: bezierPath
    static func CreateRuler(startPoint: CGPoint,
                            groupCount: Int = 4,
                            groupScaleHeight: CGFloat = 48,
                            scaleLineCount: Int = 10,
                            scaleLineHeight: CGFloat = 24,
                            spacing: CGFloat = 4,
                            directionVertical: AxcDirectionVertical = .bottom,
                            isReversing: Bool = false) -> AxcBedrockBezierPath {
        var pointers: [[CGPoint]] = []
        var pointPointer = startPoint
        for i in 0 ... groupCount { // 绘制大刻度
            pointers.append([
                pointPointer,
                CGPoint(x: pointPointer.x, y: pointPointer.y + groupScaleHeight),
            ])
            if i == groupCount { break }
            for _ in 1 ..< scaleLineCount { // 小刻度
                pointPointer = CGPoint(x: pointPointer.x + spacing, y: pointPointer.y)
                switch directionVertical {
                case .top:
                    pointers.append([
                        CGPoint(x: pointPointer.x, y: pointPointer.y + groupScaleHeight - scaleLineHeight),
                        CGPoint(x: pointPointer.x, y: pointPointer.y + groupScaleHeight),
                    ])
                case .bottom:
                    pointers.append([
                        pointPointer,
                        CGPoint(x: pointPointer.x, y: pointPointer.y + scaleLineHeight),
                    ])
                }
            }
            pointPointer = CGPoint(x: pointPointer.x + spacing, y: pointPointer.y)
        }
        let bezierPath = Create(groupPoints: pointers, isReversing: isReversing)
        return bezierPath
    }

    /// （💈跨平台标识）绘制一个平行四边形
    /// - Parameters:
    ///   - rect: 原框
    ///   - offset: 平行四边形的偏移量
    ///   - isReversing: 是否反向绘制
    /// - Returns: bezierPath
    static func CreateParallelogram(rect: CGRect,
                                    offset: CGSize,
                                    isReversing: Bool = false) -> AxcBedrockBezierPath {
        let points: [CGPoint] = [
            rect.origin,
            CGPoint(x: rect.origin.x + rect.size.width,
                    y: rect.origin.y + offset.height),
            CGPoint(x: rect.origin.x + rect.size.width + offset.width,
                    y: rect.origin.y + rect.size.height + offset.height),
            CGPoint(x: rect.origin.x + offset.width,
                    y: rect.origin.y + rect.size.height),
        ]
        let bezierPath = Create(points: points, isReversing: isReversing, isClose: true)
        return bezierPath
    }

    /// （💈跨平台标识）绘制两点的线
    /// - Parameters:
    ///   - from: 起点
    ///   - otherPoint: 终点
    ///   - isReversing: 是否反向（倒叙绘制）
    static func Create(from: CGPoint, to otherPoint: CGPoint,
                       isReversing: Bool = false) -> AxcBedrockBezierPath {
        return Create(groupPoints: [[from, otherPoint]],
                      isReversing: isReversing)
    }

    /// （💈跨平台标识）绘制一组折线
    /// - Parameters:
    ///   - points: 折线点
    ///   - isReversing: 是否反向（倒叙绘制）
    ///   - isClose: 是否闭合
    static func Create(points: [CGPoint],
                       isReversing: Bool = false,
                       isClose: Bool = false) -> AxcBedrockBezierPath {
        return Create(groupPoints: [points],
                      isReversing: isReversing,
                      isClose: isClose)
    }

    /// （💈跨平台标识）绘制多组折线
    /// - Parameters:
    ///   - groupPoint: 折线组集合
    ///   - isReversing: 是否每组反向（倒叙绘制）
    ///   - isClose: 是否每组是否闭合
    static func Create(groupPoints: [[CGPoint]],
                       isReversing: Bool = false,
                       isClose: Bool = false) -> AxcBedrockBezierPath {
        let bezierPath = AxcBedrockBezierPath()
        for i_pointArr in groupPoints {
            var pointArr = i_pointArr
            if isReversing { // 点位反转
                pointArr = pointArr.reversed()
            }
            if let firstPoint = pointArr.first { // 有第一个
                bezierPath.move(to: firstPoint)
                for point in pointArr {
                    bezierPath.axc.addLine(to: point)
                }
            }
            if isClose { // 闭合
                bezierPath.close()
            }
        }
        return bezierPath
    }
}

// MARK: 圆类绘图Api

public extension AxcSpace where Base: AxcBedrockBezierPath {
    /// （💈跨平台标识）绘制内接于圆的多边形（圆周多边形）
    /// - Parameters:
    ///   - center: 中心点
    ///   - radius: 半径
    ///   - pointCount: 点位个数
    ///   - startAngle: 起始角度
    ///   - openingAngle: 开合角度 0-360
    ///   - isReversing: 是否反向绘制
    /// - Returns: bezierPath
    static func CreatePolygonInsideCircle(center: CGPoint,
                                          radius: CGFloat,
                                          pointCount: Int,
                                          startAngle: AxcAngleType = .zero,
                                          openingAngle: CGFloat = 0,
                                          isReversing: Bool = false) -> AxcBedrockBezierPath {
        guard pointCount > 2 else {
            #if DEBUG
            AxcBedrockLib.FatalLog("多边形点位必须大于2！")
            #else
            return .init()
            #endif
        }
        var points: [CGPoint] = []
        // 间隔角度
        let intervalAngle = (360 - openingAngle) / CGFloat(pointCount)
        for i in 0 ..< pointCount {
            let angle = startAngle.angleValue + intervalAngle * CGFloat(i) // 变化角度
            let polarAxisPoint: CGPoint = CGPoint.Axc.CreatePolarAxis(center: center,
                                                                     distance: radius,
                                                                     angle: angle,
                                                                     startAngle: startAngle)
            points.append(polarAxisPoint)
        }
        let bezierPath = Create(points: points, isReversing: isReversing, isClose: true)
        return bezierPath
    }

    /// （💈跨平台标识）绘制多段圆弧
    /// - Parameters:
    ///   - center: 中心点
    ///   - radius: 半径
    ///   - arcCount: 圆弧个数
    ///   - arcAngle: 圆弧角度
    ///   - connection: 圆弧是否首尾相连
    ///   - startAngle: 起始角度
    ///   - openingAngle: 开合角度 0-360
    ///   - isReversing: 是否反向绘制
    /// - Returns: bezierPath
    static func CreateMutibleArc(center: CGPoint,
                                 radius: CGFloat,
                                 arcCount: Int,
                                 arcAngle: CGFloat,
                                 connection: Bool = false,
                                 startAngle: AxcAngleType = .zero,
                                 openingAngle: CGFloat = 0,
                                 isReversing: Bool = false) -> AxcBedrockBezierPath {
        let bezierPath = AxcBedrockBezierPath()
        let spacingRadian = ((360.0 - openingAngle) / CGFloat(arcCount)).axc.angleToRadian
        for i in 0 ..< arcCount {
            var _startRadian: CGFloat = 0
            var _endRadian: CGFloat = 0
            if isReversing { // 反向
                _startRadian = (startAngle.radianValue) - (CGFloat(i) * spacingRadian)
                _endRadian = _startRadian - arcAngle.axc.angleToRadian
            } else {
                _startRadian = (startAngle.radianValue) + (CGFloat(i) * spacingRadian)
                _endRadian = _startRadian + arcAngle.axc.angleToRadian
            }
            bezierPath.axc.addArc(withCenter: center,
                                 radius: radius,
                                 startAngle: _startRadian,
                                 endAngle: _endRadian,
                                 clockwise: !isReversing)
            if !connection {
                var moveRadian: CGFloat = 0
                if isReversing {
                    moveRadian = _startRadian - spacingRadian
                } else {
                    moveRadian = _startRadian + spacingRadian
                }
                let polarAxisPoint: CGPoint = CGPoint.Axc.CreatePolarAxis(center: center,
                                                                         distance: radius,
                                                                         radian: moveRadian)
                bezierPath.move(to: polarAxisPoint)
            }
        }
        if connection {
            bezierPath.close()
        }
        return bezierPath
    }
    
    /// （💈跨平台标识）绘制辐射圆
    /// - Parameters:
    ///   - center: 中心点
    ///   - radius: 半径
    ///   - lineHeights: 线高度，为正向外，为负向内
    ///   - clockwise: 顺序类型，默认顺时针
    ///   - startAngle: 起始角度
    ///   - openingAngle: 开合角度 0-360
    ///   - isReversing: 是否反向绘制
    /// - Returns: bezierPath
    static func CreateRadiateCircle(center: CGPoint,
                                    radius: CGFloat,
                                    linesHeight: [AxcUnifiedNumber],
                                    clockwise: AxcClockwise = .clockwise,
                                    startAngle: AxcAngleType = .zero,
                                    openingAngle: CGFloat = 0,
                                    isReversing: Bool = false) -> AxcBedrockBezierPath {
        var groupPoints: [[CGPoint]] = []
        let angle = (360.0 - openingAngle) / CGFloat(linesHeight.count)
        for (idx, height) in linesHeight.enumerated() {
            var startPointAngle: CGFloat = 0
            var isClockwise = clockwise.isClockwise
            #if os(macOS)  // 桌面端和移动端坐标系相反
            isClockwise = !isClockwise
            #endif
            if isClockwise {
                startPointAngle = startAngle.angleValue + CGFloat(idx) * angle
            } else {
                startPointAngle = startAngle.angleValue - CGFloat(idx) * angle
            }
            let point_1 = CGPoint.Axc.CreatePolarAxis(center: center,
                                                     distance: radius,
                                                     angle: startPointAngle)
            let radius_2 = radius + AssertTransformCGFloat(height)
            let point_2 = CGPoint.Axc.CreatePolarAxis(center: center,
                                                     distance: radius_2,
                                                     angle: startPointAngle)
            groupPoints.append([point_1, point_2])
        }
        return Create(groupPoints: groupPoints, isReversing: isReversing)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AxcBedrockBezierPath {
    /// （💈跨平台标识）length
    var length: CGFloat {
        return cgPath.axc.length
    }

    /// （💈跨平台标识）在给定的百分比下得到路径上的点
    /// - Parameter percent: 0-1百分比
    /// - Returns: 点位
    func point(at percent: CGFloat) -> CGPoint? {
        return cgPath.axc.point(at: percent)
    }

    /// （💈跨平台标识）添加点位
    /// - Parameter point: 点位
    /// - Returns: 点位
    func addLine(to point: CGPoint) {
        #if os(macOS)
        base.line(to: point)

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        base.addLine(to: point)
        #endif
    }

    /// （💈跨平台标识）添加圆弧
    /// - Parameters:
    ///   - center: 圆心
    ///   - radius: 半径
    ///   - startAngle: 起始角
    ///   - endAngle: 结束角
    ///   - clockwise: 是否顺时针
    func addArc(withCenter center: CGPoint,
                radius: CGFloat,
                startAngle: CGFloat,
                endAngle: CGFloat,
                clockwise: Bool) {
        #if os(macOS)
        base.appendArc(withCenter: center,
                       radius: radius,
                       startAngle: startAngle,
                       endAngle: endAngle,
                       clockwise: clockwise)

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        base.addArc(withCenter: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: clockwise)
        #endif
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: AxcBedrockBezierPath { }
