//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

public extension AxcCIFilterCategory {
    /// 过渡效果
    enum Transition: String {
        /// 手风琴折叠过渡效果
        case accordionFoldTransition
        /// 条形滑动过渡效果
        case barsSwipeTransition
        /// 复印机过渡效果
        case copyMachineTransition
        /// 带遮罩的解体过渡效果
        case disintegrateWithMaskTransition
        /// 溶解过渡效果
        case dissolveTransition
        /// 闪光过渡效果
        case flashTransition
        /// 模块过渡效果
        case modTransition
        /// 翻页过渡效果
        case pageCurlTransition
        /// 带阴影的翻页过渡效果
        case pageCurlWithShadowTransition
        /// 波纹过渡效果
        case rippleTransition
        /// 滑动过渡效果
        case swipeTransition
    }
}
