//
//  AxcUIDeviceOrientationEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/28.
//

#if canImport(UIKit)

import UIKit

// MARK: - UIDeviceOrientation + AxcSpaceProtocol

extension UIDeviceOrientation: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == UIDeviceOrientation {
    var uiInterfaceOrientation: UIInterfaceOrientation {
        switch base {
        case .portrait, .faceUp, .faceDown:
            return .portrait
        case .portraitUpsideDown: // 如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown,则视频方向和拍摄时的方向是相反的。
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        default:
            return .unknown
        }
    }

    /// 转换成 UIImage.Orientation
    var uiImageOrientation: UIImage.Orientation {
        switch base {
        case .portraitUpsideDown:
            return .left
        case .landscapeLeft:
            return .up
        case .landscapeRight:
            return .down
        default:
            return .right
        }
    }

    /// 转换成 UIImage.Orientation的镜像
    var uiImageOrientationMirrored: UIImage.Orientation {
        switch base {
        case .portraitUpsideDown:
            return .left
        case .landscapeLeft:
            return .down
        case .landscapeRight:
            return .up
        default:
            return .right
        }
    }
}

// MARK: - To->AVFoundation

#if canImport(AVFoundation)
import AVFoundation

public extension AxcSpace where Base == UIDeviceOrientation {
    /// 转换成 AVCaptureVideoOrientation
    @available(macCatalyst 14.0, *)
    var avCaptureVideoOrientation: AVCaptureVideoOrientation {
        switch base {
        case .portrait, .faceUp, .faceDown:
            return .portrait
        case .portraitUpsideDown: // 如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown,则视频方向和拍摄时的方向是相反的。
            return .portrait
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        default:
            return .portrait
        }
    }
}
#endif

// MARK: - 类方法

public extension AxcSpace where Base == UIDeviceOrientation { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == UIDeviceOrientation { }

// MARK: - 决策判断

public extension AxcSpace where Base == UIDeviceOrientation { }

#endif
