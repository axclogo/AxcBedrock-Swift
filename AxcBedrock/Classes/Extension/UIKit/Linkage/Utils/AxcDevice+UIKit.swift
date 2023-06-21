//
//  AxcDevice+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(UIKit)

import UIKit

public extension AxcDevice {
    /// 获取设备电量百分比
    static var BatteryLevel: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let battery = abs(Int(UIDevice.current.batteryLevel * 100))
        return battery
    }
}

// MARK: - [AxcDevice.Style]

public extension AxcDevice {
    /// 震动样式
    enum VibrationStyle: Int {
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

#if canImport(AudioToolbox)

import AudioToolbox

public extension AxcDevice {
    /// 调用震动（废弃）
    @available(*, deprecated, message: "此api已经废弃，请使用PlayVibration")
    static func PlayShake(_ type: VibrationStyle = .medium) {
        PlayVibration(type)
    }

    /// 调用震动
    /// - Parameter type: 选择震动类型
    static func PlayVibration(_ type: VibrationStyle = .medium) {
        if type.rawValue < 5 { // 7后支持的
            guard let style = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: type.rawValue)
            else {
                AxcBedrockLib.Log("设备振动调用失败")
                return
            }
            let feedback = UIImpactFeedbackGenerator(style: style)
            feedback.impactOccurred() // 调用
        } else {
            if type.rawValue > 0 {
                AudioServicesPlayAlertSound(UInt32(type.rawValue))
            } else {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }
}

#endif
#endif
