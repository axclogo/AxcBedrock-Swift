//
//  AxcCLLocationEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/22.
//

import CoreLocation

// MARK: - 数据转换

public extension AxcSpace where Base: CLLocation { }

// MARK: - 类方法

public extension AxcSpace where Base: CLLocation { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: CLLocation {
    /// 计算两点之间的大圆路径的中点。
    /// - Parameters:
    ///   - toEnd: 终点
    /// - Returns: 中点
    func midLocation(toEnd end: CLLocation) -> CLLocation {
        let lat1 = Double.pi * base.coordinate.latitude / 180.0
        let long1 = Double.pi * base.coordinate.longitude / 180.0
        let lat2 = Double.pi * end.coordinate.latitude / 180.0
        let long2 = Double.pi * end.coordinate.longitude / 180.0
        //    Bx = cos φ2 ⋅ cos Δλ
        //    By = cos φ2 ⋅ sin Δλ
        //    φm = atan2( sin φ1 + sin φ2, √(cos φ1 + Bx)² + By² )
        //    λm = λ1 + atan2(By, cos(φ1)+Bx)
        // 资料：http://www.movable-type.co.uk/scripts/latlong.html
        let bxLoc = cos(lat2) * cos(long2 - long1)
        let byLoc = cos(lat2) * sin(long2 - long1)
        let mlat = atan2(sin(lat1) + sin(lat2), sqrt((cos(lat1) + bxLoc) * (cos(lat1) + bxLoc) + (byLoc * byLoc)))
        let mlong = long1 + atan2(byLoc, cos(lat1) + bxLoc)
        return CLLocation(latitude: mlat * 180 / Double.pi,
                          longitude: mlong * 180 / Double.pi)
    }

    /// 计算到另一个点的方向（极坐标中的对应角度）
    /// - Parameters:
    ///   - destination: 计算方位位置
    /// - Returns: 计算轴承度范围为0°…360°
    func bearing(to destination: CLLocation) -> Double {
        let lat1 = Double.pi * base.coordinate.latitude / 180.0
        let long1 = Double.pi * base.coordinate.longitude / 180.0
        let lat2 = Double.pi * destination.coordinate.latitude / 180.0
        let long2 = Double.pi * destination.coordinate.longitude / 180.0
        // Formula: θ = atan2( sin Δλ ⋅ cos φ2 , cos φ1 ⋅ sin φ2 − sin φ1 ⋅ cos φ2 ⋅ cos Δλ )
        // 资料: http://www.movable-type.co.uk/scripts/latlong.html
        let rads = atan2(
            sin(long2 - long1) * cos(lat2),
            cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(long2 - long1))
        let degrees = rads * 180 / Double.pi
        return (degrees + 360).truncatingRemainder(dividingBy: 360)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CLLocation { }
