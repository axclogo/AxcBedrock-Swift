//
//  AxcCameraEnum.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/12.
//

import UIKit
import AVFoundation
import CoreImage
import CoreLocation
import CoreMotion
import ImageIO
import MobileCoreServices
import Photos
import PhotosUI

public extension AxcCameraManager {
    /// 状态
    enum State {
        /// 准备好了
        case ready
        /// 拒绝访问
        case accessDenied
        /// 未找到设备
        case noDeviceFound
        /// 未知
        case unknow
    }
    /// 相机类型
    enum DeviceType {
        /// 前置
        case front
        /// 后置
        case back
    }
    /// 闪光模式
    enum FlashMode: Int {
        /// 关闭
        case off
        /// 开启
        case on
        /// 自动
        case auto
    }
    /// 输出流模式
    enum OutputMode {
        /// 图片
        case stillImage
        /// 带音频的视频
        case videoWithMic
        /// 仅视频
        case videoOnly
    }
    /// 捕获结果
    enum CaptureResult {
        /// 成功
        case success(content: CaptureContent)
        /// 失败
        case failure(Error)
        
        init(_ image: UIImage) { self = .success(content: .image(image)) }
        init(_ data: Data) { self = .success(content: .imageData(data)) }
        init(_ asset: PHAsset) { self = .success(content: .asset(asset)) }
        
        var imageData: Data? {
            if case let .success(content) = self {
                return content.asData
            } else {
                return nil
            }
        }
    }
    /// 捕获内容
    enum CaptureContent {
        /// 图片数据
        case imageData(Data)
        /// 图片
        case image(UIImage)
        /// PHAsset
        case asset(PHAsset)
    }
    /// 捕获错误
    enum CaptureError: Error {
        /// 没有图片数据
        case noImageData
        /// 无效图片数据
        case invalidImageData
        /// 没有视频连接
        case noVideoConnection
        /// 没有流
        case noSampleBuffer
        /// 没有存储
        case assetNotSaved
    }
}

extension AxcCameraManager.CaptureContent {
    public var asImage: UIImage? {
        switch self {
            case let .image(image): return image
            case let .imageData(data): return UIImage(data: data)
            case let .asset(asset):
                if let data = getImageData(fromAsset: asset) {
                    return UIImage(data: data)
                } else {
                    return nil
            }
        }
    }
    public var asData: Data? {
        switch self {
            case let .image(image): return image.jpegData(compressionQuality: 1.0)
            case let .imageData(data): return data
            case let .asset(asset): return getImageData(fromAsset: asset)
        }
    }
    private func getImageData(fromAsset asset: PHAsset) -> Data? {
        var imageData: Data?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            imageData = data
        }
        return imageData
    }
}
