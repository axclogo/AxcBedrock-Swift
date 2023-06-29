//
//  _AxcCGPathEx.swift
//  Pods
//
//  Created by 赵新 on 2023/2/24.
//

import CoreGraphics

// MARK: - 私有

// 暂时内部私有使用，等合适成熟后可随时开放

extension AxcSpace where Base: CGPath {
    /// 获取点位
    /// - Parameters:
    ///   - percent: 百分比
    ///   - elements: 元素类型
    /// - Returns: 点位
    func point(at percent: CGFloat,
               with elements: [AxcEnum.PathElement]) -> CGPoint? {
        guard (0 ... 1) ~= percent else { return nil }
        let percentLength = length * percent
        var lengthTraversed: CGFloat = 0
        var firstPointInSubpath: CGPoint?
        // 保存路径上的当前点(绝对不能是控制点)
        var currentPoint: CGPoint?
        for e in elements {
            switch (e) {
            case let .move(to: p0):
                currentPoint = p0
                if firstPointInSubpath == nil {
                    firstPointInSubpath = p0
                }

            case let .addLine(to: p1):
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                let l = linearLength(p0: p0, p1: p1)
                if lengthTraversed + l >= percentLength {
                    let lengthInSubpath = percentLength - lengthTraversed
                    let t = lengthInSubpath / l
                    return linearPoint(t: t, p0: p0, p1: p1)
                }
                lengthTraversed += l
                currentPoint = p1

            case let .addQuadCurve(c1, to: p1):
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                let l = quadCurveLength(p0: p0, c1: c1, p1: p1)
                if lengthTraversed + l >= percentLength {
                    let lengthInSubpath = percentLength - lengthTraversed
                    let t = lengthInSubpath / l
                    return quadCurvePoint(t: t, p0: p0, c1: c1, p1: p1)
                }
                lengthTraversed += l
                currentPoint = p1

            case let .addCurve(c1, c2, to: p1):
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                let l = cubicCurveLength(p0: p0, c1: c1, c2: c2, p1: p1)
                if lengthTraversed + l >= percentLength {
                    let lengthInSubpath = percentLength - lengthTraversed
                    let t = lengthInSubpath / l
                    return cubicCurvePoint(t: t, p0: p0, c1: c1, c2: c2, p1: p1)
                }
                lengthTraversed += l
                currentPoint = p1

            case .closeSubpath:
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                if let p1 = firstPointInSubpath {
                    let l = linearLength(p0: p0, p1: p1)
                    if lengthTraversed + l >= percentLength {
                        let lengthInSubpath = percentLength - lengthTraversed
                        let t = lengthInSubpath / l
                        return linearPoint(t: t, p0: p0, p1: p1)
                    }
                    lengthTraversed += l
                    currentPoint = p1
                }
                firstPointInSubpath = nil
            }
        }

        return nil
    }

    /// 获取长度
    /// - Parameter elements: 元素类型
    /// - Returns: 长度值
    func getLength(with elements: [AxcEnum.PathElement]) -> CGFloat {
        var firstPointInSubpath: CGPoint?
        // 保存路径上的当前点(绝对不能是控制点)
        var currentPoint: CGPoint?
        var length: CGFloat = 0
        for e in elements {
            switch (e) {
            case let .move(to: p0):
                currentPoint = p0
                if firstPointInSubpath == nil {
                    firstPointInSubpath = p0
                }

            case let .addLine(to: p1):
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                length += linearLength(p0: p0, p1: p1)
                currentPoint = p1

            case let .addQuadCurve(c1, to: p1):
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                length += quadCurveLength(p0: p0, c1: c1, p1: p1)
                currentPoint = p1

            case let .addCurve(c1, c2, to: p1):
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                length += cubicCurveLength(p0: p0, c1: c1, c2: c2, p1: p1)
                currentPoint = p1

            case .closeSubpath:
                guard let p0 = currentPoint else {
                    AxcBedrockLib.FatalLog("没有找到当前路径点")
                    break
                }
                if let p1 = firstPointInSubpath {
                    length += linearLength(p0: p0, p1: p1)
                    currentPoint = p1
                }
                firstPointInSubpath = nil
            }
        }

        return length
    }

    // MARK: - Linear

    /// 线长
    /// - Parameters:
    ///   - p0: 点0
    ///   - p1: 点1
    /// - Returns: 两点间距
    func linearLength(p0: CGPoint, p1: CGPoint) -> CGFloat {
        return p0.axc.distance(to: p1)
    }

