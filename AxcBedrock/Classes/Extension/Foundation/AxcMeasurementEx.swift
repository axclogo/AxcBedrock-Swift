//
//  AxcMeasurementEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/16.
//

import Foundation

/**
 单位转换Measurement
 */

// MARK: - 数据转换
public extension AxcSpace where Base == Measurement<UnitAngle> {

}

// MARK: - 类方法
public extension AxcSpace where Base == Measurement<UnitAngle> {
    /// 创建一个' Measurement '角度的指定值(以度为单位)
    static func degrees(_ value: AxcUnifiedNumber) -> Base {
        return Measurement(value: Double.Axc.Create(value), unit: .degrees)
    }

    /// 创建指定角度的测量值，以弧分为单位
    static func arcMinutes(_ value: AxcUnifiedNumber) -> Base {
        return Measurement(value: Double.Axc.Create(value), unit: .arcMinutes)
    }

    /// 创建一个以弧秒为指定值的角度测量值
    static func arcSeconds(_ value: AxcUnifiedNumber) -> Base {
        return Measurement(value: Double.Axc.Create(value), unit: .arcSeconds)
    }

    /// 创建一个以弧度为指定值的角度测量
    static func radians(_ value: AxcUnifiedNumber) -> Base {
        return Measurement(value: Double.Axc.Create(value), unit: .radians)
    }

    /// 创建一个带有指定值的斜度的角度测量
    static func gradians(_ value: AxcUnifiedNumber) -> Base {
        return Measurement(value: Double.Axc.Create(value), unit: .gradians)
    }

    /// 创建一个角度的测量值，该值以转数表示
    static func revolutions(_ value: AxcUnifiedNumber) -> Base {
        return Measurement(value: Double.Axc.Create(value), unit: .revolutions)
    }
}

// MARK: - 属性 & Api
public extension AxcSpace where Base == Measurement<UnitAngle> {

}

// MARK: - 决策判断
public extension AxcSpace where Base == Measurement<UnitAngle> {

}
