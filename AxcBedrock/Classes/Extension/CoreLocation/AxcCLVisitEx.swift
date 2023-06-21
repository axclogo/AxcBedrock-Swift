//
//  AxcCLVisitEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/22.
//

import CoreLocation

// MARK: - 数据转换

public extension AxcSpace where Base: CLVisit {
    /// 转换CLLocation
    var clLocation: CLLocation {
        return CLLocation(latitude: base.coordinate.latitude,
                          longitude: base.coordinate.longitude)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base: CLVisit { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: CLVisit { }

// MARK: - 决策判断

public extension AxcSpace where Base: CLVisit { }
