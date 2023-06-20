//
//  File.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/12.
//

import UIKit
import AVFoundation

extension AVCaptureDevice {
    /// 是否有摄像头
    /// - Parameter type: 摄像头类型
    /// - Returns: Bool
    static func axc_isHasCamera(type: AxcCameraManager.DeviceType) -> Bool {
        let devices = axc_videoDevices()
        switch type {
        case .back:
            let backDevices = devices.filter { $0.position == .back }
            return !backDevices.isEmpty
        case .front:
            let frontDevices = devices.filter { $0.position == .front }
            return !frontDevices.isEmpty
        }
    }
    
    /// 是否有闪光灯
    static var axc_isHasFlash: Bool {
        let flashDevices = axc_videoDevices().filter { $0.hasFlash }
        return !flashDevices.isEmpty
    }
    
    /// 获取设备列表
    /// - Parameters:
    ///   - position: 点位
    ///   - mediaType: 媒体类型
    /// - Returns: 设备列表
    static func axc_videoDevices(mediaType: AVMediaType = .video) -> [AVCaptureDevice] {
        if #available(iOS 10.0, *) {
            let frontDevices = DiscoverySession(deviceTypes: [.builtInWideAngleCamera ], mediaType: mediaType, position: .front).devices
            let backDevices = DiscoverySession(deviceTypes: [.builtInWideAngleCamera ], mediaType: mediaType, position: .back).devices
            return frontDevices + backDevices
        }else{
            return AVCaptureDevice.devices(for: mediaType)
        }
    }
}
