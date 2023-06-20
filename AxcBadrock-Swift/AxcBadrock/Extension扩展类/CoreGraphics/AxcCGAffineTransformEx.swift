//
//  AxcCGAffineTransformEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/9.
//

import UIKit

// MARK: - 数据转换
public extension CGAffineTransform {
    /// 转换成CATransform3D
    var axc_transform3D: CATransform3D {
        return CATransform3DMakeAffineTransform(self)
    }
}
