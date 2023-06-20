//
//  AxcVibrationManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/10.
//

import UIKit
import AudioToolbox

public extension AxcVibrationManager {
    /// 震动类型
    enum FeedbackStyle: Int {
        // MARK: iphone7后支持
        /// 轻
        case light = 0
        /// 中等
        case medium = 1
        /// 重
        case heavy = 2

        @available(iOS 13.0, *)
        case soft = 3
        
        @available(iOS 13.0, *)
        case rigid = 4
        
        // MARK: 全支持
        /// 3DTouch中Peek震动效果
        case threeDimensionalTouch_peek = 1519
        /// 3DTouch中Pop震动效果
        case threeDimensionalTouch_pop = 1520
        /// 连续三次短震
        case threeShort = 1521
        /// 长震动
        case long = -1
    }
}

open class AxcVibrationManager: NSObject {
    /// 调用震动
    /// - Parameter type: 选择震动类型
    public static func axc_playVibration(_ type: AxcVibrationManager.FeedbackStyle = .medium) {
        if type.rawValue < 5 { // 7后支持的
            guard let style = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: type.rawValue)
            else { AxcLog("设备调用震动失败", level: .warning); return }
            let feedback = UIImpactFeedbackGenerator(style: style)
            feedback.impactOccurred() // 调用
        }else{
            if type.rawValue > 0 {
                AudioServicesPlayAlertSound(UInt32(type.rawValue))
            }else{
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }
}
