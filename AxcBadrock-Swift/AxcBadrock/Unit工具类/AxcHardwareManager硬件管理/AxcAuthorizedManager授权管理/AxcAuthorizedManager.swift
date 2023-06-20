//
//  AxcAuthorizedManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/14.
//

//import UIKit
//import AVFoundation
//import Photos
//import AssetsLibrary
//import CoreTelephony
//import Contacts
//import AddressBook
//
//public extension AxcAuthorizedManager {
//    /// 授权状态
//    enum Status {
//        /// 授权访问
//        case authorized
//        /// 拒绝访问
//        case denied
//        /// 限制访问，用户不能改变客户机的状态,可能由于活跃的限制,如家长控制
//        case restricted
//        /// 尚未选择，表明用户尚未选择关于客户端是否可以访问硬件
//        case notDetermined
//        /// 未知
//        case unknow
//    }
//}
//
///// 权限管理
//open class AxcAuthorizedManager: NSObject, CLLocationManagerDelegate {
//    /// 单例实例化
//    public static let shared: AxcAuthorizedManager = {
//        let manager = AxcAuthorizedManager()
//        manager.config() // 配置
//        return manager
//    }()
//    open func config() {
//        locationManager.delegate = self
//    }
//
//    // MARK: 摄像头
//    /// 获取摄像头权限
//    open func axc_cameraAuthStatus() -> Status {
//        var status: Status = .unknow
//        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
//        switch authStatus {
//        case .authorized:       status = .authorized
//        case .restricted:       status = .restricted
//        case .denied:           status = .denied
//        case .notDetermined:    status = .notDetermined
//        @unknown default:       status = .unknow
//        }
//        return status
//    }
//    /// 申请相机权限
//    /// - Parameter block: 成功还是失败
//    open func axc_applyCameraAuth(_ block: AxcBoolBlock?) {
//        AVCaptureDevice.requestAccess(for: .video) { (granted) in
//            block?(granted)
//        }
//    }
//
//    // MARK: 麦克风
//    /// 获取麦克风权限
//    open func axc_micAuthStatus() -> Status {
//        var status: Status = .unknow
//        let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
//        switch authStatus {
//        case .authorized:       status = .authorized
//        case .restricted:       status = .restricted
//        case .denied:           status = .denied
//        case .notDetermined:    status = .notDetermined
//        @unknown default:       status = .unknow
//        }
//        return status
//    }
//    /// 申请麦克风权限
//    /// - Parameter block: 成功还是失败
//    open func axc_applyMicAuth(_ block: AxcBoolBlock?) {
//        AVCaptureDevice.requestAccess(for: .audio) { (granted) in
//            block?(granted)
//        }
//    }
//
//    // MARK: 相册
//    /// 获取相册权限
//    open func axc_photoLibAuthStatus() -> Status {
//        var status: Status = .unknow
//        if #available(iOS 10.0, *) {
//            let authStatus = PHPhotoLibrary.authorizationStatus()
//            switch authStatus {
//            case .authorized:       status = .authorized
//            case .limited:          status = .authorized
//            case .restricted:       status = .restricted
//            case .denied:           status = .denied
//            case .notDetermined:    status = .notDetermined
//            @unknown default:       status = .unknow
//            }
//        } else {
//            let authStatus = ALAssetsLibrary.authorizationStatus()
//            switch authStatus {
//            case .authorized:       status = .authorized
//            case .restricted:       status = .restricted
//            case .denied:           status = .denied
//            case .notDetermined:    status = .notDetermined
//            @unknown default:       status = .unknow
//            }
//        }
//        return status
//    }
//    /// 申请相册权限
//    /// - Parameter block: 成功还是失败
//    open func axc_applyPhotoLibAuth(_ block: AxcBoolBlock?) {
//        PHPhotoLibrary.requestAuthorization { (status) in
//            let granted = !(status != .authorized)
//            block?(granted)
//        }
//    }
//
//    // MARK: 定位
//    /// 获取定位权限
//    open func axc_locationAuthStatus() -> Status {
//        if !CLLocationManager.locationServicesEnabled() { return .denied }   // 手机的定位权限
//        var status: Status = .unknow    // 应用的定位权限
//        let authStatus = CLLocationManager.authorizationStatus()
//        switch authStatus {
//        case .authorizedAlways:    status = .authorized
//        case .authorizedWhenInUse: status = .authorized
//        case .denied:              status = .denied
//        case .notDetermined:       status = .notDetermined
//        case .restricted:          status = .restricted
//        @unknown default:          status = .unknow
//        }
//        return status
//    }
//    /// 申请一直定位权限
//    open func axc_applyLocationAlwaysAuth(_ block: AxcBoolBlock?) {
//        applyLocationAuthBlock = block
//        locationManager.requestAlwaysAuthorization()    // 申请一直
//    }
//    /// 申请使用中定位权限
//    open func axc_applyLocationInUseAuth(_ block: AxcBoolBlock?) {
//        applyLocationAuthBlock = block
//        locationManager.requestWhenInUseAuthorization() // 申请使用中
//    }
//
//    /// 位置管理
//    private let locationManager = CLLocationManager()
//    /// 定位回调Block
//    private var applyLocationAuthBlock: AxcBoolBlock?
//    /// 代理回调转Block回调
//    open func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        let granted = (status == .authorizedAlways || status == .authorizedWhenInUse)
//        applyLocationAuthBlock?( granted )
//    }
//
//    // MARK: 通讯录
//    /// 获取通讯录权限
//    open func axc_contactAuthStatus() -> Status {
//        var status: Status = .unknow
//        if #available(iOS 10.0, *) {
//            let authStatus = CNContactStore.authorizationStatus(for: .contacts)
//            switch authStatus {
//            case .authorized:       status = .authorized
//            case .restricted:       status = .restricted
//            case .denied:           status = .denied
//            case .notDetermined:    status = .notDetermined
//            @unknown default:       status = .unknow
//            }
//        }else {
//            let authStatus = ABAddressBookGetAuthorizationStatus()
//            switch authStatus {
//            case .authorized:       status = .authorized
//            case .restricted:       status = .restricted
//            case .denied:           status = .denied
//            case .notDetermined:    status = .notDetermined
//            @unknown default:       status = .unknow
//            }
//        }
//        return status
//    }
//    /// 申请通讯录权限
//    open func axc_applyContactAuth(_ block: AxcBoolBlock?) {
//        if #available(iOS 10.0, *) {
//            let contact = CNContactStore()
//            contact.requestAccess(for: .contacts) { (granted, error) in
//                block?(granted)
//            }
//        }else {
//            let addressBook = ABAddressBookCreateWithOptions(nil, nil)
//            ABAddressBookRequestAccessWithCompletion(addressBook as ABAddressBook) { (granted, error) in
//                block?(granted)
//            }
//        }
//    }
//
//    // MARK: 网络
//    /// 获取网络权限
//    open func axc_netWorkAuthStatus() -> Status {
//        var status: Status = .unknow
//        let state = CTCellularData().restrictedState
//        switch state {
//        case .restrictedStateUnknown:   status = .unknow
//        case .restricted:               status = .authorized
//        case .notRestricted:            status = .notDetermined
//        @unknown default:               status = .unknow
//        }
//        return status
//    }
//
//
//    // MARK: 推送
////    func axc_notificationAuthStatus() -> Status {
////        if #available(iOS 10.0, *) {
////            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
////                switch settings.authorizationStatus.rawValue {
////                case 0:
////                    print("not authorized")
////                default:
////                    print("authorized")
////                }
////            }
////        }else {
////            guard let settings = UIApplication.shared.currentUserNotificationSettings else { return .notDetermined }
////            switch settings.types.rawValue {
////            case 0:  return .denied
////            default: return .authorized
////            }
////        }
////    }
//    #warning("IDFA")
//}
