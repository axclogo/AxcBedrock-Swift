////
////  AxcCameraManager.swift
////  AxcBadrock-Swift
////
////  Created by 赵新 on 2021/3/12.
////
//
//import UIKit
//import AVFoundation
//import CoreImage
//import CoreLocation
//import CoreMotion
//import ImageIO
//import MobileCoreServices
//import Photos
//import PhotosUI
//
//public extension AxcCameraManager {
//
//}
//
//public class AxcCameraManager: NSObject,
//                               AVCaptureFileOutputRecordingDelegate,
//                               UIGestureRecognizerDelegate {
//    // MARK: - Api
//    // MARK: 属性
//    /// 自定义图像相册名称
//    var axc_imageAlbumName: String?
//
//    /// 自定义视频相册名称
//    var axc_videoAlbumName: String?
//
//    /// 自定义相机会话
//    var axc_captureSession: AVCaptureSession?
//
    /// 管理器显示错误
    /// 如果你想自己显示错误，设置为false
    /// 如果你想添加自定义错误UI设置showErrorBlock属性。
    /// 默认 false
//    var axc_showErrorsToUsers = false
//
//    /// 是否应该在需要时立即弹出显示相机权限，控制是否手动显示它。默认 true
//    /// 因为使用相机需要许可，如果你设置这个值为false，不手动询问，你将不能使用相机。
//    var axc_showAccessPermissionPopupAutomatically = true
//
//    / 一个创建UI以向用户显示错误消息的Block
//    / 这可以被定制为在窗口根视图控制器上显示，或者传入viewController，它将显示UIAlertController
//    / 默认示例
//    var axc_showErrorBlock: (_ errorTitle: String, _ errorMessage: String) -> Void
//        = { (title, msg) -> Void in
//            var alertVC = UIAlertController(title: title, msg: msg, actionTitles: [AxcBadrockLanguage("确定")])
//            alertVC.axc_show()
//        }
//
//    /// 是否应将资源写入媒体库 默认 true
//    var axc_writeFilesToPhoneLibrary = true
//
//    /// 是否应该适配设备方向 默认 true
//    var axc_autoOrientation = true {
//        didSet { axc_autoOrientation ? startFollowingDeviceOrientation() : stopFollowingDeviceOrientation() }
//    }
//    /// 是否水平翻转前置摄像头拍摄的图像  默认 false
//    var axc_flipFrontCameraImage = false
//    /// 当方向改变时，是否应该保持视图的相同边界 默认 false
//    var shouldKeepViewAtOrientationChanges = false
//
//    /// 是否启用点击手势聚焦相机预览 默认 true
//    var axc_enableTapToFocus = true { didSet { focusGesture.isEnabled = axc_enableTapToFocus } }
//    /// 是否启用手势缩放功能 默认 true
//    var axc_enablePinchToZoom = true { didSet { zoomGesture.isEnabled = axc_enablePinchToZoom } }
//    /// 是否启用上下滑动手势改变曝光/亮度 默认 true
//    var axc_enableExposure = true { didSet { exposureGesture.isEnabled = axc_enableExposure } }
//
//    /// 相机是否可以使用
//    var axc_isCameraReady: Bool { return cameraIsSetup }
//
//    /// 是否具有前置摄像头
//    var axc_isHasFrontCamera: Bool { return AVCaptureDevice.axc_isHasCamera(type: .front) }
//    /// 是否具有后置摄像头
//    var axc_isHasBackCamera: Bool { return AVCaptureDevice.axc_isHasCamera(type: .back) }
//    /// 是否具有闪光灯
//    var axc_isHasFlash: Bool { return AVCaptureDevice.axc_isHasFlash }
//
//    /// 是否启用前后摄像头切换时的翻转动画 默认 true
//    var axc_switchCameraAnimation: Bool = true
//    /// 是否启用快门动画 默认 true
//    open var axc_shutterAnimation: Bool = true
//
//    /// 是否启用位置服务
//    /// 相机中的位置服务用于EXIF数据
//    var axc_useLocationServices: Bool = false {
//       didSet {
//           if axc_useLocationServices {
//               self.locationManager = CameraLocationManager()
//           }
//       }
//   }
//
//    /// 前置和后置之间更改的相机设备
//    var axc_cameraDevice: DeviceType = .back {
//        didSet {
//            if cameraIsSetup, axc_cameraDevice != oldValue {
//                if animateCameraDeviceChange {
//                    _doFlipAnimation()
//                }
//                _updateCameraDevice(axc_cameraDevice)
//                _updateIlluminationMode(flashMode)
//                _setupMaxZoomScale()
//                _zoom(0)
//                _orientationChanged()
//            }
//        }
//    }
//    /// 闪光灯模式
//    var axc_flashMode: FlashMode = .off {
//        didSet {
//            if cameraIsSetup && axc_flashMode != oldValue {
//                _updateIlluminationMode(axc_flashMode)
//            }
//        }
//    }
//    /// 相机输出质量
//    var axc_cameraOutputQuality: AVCaptureSession.Preset = .high {
//        didSet {
//            if cameraIsSetup && axc_cameraOutputQuality != oldValue {
//                _updateCameraQualityMode(axc_cameraOutputQuality)
//            }
//        }
//    }
//    /// 更改相机输出
//    var axc_outputMode: OutputMode = .stillImage {
//        didSet {
//            if cameraIsSetup {
//                if axc_outputMode != oldValue {
//                    _setupOutputMode(axc_outputMode, oldCameraOutputMode: oldValue)
//                }
//                _setupMaxZoomScale()
//                _zoom(0)
//            }
//        }
//    }
//    /// 正在录制的视频时长
//    var axc_recordedDuration: CMTime { return movieOutput?.recordedDuration ?? CMTime.zero }
//
//    /// 正在录制的视频文件大小
//    var axc_recordedFileSize: Int64 { return movieOutput?.recordedFileSize ?? 0 }
//
//    /// 焦点模式
//    var axc_focusMode: AVCaptureDevice.FocusMode = .continuousAutoFocus
//
//    /// 曝光模式时，点击对焦
//    var axc_exposureMode: AVCaptureDevice.ExposureMode = .continuousAutoExposure
//
//    /// 在录制视频时，设置视频稳定模式
//    var axc_videoStabilisationMode: AVCaptureVideoStabilizationMode = .auto {
//        didSet {
//            if axc_videoStabilisationMode != oldValue {
//                _setupVideoConnection()
//            }
//        }
//    }
//    /// 获取当前处于活动状态的稳定模式
//    var activeVideoStabilisationMode: AVCaptureVideoStabilizationMode {
//        if let movieOutput = movieOutput {
//            for connection in movieOutput.connections {
//                for port in connection.inputPorts {
//                    if port.mediaType == AVMediaType.video {
//                        let videoConnection = connection as AVCaptureConnection
//                        return videoConnection.activeVideoStabilizationMode
//                    }
//                }
//            }
//        }
//
//        return .off
//    }
//
//    // MARK: 方法
//    /// 是否已经设置过
//    func axc_canSetPreset(preset: AVCaptureSession.Preset) -> Bool? {
//        if let validCaptureSession = axc_captureSession {
//            return validCaptureSession.canSetSessionPreset(preset)
//        }
//        return nil
//    }
//
//    /// 初始化一个捕获会话，并向给定视图添加一个预览层
//    /// 预览层边界将自动设置为与给定视图匹配。默认会话初始化静态图像输出。
//    /// - Parameter view: 要添加预览层的视图
//    /// - Returns: 摄像机的当前状态
//    @discardableResult
//
//    func addPreviewLayerToView(_ view: UIView) -> State {
//        return addPreviewLayerToView(view, newCameraOutputMode: cameraOutputMode)
//    }
//
//    // MARK: 私有
//    private var locationManager: CameraLocationManager?
//
//    private weak var embeddingView: UIView?
//    private var videoCompletion: ((_ videoURL: URL?, _ error: NSError?) -> Void)?
//
//    private var sessionQueue: DispatchQueue = DispatchQueue(label: "CameraSessionQueue", attributes: [])
//
//    private lazy var frontCameraDevice: AVCaptureDevice? = {
//        AVCaptureDevice.videoDevices.filter { $0.position == .front }.first
//    }()
//
//    private lazy var backCameraDevice: AVCaptureDevice? = {
//        AVCaptureDevice.videoDevices.filter { $0.position == .back }.first
//    }()
//
//    private lazy var mic: AVCaptureDevice? = {
//        AVCaptureDevice.default(for: AVMediaType.audio)
//    }()
//
//    private var stillImageOutput: AVCaptureStillImageOutput?
//    private var movieOutput: AVCaptureMovieFileOutput?
//    private var previewLayer: AVCaptureVideoPreviewLayer?
//    private var library: PHPhotoLibrary?
//
//    private var cameraIsSetup = false
//    private var cameraIsObservingDeviceOrientation = false
//
//    private var zoomScale = CGFloat(1.0)
//    private var beginZoomScale = CGFloat(1.0)
//    private var maxZoomScale = CGFloat(1.0)
//
//    private func tempFilePath() -> URL {
//        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("tempMovie\(Date().timeIntervalSince1970)").appendingPathExtension("mp4")
//        return tempURL
//    }
//
//    fileprivate var coreMotionManager: CMMotionManager!
//
//    /// Real device orientation from DeviceMotion
//    fileprivate var deviceOrientation: UIDeviceOrientation = .portrait
//
//    /// 开启设备方向获取
//    private func startFollowingDeviceOrientation() {
//        if axc_autoOrientation, !cameraIsObservingDeviceOrientation {
//            coreMotionManager = CMMotionManager()
//            coreMotionManager.deviceMotionUpdateInterval = 1 / 30.0
//            if coreMotionManager.isDeviceMotionAvailable {
//                coreMotionManager.startDeviceMotionUpdates(to: OperationQueue()) { motion, _ in
//                    guard let motion = motion else { return }
//                    let x = motion.gravity.x
//                    let y = motion.gravity.y
//                    let previousOrientation = self.deviceOrientation
//                    if fabs(y) >= fabs(x) {
//                        if y >= 0 {
//                            self.deviceOrientation = .portraitUpsideDown
//                        } else {
//                            self.deviceOrientation = .portrait
//                        }
//                    } else {
//                        if x >= 0 {
//                            self.deviceOrientation = .landscapeRight
//                        } else {
//                            self.deviceOrientation = .landscapeLeft
//                        }
//                    }
//                    if previousOrientation != self.deviceOrientation {
//                        self._orientationChanged()
//                    }
//                }
//
//                cameraIsObservingDeviceOrientation = true
//            } else {
//                cameraIsObservingDeviceOrientation = false
//            }
//        }
//    }
//    /// 关闭设备方向
//    private func stopFollowingDeviceOrientation() {
//        if cameraIsObservingDeviceOrientation {
//            coreMotionManager.stopDeviceMotionUpdates()
//            cameraIsObservingDeviceOrientation = false
//        }
//    }
//}