    /// 两点间的百分比的某一个点位
    /// - Parameters:
    ///   - t: 百分比
    ///   - p0: 点0
    ///   - p1: 点1
    /// - Returns: 点位
    func linearPoint(t: CGFloat, p0: CGPoint, p1: CGPoint) -> CGPoint {
        let x = linearValue(t: t, p0: p0.x, p1: p1.x)
        let y = linearValue(t: t, p0: p0.y, p1: p1.y)
        return CGPoint(x: x, y: y)
    }

    func linearValue(t: CGFloat, p0: CGFloat, p1: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t) * p0 + t * p1
        value += (1 - t) * p0
        value += t * p1
        return value
    }

    // MARK: - Quadratic

    func quadCurveLength(p0: CGPoint, c1: CGPoint, p1: CGPoint) -> CGFloat {
        var approxDist: CGFloat = 0
        let approxSteps: CGFloat = 100
        for i in 0 ..< Int(approxSteps) {
            let t0 = CGFloat(i) / approxSteps
            let t1 = CGFloat(i + 1) / approxSteps
            let a = quadCurvePoint(t: t0, p0: p0, c1: c1, p1: p1)
            let b = quadCurvePoint(t: t1, p0: p0, c1: c1, p1: p1)
            approxDist += a.axc.distance(to: b)
        }
        return approxDist
    }

    func quadCurvePoint(t: CGFloat, p0: CGPoint, c1: CGPoint, p1: CGPoint) -> CGPoint {
        let x = quadCurveValue(t: t, p0: p0.x, c1: c1.x, p1: p1.x)
        let y = quadCurveValue(t: t, p0: p0.y, c1: c1.y, p1: p1.y)
        return CGPoint(x: x, y: y)
    }

    func quadCurveValue(t: CGFloat, p0: CGFloat, c1: CGFloat, p1: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^2 * p0 + 2 * (1-t) * t * c1 + t^2 * p1
        value += pow(1 - t, 2) * p0
        value += 2 * (1 - t) * t * c1
        value += pow(t, 2) * p1
        return value
    }

    // MARK: - Cubic

    func cubicCurveLength(p0: CGPoint, c1: CGPoint, c2: CGPoint, p1: CGPoint) -> CGFloat {
        var approxDist: CGFloat = 0
        let approxSteps: CGFloat = 100
        for i in 0 ..< Int(approxSteps) {
            let t0 = CGFloat(i) / approxSteps
            let t1 = CGFloat(i + 1) / approxSteps
            let a = cubicCurvePoint(t: t0, p0: p0, c1: c1, c2: c2, p1: p1)
            let b = cubicCurvePoint(t: t1, p0: p0, c1: c1, c2: c2, p1: p1)
            approxDist += a.axc.distance(to: b)
        }
        return approxDist
    }

    func cubicCurvePoint(t: CGFloat, p0: CGPoint, c1: CGPoint, c2: CGPoint, p1: CGPoint) -> CGPoint {
        let x = cubicCurveValue(t: t, p0: p0.x, c1: c1.x, c2: c2.x, p1: p1.x)
        let y = cubicCurveValue(t: t, p0: p0.y, c1: c1.y, c2: c2.y, p1: p1.y)
        return CGPoint(x: x, y: y)
    }

    func cubicCurveValue(t: CGFloat, p0: CGFloat, c1: CGFloat, c2: CGFloat, p1: CGFloat) -> CGFloat {
        var value: CGFloat = 0.0
        // (1-t)^3 * p0 + 3 * (1-t)^2 * t * c1 + 3 * (1-t) * t^2 * c2 + t^3 * p1
        value += pow(1 - t, 3) * p0
        value += 3 * pow(1 - t, 2) * t * c1
        value += 3 * (1 - t) * pow(t, 2) * c2
        value += pow(t, 3) * p1
        return value
    }

    // MARK: - Elements

    var elements: [AxcEnum.PathElement] {
        var pathElements = [AxcEnum.PathElement]()
        apply { (element) in
            let pathElement = AxcEnum.PathElement(element: element.pointee)
            pathElements.append(pathElement)
        }
        return pathElements
    }

    func apply(with applier: @escaping @convention(block) (UnsafePointer<CGPathElement>) -> Void) {
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let block = unsafeBitCast(info, to: (@convention(block) (UnsafePointer<CGPathElement>) -> Void).self)
            block(element)
        }
        base.apply(info: unsafeBitCast(applier, to: UnsafeMutableRawPointer.self),
                   function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
}
