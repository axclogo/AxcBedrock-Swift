//
//  AxcCGAffineTransformEx+QuartzCore.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

import QuartzCore

public extension AxcSpace where Base == CGAffineTransform {
    /// 转换为CATransform3D
    /// - Returns: CATransform3D
    func transform3D() -> CATransform3D {
        return CATransform3DMakeAffineTransform(base)
    }
}
