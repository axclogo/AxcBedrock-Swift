//
//  AxcAVCaptureDeviceEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/24.
//

import AVFoundation

// MARK: - 数据转换

public extension AxcSpace where Base: AVCaptureDevice { }

// MARK: - 类方法

public extension AxcSpace where Base: AVCaptureDevice {
    /// 获取设备列表
    /// - Parameters:
    ///   - mediaType: 媒体类型
    /// - Returns: 设备列表
    static func Devices(mediaType: AVMediaType) -> [AVCaptureDevice] {
        if #available(iOS 10.0, *) {
            // 获取输入设备
            // builtInWideAngleCamera是通用相机
            // AVMediaType.video代表视频媒体
            var deviceTypes: [AVCaptureDevice.DeviceType] = [
                .builtInMicrophone, // 麦克风
                .builtInWideAngleCamera, // 通用相机/广角相机
            ]
            #if os(macOS)
            if #available(macOS 13.0, *) {
                deviceTypes.append(.deskViewCamera) // 桌面相机
            }
            #elseif os(iOS)
            deviceTypes.append(.builtInTelephotoCamera) // 长焦相机
            if #available(iOS 10.2, *) {
                deviceTypes.append(.builtInDualCamera) // 双摄相机
            }
            if #available(iOS 11.1, *) {
                deviceTypes.append(.builtInTrueDepthCamera) // 深度相机
            }
            if #available(iOS 13.0, *) {
                deviceTypes = deviceTypes.axc.append([
                    .builtInUltraWideCamera, // 全景超宽相机
                    .builtInDualWideCamera, // 全景双宽相机
                    .builtInTripleCamera, // 三倍相机
                ])
            }
            #endif

            // back表示前置摄像头,如果需要后置摄像头修改为front
            // 这里获取前后所有的设备
            let frontDevices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                                mediaType: mediaType,
                                                                position: .front).devices
            let backDevices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes,
                                                               mediaType: mediaType,
                                                               position: .back).devices
            return frontDevices + backDevices
        } else {
            return AVCaptureDevice.devices(for: mediaType)
        }
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AVCaptureDevice {
    /// 对设备进行操作
    /// 呼叫控制硬件加锁
    /// - Parameter config: 配置代码块
    func configuration(_ config: AxcBlock.Empty) {
        do {
            try base.lockForConfiguration()
            config()
            base.unlockForConfiguration()
        } catch let err {
            let log = "操作设备失败！\n\(err.localizedDescription)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #endif
        }
    }
}

// MARK: - To->UIKit

#if canImport(UIKit)

public extension AxcSpace where Base: AVCaptureDevice {
    /// 设置曝光量
    /// - Parameter bias: 曝光补偿量
    func setExposure(bias: CGFloat) {
        var floatBias = Float(bias)
        if floatBias > base.maxExposureTargetBias {
            floatBias = base.maxExposureTargetBias
        } else if floatBias < base.minExposureTargetBias {
            floatBias = base.minExposureTargetBias
        }
        configuration {
            base.setExposureTargetBias(floatBias, completionHandler: nil)
        }
    }
}
#endif

// MARK: - 决策判断

public extension AxcSpace where Base: AVCaptureDevice { }
