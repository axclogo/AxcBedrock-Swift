//
//  AxcCLLocationCoordinate2DEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

import CoreLocation

// MARK: - CLLocationCoordinate2D + AxcSpaceProtocol

extension CLLocationCoordinate2D: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CLLocationCoordinate2D {
    /// 转换成CLLocation
    var clLocation: CLLocation {
        return CLLocation(latitude: base.latitude,
                          longitude: base.longitude)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == CLLocationCoordinate2D { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == CLLocationCoordinate2D {
    /// 计算距离
    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        return clLocation.distance(from: coordinate.axc.clLocation)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == CLLocationCoordinate2D { }
