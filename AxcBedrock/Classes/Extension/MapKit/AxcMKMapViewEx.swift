//
//  AxcMKMapViewEx.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/9.
//

import MapKit

// MARK: - 数据转换

public extension AxcSpace where Base: MKMapView { }

// MARK: - 类方法

public extension AxcSpace where Base: MKMapView { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: MKMapView { }

// MARK: - zoomLevel缩放等级

public extension AxcSpace where Base: MKMapView {
    /// 获取缩放等级
    var zoomLevel: CGFloat {
        zoomLevel(from: bottomLongitudeDelta)
    }

    /// 获取缩放等级
    /// - Parameter longitudeDelta: 用于表示WGS 84引用下的纬度或经度坐标的类型框架。可以是正的(北和东)或负的(南和西)
    /// - Returns: 缩放等级
    func zoomLevel(from longitudeDelta: CLLocationDegrees) -> CGFloat {
        return log2(360 * base.frame.width / (128 * CGFloat(longitudeDelta)))
    }

    /// 设置缩放等级
    /// - Parameters:
    ///   - zoomLevel: 缩放等级
    ///   - animated: 是否动画
    func set(zoomLevel: CGFloat, animated: Bool) {
        let oldBottomLongitudeDelta = bottomLongitudeDelta
        let newBottomLongitudeDelta = longitudeDelta(from: zoomLevel)
        let oldCenterCoordinateDistance: CLLocationDistance
        if #available(iOS 13.0, macOS 10.15, tvOS 13.0, *) {
            oldCenterCoordinateDistance = base.camera.centerCoordinateDistance
        } else {
            let pitchInRadians = base.camera.pitch * (.pi / 180)
            oldCenterCoordinateDistance = base.camera.altitude / cos(Double(pitchInRadians))
        }
        let newCenterCoordinateDistance = oldCenterCoordinateDistance * (newBottomLongitudeDelta / oldBottomLongitudeDelta)
        let camera = MKMapCamera(lookingAtCenter: base.camera.centerCoordinate,
                                 fromDistance: newCenterCoordinateDistance,
                                 pitch: base.camera.pitch,
                                 heading: base.camera.heading)
        base.setCamera(camera, animated: animated)
    }

    // MARK: Unit Conversion

    private func longitudeDelta(from zoomLevel: CGFloat) -> CLLocationDegrees {
        return CLLocationDistance(360 * base.frame.width / (128 * exp2(zoomLevel)))
    }

    // MARK: Calculation

    private var bottomLongitudeDelta: CLLocationDegrees {
        let bottomCoordinates = bottomCoordinatesAtPrimeMeridian
        let bottomLongitudeDeltaHorizontalComponent = bottomCoordinates.southEast.longitude - bottomCoordinates.northWest.longitude
        let bottomLongitudeDelta = bottomLongitudeDeltaHorizontalComponent / cos(positiveHeading)
        return bottomLongitudeDelta
    }

    private var positiveHeading: CLLocationDirection {
        let bottomCoordinates = bottomCoordinatesAtPrimeMeridian

        let p1 = MKMapPoint(bottomCoordinates.northWest)
        let p2 = MKMapPoint(bottomCoordinates.southEast)

        let width = p2.x - p1.x
        let height = p2.y - p1.y
        let hypotenuse = hypot(width, height)

        let heading = asin(height / hypotenuse)

        return heading
    }

    /// 本初子午线底部坐标
    private var bottomCoordinatesAtPrimeMeridian: (northWest: CLLocationCoordinate2D,
                                                   southEast: CLLocationCoordinate2D) {
        let bottomRect = CGRect(x: 0, y: base.bounds.height, width: base.bounds.width, height: 0)
        var region = base.convert(bottomRect, toRegionFrom: base)
        region.center.longitude = 0
        let northWestCoordinate = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta / 2),
                                                         longitude: region.center.longitude - (region.span.longitudeDelta / 2))
        let southEastCoordinate = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta / 2),
                                                         longitude: region.center.longitude + (region.span.longitudeDelta / 2))
        return (northWestCoordinate, southEastCoordinate)
    }
}

public extension AxcSpace where Base: MKMapView { }

// MARK: - 决策判断

public extension AxcSpace where Base: MKMapView { }
