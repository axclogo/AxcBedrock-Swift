//
//  AxcCAMediaTimingFunctionNameEx+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base == CAMediaTimingFunctionName {
    /// 转换成UIView.AnimationOptions
    var uiViewAnimationOptions: UIView.AnimationOptions {
        if base == CAMediaTimingFunctionName.easeIn {
            return .curveEaseIn
        } else if base == CAMediaTimingFunctionName.easeOut {
            return .curveEaseOut
        } else if base == CAMediaTimingFunctionName.easeInEaseOut {
            return .curveEaseInOut
        } else {
            return .curveLinear
        }
    }
}

#endif
