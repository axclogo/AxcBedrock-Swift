//
//  AxcCATransform3DEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/28.
//

import QuartzCore

// MARK: - 数据转换

public extension AxcSpace where Base == CATransform3D { }

// MARK: - 类方法

public extension AxcSpace where Base== CATransform3D {
    /// 获取恒等变换的矩阵
    @inlinable
    static var Identity: CATransform3D {
        CATransform3DIdentity
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base== CATransform3D {
    /// Translate转换
    /// - Parameters:
    ///   - tx: x-axis 轴
    ///   - ty: y-axis 轴
    ///   - tz: z-axis 轴
    /// - Returns: 变换后的对象
    @inlinable
    func translatedBy(x tx: CGFloat,
                      y ty: CGFloat,
                      z tz: CGFloat) -> CATransform3D {
        return CATransform3DTranslate(base, tx, ty, tz)
    }

    /// 缩放
    /// - Parameters:
    ///   - sx: x-axis 缩放
    ///   - sy: y-axis 缩放
    ///   - sz: z-axis 缩放
    /// - Returns: 变换后的对象
    @inlinable
    func scaledBy(x sx: CGFloat,
                  y sy: CGFloat,
                  z sz: CGFloat) -> CATransform3D {
        return CATransform3DScale(base, sx, sy, sz)
    }

    /// 旋转
    /// - Parameters:
    ///   - angle: 旋转角度 0-360
    ///   - x: x position 矩阵点位
    ///   - y: y position 矩阵点位
    ///   - z: z position 矩阵点位
    /// - Returns: 变换后的对象
    @inlinable
    func rotatedBy(angle: CGFloat,
                   x: CGFloat,
                   y: CGFloat,
                   z: CGFloat) -> CATransform3D {
        return rotatedBy(radian: angle.axc.angleToRadian, x: x, y: y, z: z)
    }

    /// 旋转
    /// - Parameters:
    ///   - radian: 旋转弧度 0-pi
    ///   - x: x position 矩阵点位
    ///   - y: y position 矩阵点位
    ///   - z: z position 矩阵点位
    /// - Returns: 变换后的对象
    @inlinable
    func rotatedBy(radian: CGFloat,
                   x: CGFloat,
                   y: CGFloat,
                   z: CGFloat) -> CATransform3D {
        return CATransform3DRotate(base, radian, x, y, z)
    }

    /// 取逆矩阵
    /// 如果接收者没有逆矩阵，则返回原始矩阵.
    /// - Returns: 变换后的对象
    @inlinable
    func inverted() -> CATransform3D {
        return CATransform3DInvert(base)
    }

    /// 矩阵合并
    /// - Parameter t2: 将两个矩阵变换合并为一个
    /// - Returns: 变换后的对象
    @inlinable
    func concatenating(_ t2: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(base, t2)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base== CATransform3D {
    /// 如果矩阵是恒等变换，则true.
    @inlinable
    var isIdentity: Bool {
        CATransform3DIsIdentity(base)
    }
}

// MARK: - To->CoreGraphics

#if canImport(CoreGraphics)

import CoreGraphics

public extension AxcSpace where Base== CATransform3D {
    /// 如果接收方可以通过仿射变换（CGAffineTransform）精确地表示，则返回true
    @inlinable
    var isAffine: Bool {
        return CATransform3DIsAffine(base)
    }

    /// 转换成CGAffineTransform仿射变换
    @inlinable
    func cgAffineTransform() -> CGAffineTransform {
        CATransform3DGetAffineTransform(base)
    }
}

#endif
