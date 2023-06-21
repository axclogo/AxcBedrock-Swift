//
//  AxcUIInterfaceOrientationEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/7/11.
//

#if canImport(UIKit)

import UIKit

// MARK: - UIInterfaceOrientation + AxcSpaceProtocol

extension UIInterfaceOrientation: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == UIInterfaceOrientation {
    /// 转换成 UIImage.Orientation
    var uiImageOrientation: UIImage.Orientation {
        switch base {
        case .portrait:
            return .up
        case .portraitUpsideDown:
            return .down
        case .landscapeLeft:
            return .left
        case .landscapeRight:
            return .right
        default:
            return .up
        }
    }

    /// 转换成 UIImage.Orientation的镜像
    var uiImageOrientationMirrored: UIImage.Orientation {
        switch base {
        case .portrait:
            return .down
        case .portraitUpsideDown:
            return .up
        case .landscapeLeft:
            return .right
        case .landscapeRight:
            return .left
        default:
            return .up
        }
    }
}

// MARK: - To->AVFoundation

#if canImport(AVFoundation)
import AVFoundation

public extension AxcSpace where Base == UIInterfaceOrientation {
    /// 转换成 AVCaptureVideoOrientation
    @available(macCatalyst 14.0, *)
    var avCaptureVideoOrientation: AVCaptureVideoOrientation {
        switch base {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
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

public extension AxcSpace where Base == UIInterfaceOrientation { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == UIInterfaceOrientation { }

// MARK: - 决策判断

public extension AxcSpace where Base == UIInterfaceOrientation { }

#endif
