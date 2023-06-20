//
//  AxcCGPathEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/10.
//

import UIKit

// MARK: - 数据转换
public extension CGPath {
    /// 转换成UIBezierPath
    var axc_bezierPath: UIBezierPath {
        return UIBezierPath(cgPath: self)
    }
    
    /// 转换成文字路径
    var axc_textPath: UIBezierPath {
        return UIBezierPath(textPath: self)
    }
}
