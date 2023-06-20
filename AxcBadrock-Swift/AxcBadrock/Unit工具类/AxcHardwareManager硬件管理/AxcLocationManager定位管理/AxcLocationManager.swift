//
//  AxcLocationManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/14.
//

import UIKit
import CoreLocation

// MARK: - CameraLocationManager()

open class CameraLocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var latestLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.headingFilter = 5.0
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    open func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    open func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    open func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Pick the location with best (= smallest value) horizontal accuracy
        latestLocation = locations.sorted { $0.horizontalAccuracy < $1.horizontalAccuracy }.first
    }
    
    open func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
}
