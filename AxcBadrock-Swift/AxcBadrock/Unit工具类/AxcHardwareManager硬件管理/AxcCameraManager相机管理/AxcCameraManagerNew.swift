//
//  AxcCameraManagerNew.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/14.
//

import AVFoundation
import CoreImage
import CoreMotion
import ImageIO
import MobileCoreServices
import Photos
import PhotosUI
import UIKit

public class AxcCameraManager: NSObject, AVCaptureFileOutputRecordingDelegate, UIGestureRecognizerDelegate {
    // MARK: - Api
    // MARK: 属性
    /// 自定义图像相册名称
    var axc_imageAlbumName: String?
    
    /// 自定义视频相册名称
    var axc_videoAlbumName: String?
    
    /// 自定义相机会话
    var axc_captureSession: AVCaptureSession?
    
    /// 管理器显示错误
    /// 如果自己显示错误，设置为false
    /// 如果添加自定义错误UI设置axc_showErrorsToUsers属性。
    /// 默认 false
    var axc_showErrorsToUsers = false
    
    /// 是否应该在需要时立即弹出显示相机权限，控制是否手动显示它。默认 true
    /// 因为使用相机需要许可，如果你设置这个值为false，不手动询问，你将不能使用相机。
    var axc_autoPopAccessPermission = true
    
    /// 一个创建UI以向用户显示错误消息的Block
    /// 这可以被定制为在窗口根视图控制器上显示，或者传入viewController，它将显示UIAlertController
    var axc_showErrorBlock: (_ title: String, _ msg: String) -> Void
        = { (title, msg) -> Void in
            var alertVC = UIAlertController(title: title, msg: msg, actionTitles: [AxcBadrockLanguage("确定")])
            alertVC.axc_show()
        }
    
    /// 是否应将资源写入沙盒目录 默认 true
    var axc_writeFilesToPhoneLibrary = true
    
    /// 是否应该适配设备方向 默认 true
    var axc_autoOrientation = true {
        didSet { axc_autoOrientation ? startFollowingDeviceOrientation() : stopFollowingDeviceOrientation() }
    }
    /// 是否水平翻转前置摄像头拍摄的图像  默认 false
    var axc_flipFrontCameraImage = false
    /// 当方向改变时，是否应该保持视图的相同边界 默认 false
    var axc_keepViewAutoOrientation = false
    
    
    /// 是否启用点击手势聚焦相机预览 默认 true
    var axc_enableTapToFocus = true { didSet { focusGesture.isEnabled = axc_enableTapToFocus } }
    /// 是否启用手势缩放功能 默认 true
    var axc_enablePinchToZoom = true { didSet { zoomGesture.isEnabled = axc_enablePinchToZoom } }
    /// 是否启用上下滑动手势改变曝光/亮度 默认 true
    var axc_enableExposure = true { didSet { exposureGesture.isEnabled = axc_enableExposure } }
    
    
    /// 相机是否可以使用
    var axc_isCameraReady: Bool { return cameraIsSetup }
    /// 是否具有前置摄像头
    var axc_isHasFrontCamera: Bool { return AVCaptureDevice.axc_isHasCamera(type: .front) }
    /// 是否具有后置摄像头
    var axc_isHasBackCamera: Bool { return AVCaptureDevice.axc_isHasCamera(type: .back) }
    /// 是否具有闪光灯
    var axc_isHasFlash: Bool { return AVCaptureDevice.axc_isHasFlash }
    
    
    /// 是否启用前后摄像头切换时的翻转动画 默认 true
    var axc_switchCameraAnimation: Bool = true
    /// 是否启用快门动画 默认 true
    var axc_shutterAnimation: Bool = true
    
    /// 是否启用位置服务
    /// 相机中的位置服务用于EXIF数据
    var axc_useLocationServices: Bool = false {
        didSet { if axc_useLocationServices { self.locationManager = CameraLocationManager() } }
    }
    
    /// 前置和后置之间更改的相机设备
    var axc_cameraDevice: DeviceType = .back {
        didSet {
            if cameraIsSetup, axc_cameraDevice != oldValue {
                if axc_switchCameraAnimation {
                    _doFlipAnimation()
                }
                _updateDeviceType(axc_cameraDevice)
                _updateIlluminationMode(axc_flashMode)
                _setupMaxZoomScale()
                axc_zoom(0)
                _orientationChanged()
            }
        }
    }
    
    /// 闪光灯模式
    var axc_flashMode: FlashMode = .off {
        didSet {
            if cameraIsSetup && axc_flashMode != oldValue {
                _updateIlluminationMode(axc_flashMode)
            }
        }
    }
    
    /// 相机输出质量
    var axc_cameraOutputQuality: AVCaptureSession.Preset = .high {
        didSet {
            if cameraIsSetup && axc_cameraOutputQuality != oldValue {
                _updateCameraQualityMode(axc_cameraOutputQuality)
            }
        }
    }
    
    /// 更改相机输出
    var axc_outputMode: OutputMode = .stillImage {
        didSet {
            if cameraIsSetup {
                if axc_outputMode != oldValue {
                    _setupOutputMode(axc_outputMode, oldOutputMode: oldValue)
                }
                _setupMaxZoomScale()
                axc_zoom(0)
            }
        }
    }
    
    /// 正在录制的视频时长
    var axc_recordedDuration: CMTime { return movieOutput?.recordedDuration ?? CMTime.zero }
    /// 正在录制的视频文件大小
    var axc_recordedFileSize: Int64 { return movieOutput?.recordedFileSize ?? 0 }
    /// 焦点模式
    var axc_focusMode: AVCaptureDevice.FocusMode = .continuousAutoFocus
    /// 曝光模式时，点击对焦
    var axc_exposureMode: AVCaptureDevice.ExposureMode = .continuousAutoExposure
    /// 在录制视频时，设置视频稳定模式
    var axc_videoStabilisationMode: AVCaptureVideoStabilizationMode = .auto {
        didSet {
            if oldValue != axc_videoStabilisationMode {
                _setupVideoConnection()
            }
        }
    }
    
    /// 获取当前处于活动状态的稳定模式
    var axc_activeVideoStabilisationMode: AVCaptureVideoStabilizationMode {
        if let movieOutput = movieOutput {
            for connection in movieOutput.connections {
                for port in connection.inputPorts {
                    if port.mediaType == AVMediaType.video {
                        let videoConnection = connection as AVCaptureConnection
                        return videoConnection.activeVideoStabilizationMode
                    }
                }
            }
        }
        
        return .off
    }
    
    // MARK: 私有
    /// 定位管理
    private var locationManager: CameraLocationManager?
    /// 嵌入视图
    private weak var embeddingView: UIView?
    /// 视频回调
    private var videoCompletion: ((_ videoURL: URL?, _ error: NSError?) -> Void)?
    /// 会话线程
    private var sessionQueue: DispatchQueue = DispatchQueue(label: "CameraSessionQueue", attributes: [])
    /// 输出流
    @available(iOS, deprecated: 10.0)
    private var stillImageOutput: AVCaptureStillImageOutput?
    /// 视频文件输出
    private var movieOutput: AVCaptureMovieFileOutput?
    /// 预览Layer
    private var previewLayer: AVCaptureVideoPreviewLayer?
    /// 媒体库
    private var library: PHPhotoLibrary?
    /// 相机是否准备好
    private var cameraIsSetup = false
    /// 相机旋转
    private var cameraIsObservingDeviceOrientation = false
    /// 缩放
    private var zoomScale       = 1.axc_cgFloat
    /// 起始缩放
    private var beginZoomScale  = 1.axc_cgFloat
    /// 最大缩放
    private var maxZoomScale    = 1.axc_cgFloat
    /// 运动管理器
    private var coreMotionManager: CMMotionManager!
    /// 真实设备方向
    private var deviceOrientation: UIDeviceOrientation = .portrait
    /// 获取当前设备
    private var currentDevice: AVCaptureDevice? {
        let device: AVCaptureDevice?
        switch axc_cameraDevice {
        case .back:
            device = backDevice
        case .front:
            device = frontDevice
        }
        return device
    }
    // MARK: 懒加载
    /// 前置
    private lazy var frontDevice: AVCaptureDevice? = {
        AVCaptureDevice.axc_videoDevices().filter { $0.position == .front }.first
    }()
    /// 后置
    private lazy var backDevice: AVCaptureDevice? = {
        AVCaptureDevice.axc_videoDevices().filter { $0.position == .back }.first
    }()
    /// 麦克风
    private lazy var mic: AVCaptureDevice? = {
        AVCaptureDevice.default(for: AVMediaType.audio)
    }()
    
    // MARK: 方法
    /// 是否设置了Preset
    func axc_canSetPreset(preset: AVCaptureSession.Preset) -> Bool? {
        if let validCaptureSession = axc_captureSession {
            return validCaptureSession.canSetSessionPreset(preset)
        }
        return nil
    }
    
    /// 初始化一个捕获会话，并向给定视图添加一个预览层
    /// 预览层边界将自动设置为与给定视图匹配。默认会话初始化静态图像输出。
    /// - Parameters:
    ///   - view: 添加预览层的视图
    ///   - newOutputMode: 新的输出类型
    ///   - completion: 完成回调
    /// - Returns: 摄像机的当前状态
    @discardableResult
    func axc_addLayerPreviewToView(_ view: UIView,
                                   newOutputMode: OutputMode? = nil,
                                   completion: AxcEmptyBlock?) -> State {
        var mode = axc_outputMode
        if let _mode = newOutputMode { mode = _mode }
        if _canLoadCamera() {
            if let _ = embeddingView {
                if let validPreviewLayer = previewLayer {
                    validPreviewLayer.removeFromSuperlayer()
                }
            }
            if cameraIsSetup {
                _addPreviewLayerToView(view)
                axc_outputMode = mode
                if let validCompletion = completion {
                    validCompletion()
                }
            } else {
                _setupCamera {
                    self._addPreviewLayerToView(view)
                    self.axc_outputMode = mode
                    if let validCompletion = completion {
                        validCompletion()
                    }
                }
            }
        }
        return _checkIfCameraIsAvailable()
    }
    
    /// 设置缩放
    func axc_zoom(_ scale: CGFloat) {
        let device = currentDevice
        do {
            let captureDevice = device
            try captureDevice?.lockForConfiguration()
            zoomScale = max(1.0, min(beginZoomScale * scale, maxZoomScale))
            captureDevice?.videoZoomFactor = zoomScale
            captureDevice?.unlockForConfiguration()
        } catch { AxcLog("错误配置",level: .warning) }
    }
    
    /// 询问用户相机权限
    /// 仅在权限尚未确定时有效
    /// 如果选择VideoWithMic输出，将自动询问麦克风权限
    /// - Parameter completion: 回调
    func axc_askUserForCameraPermission(_ completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (allowedAccess) -> Void in
            if self.axc_outputMode == .videoWithMic {
                AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: { (allowedAccess) -> Void in
                    AxcGCD.main { completion(allowedAccess) }
                })
            } else {
                AxcGCD.main { completion(allowedAccess) }
            }
        })
    }
    
    /// 停止运行会话，所有设置设备、输入和输出保留以供重用
    func axc_stopCaptureSession() {
        axc_captureSession?.stopRunning()
        stopFollowingDeviceOrientation()
    }
    
    /// 恢复会话
    @available(*, deprecated)
    func axc_resumeCaptureSession() {
        if let validCaptureSession = axc_captureSession {
            if !validCaptureSession.isRunning, cameraIsSetup {
                sessionQueue.async {
                    validCaptureSession.startRunning()
                    self.startFollowingDeviceOrientation()
                }
            }
        } else {
            if _canLoadCamera() {
                if cameraIsSetup {
                    axc_stopAndRemoveCaptureSession()
                }
                _setupCamera {
                    if let validEmbeddingView = self.embeddingView {
                        self._addPreviewLayerToView(validEmbeddingView)
                    }
                    self.startFollowingDeviceOrientation()
                }
            }
        }
    }
    
    /// 停止运行会话并删除所有设置设备、输入和输出
    @available(*, deprecated)
    func axc_stopAndRemoveCaptureSession() {
        axc_stopCaptureSession()
        let oldAnimationValue = axc_switchCameraAnimation
        axc_switchCameraAnimation = false
        axc_cameraDevice = .back
        cameraIsSetup = false
        previewLayer = nil
        axc_captureSession = nil
        frontDevice = nil
        backDevice = nil
        mic = nil
        stillImageOutput = nil
        movieOutput = nil
        axc_switchCameraAnimation = oldAnimationValue
    }
    
    /// 从当前运行的捕获会话捕获静态图像
    /// - Parameter imageCompletion: 回调Block
    @available(*, deprecated)
    func axc_capturePicture(_ imageCompletion: @escaping (UIImage?, NSError?) -> Void) {
        func completion(_ result: CaptureResult) {
            switch result {
            case let .success(content):
                imageCompletion(content.asImage, nil)
            case .failure:
                imageCompletion(nil, NSError())
            }
        }
        axc_capturePicture(completion)
    }
    
    /// 从当前运行的捕获会话捕获图像
    func axc_capturePicture(_ imageCompletion: @escaping (CaptureResult) -> Void) {
        capturePictureDataWithCompletion { [weak self] result in
            guard let weakSelf = self else { return }
            guard let imageData = result.imageData else {
                if case let .failure(error) = result {
                    imageCompletion(.failure(error))
                } else {
                    imageCompletion(.failure(CaptureError.noImageData))
                }
                return
            }
            if weakSelf.axc_shutterAnimation { // 快门动画
                weakSelf.shutterAnimation {
                    weakSelf.capturePicture(imageData, imageCompletion)
                }
            } else {
                weakSelf.capturePicture(imageData, imageCompletion)
            }
        }
    }
    /// 捕获图片
    private func capturePicture(_ imageData: Data, _ imageCompletion: @escaping (CaptureResult) -> Void) {
        guard let img = imageData.axc_image else {
            imageCompletion(.failure(NSError()))
            return
        }
        let image = fixOrientation(withImage: img)
        let newImageData = _imageDataWithEXIF(forImage: image, imageData)! as Data
        if axc_writeFilesToPhoneLibrary {   // 保存到媒体库
//            AxcCacheManager.shared.axc_saveFileCache(newImageData, key: <#T##String#>)
            
            let filePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("tempImg\(Int(Date().timeIntervalSince1970)).jpg")
            
            do {
                try newImageData.write(to: filePath)
                
                // make sure that doesn't fail the first time
                if PHPhotoLibrary.authorizationStatus() != .authorized {
                    PHPhotoLibrary.requestAuthorization { status in
                        if status == PHAuthorizationStatus.authorized {
                            self._saveImageToLibrary(atFileURL: filePath, imageCompletion)
                        }
                    }
                } else {
                    _saveImageToLibrary(atFileURL: filePath, imageCompletion)
                }
                
            } catch {
                imageCompletion(.failure(error))
                return
            }
        }
        
        imageCompletion(CaptureResult(newImageData))
    }
    
    private func _setVideoWithGPS(forLocation location: CLLocation) {
        let metadata = AVMutableMetadataItem()
        metadata.keySpace = AVMetadataKeySpace.quickTimeMetadata
        metadata.key = AVMetadataKey.quickTimeMetadataKeyLocationISO6709 as NSString
        metadata.identifier = AVMetadataIdentifier.quickTimeMetadataLocationISO6709
        metadata.value = String(format: "%+09.5f%+010.5f%+.0fCRSWGS_84", location.coordinate.latitude, location.coordinate.longitude, location.altitude) as NSString
        _getMovieOutput().metadata = [metadata]
    }
    
    private func _imageDataWithEXIF(forImage _: UIImage, _ data: Data) -> NSData? {
        let cfdata: CFData = data as CFData
        let source = CGImageSourceCreateWithData(cfdata, nil)!
        let UTI: CFString = CGImageSourceGetType(source)!
        let mutableData: CFMutableData = NSMutableData(data: data) as CFMutableData
        let destination = CGImageDestinationCreateWithData(mutableData, UTI, 1, nil)!
        
        let imageSourceRef = CGImageSourceCreateWithData(cfdata, nil)
        let imageProperties = CGImageSourceCopyMetadataAtIndex(imageSourceRef!, 0, nil)!
        
        var mutableMetadata = CGImageMetadataCreateMutableCopy(imageProperties)!
        
        if let location = locationManager?.latestLocation {
            mutableMetadata = _gpsMetadata(mutableMetadata, withLocation: location)
        }
        
        let finalMetadata: CGImageMetadata = mutableMetadata
        CGImageDestinationAddImageAndMetadata(destination, UIImage(data: data)!.cgImage!, finalMetadata, nil)
        CGImageDestinationFinalize(destination)
        return mutableData
    }
    
    private func _gpsMetadata(_ imageMetadata: CGMutableImageMetadata, withLocation location: CLLocation) -> CGMutableImageMetadata {
        let altitudeRef = Int(location.altitude < 0.0 ? 1 : 0)
        let latitudeRef = location.coordinate.latitude < 0.0 ? "S" : "N"
        let longitudeRef = location.coordinate.longitude < 0.0 ? "W" : "E"
        
        let f = DateFormatter()
        f.timeZone = TimeZone(abbreviation: "UTC")
        
        f.dateFormat = "yyyy:MM:dd"
        let isoDate = f.string(from: location.timestamp)
        
        f.dateFormat = "HH:mm:ss.SSSSSS"
        let isoTime = f.string(from: location.timestamp)
        
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSLatitudeRef, latitudeRef as CFTypeRef)
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSLatitude, abs(location.coordinate.latitude) as CFTypeRef)
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSLongitudeRef, longitudeRef as CFTypeRef)
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSLongitude, abs(location.coordinate.longitude) as CFTypeRef)
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSAltitude, Int(abs(location.altitude)) as CFTypeRef)
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSAltitudeRef, altitudeRef as CFTypeRef)
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSTimeStamp, isoTime as CFTypeRef)
        CGImageMetadataSetValueMatchingImageProperty(imageMetadata, kCGImagePropertyGPSDictionary, kCGImagePropertyGPSDateStamp, isoDate as CFTypeRef)
        
        return imageMetadata
    }
    
    private func _saveImageToLibrary(atFileURL filePath: URL, _ imageCompletion: @escaping (CaptureResult) -> Void) {
        let location = locationManager?.latestLocation
        let date = Date()
        
        library?.save(imageAtURL: filePath, albumName: axc_imageAlbumName, date: date, location: location) { asset in
            
            guard let _ = asset else {
                return imageCompletion(.failure(CaptureError.assetNotSaved))
            }
        }
    }
    
    /**
     Captures still image from currently running capture session.
     
     :param: imageCompletion Completion block containing the captured imageData
     */
    @available(*, deprecated)
    func capturePictureDataWithCompletion(_ imageCompletion: @escaping (Data?, NSError?) -> Void) {
        func completion(_ result: CaptureResult) {
            switch result {
            case let .success(content):
                imageCompletion(content.asData, nil)
            case .failure:
                imageCompletion(nil, NSError())
            }
        }
        capturePictureDataWithCompletion(completion)
    }
    
    /**
     Captures still image from currently running capture session.
     
     :param: imageCompletion Completion block containing the captured imageData
     */
    func capturePictureDataWithCompletion(_ imageCompletion: @escaping (CaptureResult) -> Void) {
        guard cameraIsSetup else {
            _show(NSLocalizedString("No capture session setup", comment: ""), message: NSLocalizedString("I can't take any picture", comment: ""))
            return
        }
        
        guard axc_outputMode == .stillImage else {
            _show(NSLocalizedString("Capture session output mode video", comment: ""), message: NSLocalizedString("I can't take any picture", comment: ""))
            return
        }
        
        _updateIlluminationMode(axc_flashMode)
        
        sessionQueue.async {
            let stillImageOutput = self._getStillImageOutput()
            if let connection = stillImageOutput.connection(with: AVMediaType.video),
               connection.isEnabled {
                if self.axc_cameraDevice == DeviceType.front, connection.isVideoMirroringSupported,
                   self.axc_flipFrontCameraImage {
                    connection.isVideoMirrored = true
                }
                if connection.isVideoOrientationSupported {
                    connection.videoOrientation = self._currentCaptureVideoOrientation()
                }
                
                stillImageOutput.captureStillImageAsynchronously(from: connection, completionHandler: { [weak self] sample, error in
                    
                    if let error = error {
                        self?._show(NSLocalizedString("Error", comment: ""), message: error.localizedDescription)
                        imageCompletion(.failure(error))
                        return
                    }
                    
                    guard let sample = sample else { imageCompletion(.failure(CaptureError.noSampleBuffer)); return }
                    if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sample) {
                        imageCompletion(CaptureResult(imageData))
                    } else {
                        imageCompletion(.failure(CaptureError.noImageData))
                    }
                    
                })
            } else {
                imageCompletion(.failure(CaptureError.noVideoConnection))
            }
        }
    }
    
    private func _imageOrientation(forDeviceOrientation deviceOrientation: UIDeviceOrientation, isMirrored: Bool) -> UIImage.Orientation {
        switch deviceOrientation {
        case .landscapeLeft:
            return isMirrored ? .upMirrored : .up
        case .landscapeRight:
            return isMirrored ? .downMirrored : .down
        default:
            break
        }
        
        return isMirrored ? .leftMirrored : .right
    }
    
    /**
     Starts recording a video with or without voice as in the session preset.
     */
    func startRecordingVideo() {
        guard axc_outputMode != .stillImage else {
            _show(NSLocalizedString("Capture session output still image", comment: ""), message: NSLocalizedString("I can only take pictures", comment: ""))
            return
        }
        
        let videoOutput = _getMovieOutput()
        
        if axc_useLocationServices {
            
            let specs = [kCMMetadataFormatDescriptionMetadataSpecificationKey_Identifier as String: AVMetadataIdentifier.quickTimeMetadataLocationISO6709,
                         kCMMetadataFormatDescriptionMetadataSpecificationKey_DataType as String: kCMMetadataDataType_QuickTimeMetadataLocation_ISO6709 as String] as [String: Any]
            
            var locationMetadataDesc: CMFormatDescription?
            CMMetadataFormatDescriptionCreateWithMetadataSpecifications(allocator: kCFAllocatorDefault, metadataType: kCMMetadataFormatType_Boxed, metadataSpecifications: [specs] as CFArray, formatDescriptionOut: &locationMetadataDesc)
            
            // Create the metadata input and add it to the session.
            guard let captureSession = axc_captureSession, let locationMetadata = locationMetadataDesc else {
                return
            }
            
            let newLocationMetadataInput = AVCaptureMetadataInput(formatDescription: locationMetadata, clock: CMClockGetHostTimeClock())
            captureSession.addInputWithNoConnections(newLocationMetadataInput)
            
            // Connect the location metadata input to the movie file output.
            let inputPort = newLocationMetadataInput.ports[0]
            captureSession.addConnection(AVCaptureConnection(inputPorts: [inputPort], output: videoOutput))
            
        }
        
        _updateIlluminationMode(axc_flashMode)
        
        guard let tempUrl = AxcCacheManager.shared.axc_fileCacheFolderPath("Video").axc_fileUrl else { return }
        videoOutput.startRecording(to: tempUrl, recordingDelegate: self)
    }
    
    /**
     Stop recording a video. Save it to the cameraRoll and give back the url.
     */
    func stopVideoRecording(_ completion: ((_ videoURL: URL?, _ error: NSError?) -> Void)?) {
        if let runningMovieOutput = movieOutput,
           runningMovieOutput.isRecording {
            videoCompletion = completion
            runningMovieOutput.stopRecording()
        }
    }
    
    /**
     The signature for a handler.
     The success value is the string representation of a scanned QR code, if any.
     */
    public typealias QRCodeDetectionHandler = (Result<String, Error>) -> Void
    
    /**
     Start detecting QR codes.
     */
    func startQRCodeDetection(_ handler: @escaping QRCodeDetectionHandler) {
        guard let captureSession = self.axc_captureSession
        else { return }
        
        let output = AVCaptureMetadataOutput()
        
        guard captureSession.canAddOutput(output)
        else { return }
        
        qrCodeDetectionHandler = handler
        captureSession.addOutput(output)
        
        // Note: The object types must be set after the output was added to the capture session.
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417].filter { output.availableMetadataObjectTypes.contains($0) }
    }
    
    /**
     Stop detecting QR codes.
     */
    func stopQRCodeDetection() {
        qrCodeDetectionHandler = nil
        
        if let output = qrOutput {
            axc_captureSession?.removeOutput(output)
        }
        qrOutput = nil
    }
    
    /**
     The stored handler for QR codes.
     */
    private var qrCodeDetectionHandler: QRCodeDetectionHandler?
    
    /**
     The stored meta data output; used to detect QR codes.
     */
    private var qrOutput: AVCaptureOutput?
    
    /**
     Check if the device rotation is locked
     */
    func deviceOrientationMatchesInterfaceOrientation() -> Bool {
        return deviceOrientation == UIDevice.current.orientation
    }
    
    /**
     Current camera status.
     
     :returns: Current state of the camera: Ready / AccessDenied / NoDeviceFound / NotDetermined
     */
    func currentCameraStatus() -> State {
        return _checkIfCameraIsAvailable()
    }
    
    /**
     Change current flash mode to next value from available ones.
     
     :returns: Current flash mode: Off / On / Auto
     */
    func changeFlashMode() -> FlashMode {
        guard let newFlashMode = FlashMode(rawValue: (axc_flashMode.rawValue + 1) % 3) else { return axc_flashMode }
        axc_flashMode = newFlashMode
        return axc_flashMode
    }
    
    /**
     Check the camera device has flash
     */
    func hasFlash(for cameraDevice: DeviceType) -> Bool {
        let devices = AVCaptureDevice.axc_videoDevices()
        for device in devices {
            if device.position == .back, cameraDevice == .back {
                return device.hasFlash
            } else if device.position == .front, cameraDevice == .front {
                return device.hasFlash
            }
        }
        return false
    }
    
    // MARK: - AVCaptureFileOutputRecordingDelegate
    
    public func fileOutput(_: AVCaptureFileOutput, didStartRecordingTo _: URL, from _: [AVCaptureConnection]) {
        axc_captureSession?.beginConfiguration()
        if axc_flashMode != .off {
            _updateIlluminationMode(axc_flashMode)
        }
        
        axc_captureSession?.commitConfiguration()
    }
    
    public func fileOutput(_: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from _: [AVCaptureConnection], error: Error?) {
        if let error = error {
            _show(NSLocalizedString("Unable to save video to the device", comment: ""), message: error.localizedDescription)
        } else {
            if axc_writeFilesToPhoneLibrary {
                if PHPhotoLibrary.authorizationStatus() == .authorized {
                    _saveVideoToLibrary(outputFileURL)
                } else {
                    PHPhotoLibrary.requestAuthorization { autorizationStatus in
                        if autorizationStatus == .authorized {
                            self._saveVideoToLibrary(outputFileURL)
                        }
                    }
                }
            } else {
                _executeVideoCompletionWithURL(outputFileURL, error: error as NSError?)
            }
        }
    }
    
    private func _saveVideoToLibrary(_ fileURL: URL) {
        let location = locationManager?.latestLocation
        let date = Date()
        
        library?.save(videoAtURL: fileURL, albumName: axc_videoAlbumName, date: date, location: location, completion: { _ in
            self._executeVideoCompletionWithURL(fileURL, error: nil)
        })
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    private lazy var zoomGesture = UIPinchGestureRecognizer()
    
    private func attachZoom(_ view: UIView) {
        DispatchQueue.main.async {
            self.zoomGesture.addTarget(self, action: #selector(AxcCameraManager._zoomStart(_:)))
            view.addGestureRecognizer(self.zoomGesture)
            self.zoomGesture.delegate = self
        }
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIPinchGestureRecognizer.self) {
            beginZoomScale = zoomScale
        }
        
        return true
    }
    
    @objc private func _zoomStart(_ recognizer: UIPinchGestureRecognizer) {
        guard let view = embeddingView,
              let previewLayer = previewLayer
        else { return }
        
        var allTouchesOnPreviewLayer = true
        let numTouch = recognizer.numberOfTouches
        
        for i in 0 ..< numTouch {
            let location = recognizer.location(ofTouch: i, in: view)
            let convertedTouch = previewLayer.convert(location, from: previewLayer.superlayer)
            if !previewLayer.contains(convertedTouch) {
                allTouchesOnPreviewLayer = false
                break
            }
        }
        if allTouchesOnPreviewLayer {
            axc_zoom(recognizer.scale)
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    private lazy var focusGesture = UITapGestureRecognizer()
    
    private func attachFocus(_ view: UIView) {
        DispatchQueue.main.async {
            self.focusGesture.addTarget(self, action: #selector(AxcCameraManager._focusStart(_:)))
            view.addGestureRecognizer(self.focusGesture)
            self.focusGesture.delegate = self
        }
    }
    
    private lazy var exposureGesture = UIPanGestureRecognizer()
    
    private func attachExposure(_ view: UIView) {
        DispatchQueue.main.async {
            self.exposureGesture.addTarget(self, action: #selector(AxcCameraManager._exposureStart(_:)))
            view.addGestureRecognizer(self.exposureGesture)
            self.exposureGesture.delegate = self
        }
    }
    
    @objc private func _focusStart(_ recognizer: UITapGestureRecognizer) {
        let device = currentDevice
        
        _changeExposureMode(mode: .continuousAutoExposure)
        translationY = 0
        exposureValue = 0.5
        
        if let validDevice = device,
           let validPreviewLayer = previewLayer,
           let view = recognizer.view {
            let pointInPreviewLayer = view.layer.convert(recognizer.location(in: view), to: validPreviewLayer)
            let pointOfInterest = validPreviewLayer.captureDevicePointConverted(fromLayerPoint: pointInPreviewLayer)
            
            do {
                try validDevice.lockForConfiguration()
                
                _showFocusRectangleAtPoint(pointInPreviewLayer, inLayer: validPreviewLayer)
                
                if validDevice.isFocusPointOfInterestSupported {
                    validDevice.focusPointOfInterest = pointOfInterest
                }
                
                if validDevice.isExposurePointOfInterestSupported {
                    validDevice.exposurePointOfInterest = pointOfInterest
                }
                
                if validDevice.isFocusModeSupported(axc_focusMode) {
                    validDevice.focusMode = axc_focusMode
                }
                
                if validDevice.isExposureModeSupported(axc_exposureMode) {
                    validDevice.exposureMode = axc_exposureMode
                }
                
                validDevice.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    private var lastFocusRectangle: CAShapeLayer?
    private var lastFocusPoint: CGPoint?
    private func _showFocusRectangleAtPoint(_ focusPoint: CGPoint, inLayer layer: CALayer, withBrightness brightness: Float? = nil) {
        if let lastFocusRectangle = lastFocusRectangle {
            lastFocusRectangle.removeFromSuperlayer()
            self.lastFocusRectangle = nil
        }
        
        let size = CGSize(width: 75, height: 75)
        let rect = CGRect(origin: CGPoint(x: focusPoint.x - size.width / 2.0, y: focusPoint.y - size.height / 2.0), size: size)
        
        let endPath = UIBezierPath(rect: rect)
        endPath.move(to: CGPoint(x: rect.minX + size.width / 2.0, y: rect.minY))
        endPath.addLine(to: CGPoint(x: rect.minX + size.width / 2.0, y: rect.minY + 5.0))
        endPath.move(to: CGPoint(x: rect.maxX, y: rect.minY + size.height / 2.0))
        endPath.addLine(to: CGPoint(x: rect.maxX - 5.0, y: rect.minY + size.height / 2.0))
        endPath.move(to: CGPoint(x: rect.minX + size.width / 2.0, y: rect.maxY))
        endPath.addLine(to: CGPoint(x: rect.minX + size.width / 2.0, y: rect.maxY - 5.0))
        endPath.move(to: CGPoint(x: rect.minX, y: rect.minY + size.height / 2.0))
        endPath.addLine(to: CGPoint(x: rect.minX + 5.0, y: rect.minY + size.height / 2.0))
        if brightness != nil {
            endPath.move(to: CGPoint(x: rect.minX + size.width + size.width / 4, y: rect.minY))
            endPath.addLine(to: CGPoint(x: rect.minX + size.width + size.width / 4, y: rect.minY + size.height))
            
            endPath.move(to: CGPoint(x: rect.minX + size.width + size.width / 4 - size.width / 16, y: rect.minY + size.height - CGFloat(brightness!) * size.height))
            endPath.addLine(to: CGPoint(x: rect.minX + size.width + size.width / 4 + size.width / 16, y: rect.minY + size.height - CGFloat(brightness!) * size.height))
        }
        
        let startPath = UIBezierPath(cgPath: endPath.cgPath)
        let scaleAroundCenterTransform = CGAffineTransform(translationX: -focusPoint.x, y: -focusPoint.y).concatenating(CGAffineTransform(scaleX: 2.0, y: 2.0).concatenating(CGAffineTransform(translationX: focusPoint.x, y: focusPoint.y)))
        startPath.apply(scaleAroundCenterTransform)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = endPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 1, green: 0.83, blue: 0, alpha: 0.95).cgColor
        shapeLayer.lineWidth = 1.0
        
        layer.addSublayer(shapeLayer)
        lastFocusRectangle = shapeLayer
        lastFocusPoint = focusPoint
        
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(0.2)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut))
        
        CATransaction.setCompletionBlock {
            if shapeLayer.superlayer != nil {
                shapeLayer.removeFromSuperlayer()
                self.lastFocusRectangle = nil
            }
        }
        if brightness == nil {
            let appearPathAnimation = CABasicAnimation(keyPath: "path")
            appearPathAnimation.fromValue = startPath.cgPath
            appearPathAnimation.toValue = endPath.cgPath
            shapeLayer.add(appearPathAnimation, forKey: "path")
            
            let appearOpacityAnimation = CABasicAnimation(keyPath: "opacity")
            appearOpacityAnimation.fromValue = 0.0
            appearOpacityAnimation.toValue = 1.0
            shapeLayer.add(appearOpacityAnimation, forKey: "opacity")
        }
        
        let disappearOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        disappearOpacityAnimation.fromValue = 1.0
        disappearOpacityAnimation.toValue = 0.0
        disappearOpacityAnimation.beginTime = CACurrentMediaTime() + 0.8
        disappearOpacityAnimation.fillMode = CAMediaTimingFillMode.forwards
        disappearOpacityAnimation.isRemovedOnCompletion = false
        shapeLayer.add(disappearOpacityAnimation, forKey: "opacity")
        
        CATransaction.commit()
    }
    
    var exposureValue: Float = 0.1 // EV
    var translationY: Float = 0
    var startPanPointInPreviewLayer: CGPoint?
    
    let exposureDurationPower: Float = 4.0 // the exposure slider gain
    let exposureMininumDuration: Float64 = 1.0 / 2000.0
    
    @objc private func _exposureStart(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        let view = gestureRecognizer.view!
        
        _changeExposureMode(mode: .custom)
        
        let translation = gestureRecognizer.translation(in: view)
        let currentTranslation = translationY + Float(translation.y)
        if gestureRecognizer.state == .ended {
            translationY = currentTranslation
        }
        if currentTranslation < 0 {
            // up - brighter
            exposureValue = 0.5 + min(abs(currentTranslation) / 400, 1) / 2
        } else if currentTranslation >= 0 {
            // down - lower
            exposureValue = 0.5 - min(abs(currentTranslation) / 400, 1) / 2
        }
        _changeExposureDuration(value: exposureValue)
        
        // UI Visualization
        if gestureRecognizer.state == .began {
            if let validPreviewLayer = previewLayer {
                startPanPointInPreviewLayer = view.layer.convert(gestureRecognizer.location(in: view), to: validPreviewLayer)
            }
        }
        
        if let validPreviewLayer = previewLayer, let lastFocusPoint = self.lastFocusPoint {
            _showFocusRectangleAtPoint(lastFocusPoint, inLayer: validPreviewLayer, withBrightness: exposureValue)
        }
    }
    
    // Available modes:
    // .Locked .AutoExpose .ContinuousAutoExposure .Custom
    func _changeExposureMode(mode: AVCaptureDevice.ExposureMode) {
        let device = currentDevice
        if device?.exposureMode == mode {
            return
        }
        
        do {
            try device?.lockForConfiguration()
            
            if device?.isExposureModeSupported(mode) == true {
                device?.exposureMode = mode
            }
            device?.unlockForConfiguration()
            
        } catch {
            return
        }
    }
    
    func _changeExposureDuration(value: Float) {
        if cameraIsSetup {
            let device = currentDevice
            
            guard let videoDevice = device else {
                return
            }
            
            do {
                try videoDevice.lockForConfiguration()
                
                let p = Float64(pow(value, exposureDurationPower)) // Apply power function to expand slider's low-end range
                let minDurationSeconds = Float64(max(CMTimeGetSeconds(videoDevice.activeFormat.minExposureDuration), exposureMininumDuration))
                let maxDurationSeconds = Float64(CMTimeGetSeconds(videoDevice.activeFormat.maxExposureDuration))
                let newDurationSeconds = Float64(p * (maxDurationSeconds - minDurationSeconds)) + minDurationSeconds // Scale from 0-1 slider range to actual duration
                
                if videoDevice.exposureMode == .custom {
                    let newExposureTime = CMTimeMakeWithSeconds(Float64(newDurationSeconds), preferredTimescale: 1000 * 1000 * 1000)
                    videoDevice.setExposureModeCustom(duration: newExposureTime, iso: AVCaptureDevice.currentISO, completionHandler: nil)
                }
                
                videoDevice.unlockForConfiguration()
            } catch {
                return
            }
        }
    }
    
    // MARK: - CameraManager()
    
    private func _executeVideoCompletionWithURL(_ url: URL?, error: NSError?) {
        if let validCompletion = videoCompletion {
            validCompletion(url, error)
            videoCompletion = nil
        }
    }
    
    private func _getMovieOutput() -> AVCaptureMovieFileOutput {
        if movieOutput == nil {
            _createMovieOutput()
        }
        
        return movieOutput!
    }
    
    private func _createMovieOutput() {
        
        let newMovieOutput = AVCaptureMovieFileOutput()
        newMovieOutput.movieFragmentInterval = CMTime.invalid
        
        movieOutput = newMovieOutput
        
        _setupVideoConnection()
        
        if let captureSession = axc_captureSession, captureSession.canAddOutput(newMovieOutput) {
            captureSession.beginConfiguration()
            captureSession.addOutput(newMovieOutput)
            captureSession.commitConfiguration()
        }
    }
    
    private func _setupVideoConnection() {
        if let movieOutput = movieOutput {
            for connection in movieOutput.connections {
                for port in connection.inputPorts {
                    if port.mediaType == AVMediaType.video {
                        let videoConnection = connection as AVCaptureConnection
                        // setup video mirroring
                        if videoConnection.isVideoMirroringSupported {
                            videoConnection.isVideoMirrored = (axc_cameraDevice == DeviceType.front && axc_flipFrontCameraImage)
                        }
                        
                        if videoConnection.isVideoStabilizationSupported {
                            videoConnection.preferredVideoStabilizationMode = axc_videoStabilisationMode
                        }
                    }
                }
            }
        }
    }
    
    private func _getStillImageOutput() -> AVCaptureStillImageOutput {
        if let stillImageOutput = stillImageOutput, let connection = stillImageOutput.connection(with: AVMediaType.video),
           connection.isActive {
            return stillImageOutput
        }
        let newStillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput = newStillImageOutput
        if let captureSession = axc_captureSession,
           captureSession.canAddOutput(newStillImageOutput) {
            captureSession.beginConfiguration()
            captureSession.addOutput(newStillImageOutput)
            captureSession.commitConfiguration()
        }
        return newStillImageOutput
    }
    
    @objc private func _orientationChanged() {
        var currentConnection: AVCaptureConnection?
        
        switch axc_outputMode {
        case .stillImage:
            currentConnection = stillImageOutput?.connection(with: AVMediaType.video)
        case .videoOnly, .videoWithMic:
            currentConnection = _getMovieOutput().connection(with: AVMediaType.video)
            if let location = locationManager?.latestLocation {
                _setVideoWithGPS(forLocation: location)
            }
        }
        
        if let validPreviewLayer = previewLayer {
            if !axc_keepViewAutoOrientation {
                if let validPreviewLayerConnection = validPreviewLayer.connection,
                   validPreviewLayerConnection.isVideoOrientationSupported {
                    validPreviewLayerConnection.videoOrientation = _currentPreviewVideoOrientation()
                }
            }
            if let validOutputLayerConnection = currentConnection,
               validOutputLayerConnection.isVideoOrientationSupported {
                validOutputLayerConnection.videoOrientation = _currentCaptureVideoOrientation()
            }
            if !axc_keepViewAutoOrientation && cameraIsObservingDeviceOrientation {
                DispatchQueue.main.async { () -> Void in
                    if let validEmbeddingView = self.embeddingView {
                        validPreviewLayer.frame = validEmbeddingView.bounds
                    }
                }
            }
        }
    }
    
    private func _currentCaptureVideoOrientation() -> AVCaptureVideoOrientation {
        if deviceOrientation == .faceDown
            || deviceOrientation == .faceUp
            || deviceOrientation == .unknown {
            return _currentPreviewVideoOrientation()
        }
        
        return _videoOrientation(forDeviceOrientation: deviceOrientation)
    }
    
    private func _currentPreviewDeviceOrientation() -> UIDeviceOrientation {
        if axc_keepViewAutoOrientation {
            return .portrait
        }
        
        return UIDevice.current.orientation
    }
    
    private func _currentPreviewVideoOrientation() -> AVCaptureVideoOrientation {
        let orientation = _currentPreviewDeviceOrientation()
        return _videoOrientation(forDeviceOrientation: orientation)
    }
    
    func resetOrientation() {
        // Main purpose is to reset the preview layer orientation.  Problems occur if you are recording landscape, present a modal VC,
        // then turn portriat to dismiss.  The preview view is then stuck in a prior orientation and not redrawn.  Calling this function
        // will then update the orientation of the preview layer.
        _orientationChanged()
    }
    
    private func _videoOrientation(forDeviceOrientation deviceOrientation: UIDeviceOrientation) -> AVCaptureVideoOrientation {
        switch deviceOrientation {
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .faceUp:
            /*
             Attempt to keep the existing orientation.  If the device was landscape, then face up
             getting the orientation from the stats bar would fail every other time forcing it
             to default to portrait which would introduce flicker into the preview layer.  This
             would not happen if it was in portrait then face up
             */
            if let validPreviewLayer = previewLayer, let connection = validPreviewLayer.connection {
                return connection.videoOrientation // Keep the existing orientation
            }
            // Could not get existing orientation, try to get it from stats bar
            return _videoOrientationFromStatusBarOrientation()
        case .faceDown:
            /*
             Attempt to keep the existing orientation.  If the device was landscape, then face down
             getting the orientation from the stats bar would fail every other time forcing it
             to default to portrait which would introduce flicker into the preview layer.  This
             would not happen if it was in portrait then face down
             */
            if let validPreviewLayer = previewLayer, let connection = validPreviewLayer.connection {
                return connection.videoOrientation // Keep the existing orientation
            }
            // Could not get existing orientation, try to get it from stats bar
            return _videoOrientationFromStatusBarOrientation()
        default:
            return .portrait
        }
    }
    
    private func _videoOrientationFromStatusBarOrientation() -> AVCaptureVideoOrientation {
        var orientation: UIInterfaceOrientation?
        
        DispatchQueue.main.async {
            orientation = UIApplication.shared.statusBarOrientation
        }
        
        /*
         Note - the following would fall into the guard every other call (it is called repeatedly) if the device was
         landscape then face up/down.  Did not seem to fail if in portrait first.
         */
        guard let statusBarOrientation = orientation else {
            return .portrait
        }
        
        switch statusBarOrientation {
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        default:
            return .portrait
        }
    }
    
    private func fixOrientation(withImage image: UIImage) -> UIImage {
        guard let cgImage = image.cgImage else { return image }
        
        var isMirrored = false
        let orientation = image.imageOrientation
        if orientation == .rightMirrored
            || orientation == .leftMirrored
            || orientation == .upMirrored
            || orientation == .downMirrored {
            isMirrored = true
        }
        
        let newOrientation = _imageOrientation(forDeviceOrientation: deviceOrientation, isMirrored: isMirrored)
        
        if image.imageOrientation != newOrientation {
            return UIImage(cgImage: cgImage, scale: image.scale, orientation: newOrientation)
        }
        
        return image
    }
    
    private func _canLoadCamera() -> Bool {
        let currentState = _checkIfCameraIsAvailable()
        return currentState == .ready || (currentState == .unknow && axc_autoPopAccessPermission)
    }
    
    private func _setupCamera(_ completion: @escaping () -> Void) {
        axc_captureSession = AVCaptureSession()
        
        sessionQueue.async {
            if let validCaptureSession = self.axc_captureSession {
                validCaptureSession.beginConfiguration()
                validCaptureSession.sessionPreset = AVCaptureSession.Preset.high
                self._updateDeviceType(self.axc_cameraDevice)
                self._setupOutputs()
                self._setupOutputMode(self.axc_outputMode, oldOutputMode: nil)
                self._setupPreviewLayer()
                validCaptureSession.commitConfiguration()
                self._updateIlluminationMode(self.axc_flashMode)
                self._updateCameraQualityMode(self.axc_cameraOutputQuality)
                validCaptureSession.startRunning()
                self.startFollowingDeviceOrientation()
                self.cameraIsSetup = true
                self._orientationChanged()
                
                completion()
            }
        }
    }
    
    private func startFollowingDeviceOrientation() {
        if axc_autoOrientation, !cameraIsObservingDeviceOrientation {
            coreMotionManager = CMMotionManager()
            coreMotionManager.deviceMotionUpdateInterval = 1 / 30.0
            if coreMotionManager.isDeviceMotionAvailable {
                coreMotionManager.startDeviceMotionUpdates(to: OperationQueue()) { motion, _ in
                    guard let motion = motion else { return }
                    let x = motion.gravity.x
                    let y = motion.gravity.y
                    let previousOrientation = self.deviceOrientation
                    if fabs(y) >= fabs(x) {
                        if y >= 0 {
                            self.deviceOrientation = .portraitUpsideDown
                        } else {
                            self.deviceOrientation = .portrait
                        }
                    } else {
                        if x >= 0 {
                            self.deviceOrientation = .landscapeRight
                        } else {
                            self.deviceOrientation = .landscapeLeft
                        }
                    }
                    if previousOrientation != self.deviceOrientation {
                        self._orientationChanged()
                    }
                }
                
                cameraIsObservingDeviceOrientation = true
            } else {
                cameraIsObservingDeviceOrientation = false
            }
        }
    }
    
    //    private func updateDeviceOrientation(_ orientation: UIDeviceOrientation) {
    //        deviceOrientation = orientation
    //    }
    
    private func stopFollowingDeviceOrientation() {
        if cameraIsObservingDeviceOrientation {
            coreMotionManager.stopDeviceMotionUpdates()
            cameraIsObservingDeviceOrientation = false
        }
    }
    
    private func _addPreviewLayerToView(_ view: UIView) {
        embeddingView = view
        attachZoom(view)
        attachFocus(view)
        attachExposure(view)
        
        DispatchQueue.main.async { () -> Void in
            guard let previewLayer = self.previewLayer else { return }
            previewLayer.frame = view.layer.bounds
            view.clipsToBounds = true
            view.layer.addSublayer(previewLayer)
        }
    }
    
    private func _setupMaxZoomScale() {
        var maxZoom = CGFloat(1.0)
        beginZoomScale = CGFloat(1.0)
        
        if axc_cameraDevice == .back, let backDeviceType = backDevice {
            maxZoom = backDeviceType.activeFormat.videoMaxZoomFactor
        } else if axc_cameraDevice == .front, let frontDeviceType = frontDevice {
            maxZoom = frontDeviceType.activeFormat.videoMaxZoomFactor
        }
        
        maxZoomScale = maxZoom
    }
    
    private func _checkIfCameraIsAvailable() -> State {
        let deviceHasCamera = UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear) || UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front)
        if deviceHasCamera {
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            let userAgreedToUseIt = authorizationStatus == .authorized
            if userAgreedToUseIt {
                return .ready
            } else if authorizationStatus == AVAuthorizationStatus.notDetermined {
                return .unknow
            } else {
                _show(NSLocalizedString("Camera access denied", comment: ""), message: NSLocalizedString("You need to go to settings app and grant acces to the camera device to use it.", comment: ""))
                return .accessDenied
            }
        } else {
            _show(NSLocalizedString("Camera unavailable", comment: ""), message: NSLocalizedString("The device does not have a camera.", comment: ""))
            return .noDeviceFound
        }
    }
    
    private func _setupOutputMode(_ newOutputMode: OutputMode, oldOutputMode: OutputMode?) {
        axc_captureSession?.beginConfiguration()
        
        if let cameraOutputToRemove = oldOutputMode {
            // remove current setting
            switch cameraOutputToRemove {
            case .stillImage:
                if let validStillImageOutput = stillImageOutput {
                    axc_captureSession?.removeOutput(validStillImageOutput)
                }
            case .videoOnly, .videoWithMic:
                if let validMovieOutput = movieOutput {
                    axc_captureSession?.removeOutput(validMovieOutput)
                }
                if cameraOutputToRemove == .videoWithMic {
                    _removeMicInput()
                }
            }
        }
        
        _setupOutputs()
        
        // configure new devices
        switch newOutputMode {
        case .stillImage:
            let validStillImageOutput = _getStillImageOutput()
            if let captureSession = axc_captureSession,
               captureSession.canAddOutput(validStillImageOutput) {
                captureSession.addOutput(validStillImageOutput)
            }
        case .videoOnly, .videoWithMic:
            let videoMovieOutput = _getMovieOutput()
            if let captureSession = axc_captureSession,
               captureSession.canAddOutput(videoMovieOutput) {
                captureSession.addOutput(videoMovieOutput)
            }
            
            if newOutputMode == .videoWithMic,
               let validMic = _deviceInputFromDevice(mic) {
                axc_captureSession?.addInput(validMic)
            }
        }
        axc_captureSession?.commitConfiguration()
        _updateCameraQualityMode(axc_cameraOutputQuality)
        _orientationChanged()
    }
    
    private func _setupOutputs() {
        if stillImageOutput == nil {
            stillImageOutput = AVCaptureStillImageOutput()
        }
        if movieOutput == nil {
            movieOutput = _getMovieOutput()
        }
        if library == nil {
            library = PHPhotoLibrary.shared()
        }
    }
    
    private func _setupPreviewLayer() {
        if let validCaptureSession = axc_captureSession {
            previewLayer = AVCaptureVideoPreviewLayer(session: validCaptureSession)
            previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        }
    }
    
    /**
     Switches between the current and specified camera using a flip animation similar to the one used in the iOS stock camera app.
     */
    
    private var cameraTransitionView: UIView?
    private var transitionAnimating = false
    
    func _doFlipAnimation() {
        if transitionAnimating {
            return
        }
        
        if let validEmbeddingView = embeddingView,
           let validPreviewLayer = previewLayer {
            var tempView = UIView()
            
            if AxcCameraManager._blurSupported() {
                let blurEffect = UIBlurEffect(style: .light)
                tempView = UIVisualEffectView(effect: blurEffect)
                tempView.frame = validEmbeddingView.bounds
            } else {
                tempView = UIView(frame: validEmbeddingView.bounds)
                tempView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
            }
            
            validEmbeddingView.insertSubview(tempView, at: Int(validPreviewLayer.zPosition + 1))
            
            cameraTransitionView = validEmbeddingView.snapshotView(afterScreenUpdates: true)
            
            if let cameraTransitionView = cameraTransitionView {
                validEmbeddingView.insertSubview(cameraTransitionView, at: Int(validEmbeddingView.layer.zPosition + 1))
            }
            tempView.removeFromSuperview()
            
            transitionAnimating = true
            
            validPreviewLayer.opacity = 0.0
            
            DispatchQueue.main.async {
                self._flipCameraTransitionView()
            }
        }
    }
    
    
    
    // Determining whether the current device actually supports blurring
    // As seen on: http://stackoverflow.com/a/29997626/2269387
    private class func _blurSupported() -> Bool {
        var supported = Set<String>()
        supported.insert("iPad")
        supported.insert("iPad1,1")
        supported.insert("iPhone1,1")
        supported.insert("iPhone1,2")
        supported.insert("iPhone2,1")
        supported.insert("iPhone3,1")
        supported.insert("iPhone3,2")
        supported.insert("iPhone3,3")
        supported.insert("iPod1,1")
        supported.insert("iPod2,1")
        supported.insert("iPod2,2")
        supported.insert("iPod3,1")
        supported.insert("iPod4,1")
        supported.insert("iPad2,1")
        supported.insert("iPad2,2")
        supported.insert("iPad2,3")
        supported.insert("iPad2,4")
        supported.insert("iPad3,1")
        supported.insert("iPad3,2")
        supported.insert("iPad3,3")
        
        return !supported.contains(_hardwareString())
    }
    
    private class func _hardwareString() -> String {
        var sysinfo = utsname()
        uname(&sysinfo)
        guard let deviceName = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)?.trimmingCharacters(in: .controlCharacters) else {
            return ""
        }
        return deviceName
    }
    
    private func _flipCameraTransitionView() {
        if let cameraTransitionView = cameraTransitionView {
            UIView.transition(with: cameraTransitionView,
                              duration: 0.5,
                              options: UIView.AnimationOptions.transitionFlipFromLeft,
                              animations: nil,
                              completion: { (_) -> Void in
                                self._removeCameraTransistionView()
                              })
        }
    }
    
    private func _removeCameraTransistionView() {
        if let cameraTransitionView = cameraTransitionView {
            if let validPreviewLayer = previewLayer {
                validPreviewLayer.opacity = 1.0
            }
            
            UIView.animate(withDuration: 0.5,
                           animations: { () -> Void in
                            
                            cameraTransitionView.alpha = 0.0
                            
                           }, completion: { (_) -> Void in
                            
                            self.transitionAnimating = false
                            
                            cameraTransitionView.removeFromSuperview()
                            self.cameraTransitionView = nil
                           })
        }
    }
    
    private func _updateDeviceType(_: DeviceType) {
        if let validCaptureSession = axc_captureSession {
            validCaptureSession.beginConfiguration()
            defer { validCaptureSession.commitConfiguration() }
            let inputs: [AVCaptureInput] = validCaptureSession.inputs
            
            for input in inputs {
                if let deviceInput = input as? AVCaptureDeviceInput, deviceInput.device != mic {
                    validCaptureSession.removeInput(deviceInput)
                }
            }
            
            switch axc_cameraDevice {
            case .front:
                if axc_isHasFrontCamera {
                    if let validFrontDevice = _deviceInputFromDevice(frontDevice),
                       !inputs.contains(validFrontDevice) {
                        validCaptureSession.addInput(validFrontDevice)
                    }
                }
            case .back:
                if let validBackDevice = _deviceInputFromDevice(backDevice),
                   !inputs.contains(validBackDevice) {
                    validCaptureSession.addInput(validBackDevice)
                }
            }
        }
    }
    
    private func _updateIlluminationMode(_ mode: FlashMode) {
        if axc_outputMode != .stillImage {
            _updateTorch(mode)
        } else {
            _updateFlash(mode)
        }
    }
    
    private func _updateTorch(_: FlashMode) {
        axc_captureSession?.beginConfiguration()
        defer { axc_captureSession?.commitConfiguration() }
        for captureDevice in AVCaptureDevice.axc_videoDevices() {
            guard let avTorchMode = AVCaptureDevice.TorchMode(rawValue: axc_flashMode.rawValue) else { continue }
            if captureDevice.isTorchModeSupported(avTorchMode), axc_cameraDevice == .back {
                do {
                    try captureDevice.lockForConfiguration()
                    
                    captureDevice.torchMode = avTorchMode
                    captureDevice.unlockForConfiguration()
                    
                } catch {
                    return
                }
            }
        }
    }
    
    private func _updateFlash(_ flashMode: FlashMode) {
        axc_captureSession?.beginConfiguration()
        defer { axc_captureSession?.commitConfiguration() }
        for captureDevice in AVCaptureDevice.axc_videoDevices() {
            guard let avFlashMode = AVCaptureDevice.FlashMode(rawValue: flashMode.rawValue) else { continue }
            if captureDevice.isFlashModeSupported(avFlashMode) {
                do {
                    try captureDevice.lockForConfiguration()
                    captureDevice.flashMode = avFlashMode
                    captureDevice.unlockForConfiguration()
                } catch {
                    return
                }
            }
        }
    }
    
    /// 快门动画
    private func shutterAnimation(_ completion: AxcEmptyBlock?) {
        if let validPreviewLayer = previewLayer {
            AxcGCD.main {
                let fadeOutAnimation = AxcAnimationManager.axc_inoutFade(isIn: true, 0)
                validPreviewLayer.add(fadeOutAnimation, forKey: nil)
                let fadeInAnimation = AxcAnimationManager.axc_inoutFade(isIn: false, 0.2) { (_, _) in
                    if let block = completion { block() }
                }
                validPreviewLayer.add(fadeInAnimation, forKey: nil)
            }
        }
    }
    
    private func _updateCameraQualityMode(_ newCameraOutputQuality: AVCaptureSession.Preset) {
        if let validCaptureSession = axc_captureSession {
            var sessionPreset = newCameraOutputQuality
            if newCameraOutputQuality == .high {
                if axc_outputMode == .stillImage {
                    sessionPreset = AVCaptureSession.Preset.photo
                } else {
                    sessionPreset = AVCaptureSession.Preset.high
                }
            }
            
            if validCaptureSession.canSetSessionPreset(sessionPreset) {
                validCaptureSession.beginConfiguration()
                validCaptureSession.sessionPreset = sessionPreset
                validCaptureSession.commitConfiguration()
            } else {
                _show(NSLocalizedString("Preset not supported", comment: ""), message: NSLocalizedString("Camera preset not supported. Please try another one.", comment: ""))
            }
        } else {
            _show(NSLocalizedString("Camera error", comment: ""), message: NSLocalizedString("No valid capture session found, I can't take any pictures or videos.", comment: ""))
        }
    }
    
    private func _removeMicInput() {
        guard let inputs = axc_captureSession?.inputs else { return }
        
        for input in inputs {
            if let deviceInput = input as? AVCaptureDeviceInput,
               deviceInput.device == mic {
                axc_captureSession?.removeInput(deviceInput)
                break
            }
        }
    }
    
    private func _show(_ title: String, message: String) {
        if axc_showErrorsToUsers {
            DispatchQueue.main.async { () -> Void in
                self.axc_showErrorBlock(title, message)
            }
        }
    }
    
    private func _deviceInputFromDevice(_ device: AVCaptureDevice?) -> AVCaptureDeviceInput? {
        guard let validDevice = device else { return nil }
        do {
            return try AVCaptureDeviceInput(device: validDevice)
        } catch let outError {
            _show(NSLocalizedString("Device setup error occured", comment: ""), message: "\(outError)")
            return nil
        }
    }
    
    deinit {
        stopFollowingDeviceOrientation()
        axc_stopAndRemoveCaptureSession()
    }
}


extension PHPhotoLibrary {
    // MARK: - Public
    
    // finds or creates an album
    
    func getAlbum(name: String, completion: @escaping (PHAssetCollection) -> Void) {
        if let album = findAlbum(name: name) {
            completion(album)
        } else {
            createAlbum(name: name, completion: completion)
        }
    }
    
    func save(imageAtURL: URL, albumName: String?, date: Date = Date(), location: CLLocation? = nil, completion: ((PHAsset?) -> Void)? = nil) {
        func save() {
            if let albumName = albumName {
                getAlbum(name: albumName) { album in
                    self.saveImage(imageAtURL: imageAtURL, album: album, date: date, location: location, completion: completion)
                }
            } else {
                saveImage(imageAtURL: imageAtURL, album: nil, date: date, location: location, completion: completion)
            }
        }
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            save()
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    save()
                }
            }
        }
    }
    
    func save(videoAtURL: URL, albumName: String?, date: Date = Date(), location: CLLocation? = nil, completion: ((PHAsset?) -> Void)? = nil) {
        func save() {
            if let albumName = albumName {
                getAlbum(name: albumName) { album in
                    self.saveVideo(videoAtURL: videoAtURL, album: album, date: date, location: location, completion: completion)
                }
            } else {
                saveVideo(videoAtURL: videoAtURL, album: nil, date: date, location: location, completion: completion)
            }
        }
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            save()
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    save()
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func findAlbum(name: String) -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", name)
        let fetchResult: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        guard let photoAlbum = fetchResult.firstObject else {
            return nil
        }
        return photoAlbum
    }
    
    private func createAlbum(name: String, completion: @escaping (PHAssetCollection) -> Void) {
        var placeholder: PHObjectPlaceholder?
        
        performChanges({
            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
            placeholder = createAlbumRequest.placeholderForCreatedAssetCollection
        }, completionHandler: { _, _ in
            let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder!.localIdentifier], options: nil)
            completion(fetchResult.firstObject!)
        })
    }
    
    private func saveImage(imageAtURL: URL, album: PHAssetCollection?, date: Date = Date(), location: CLLocation? = nil, completion: ((PHAsset?) -> Void)? = nil) {
        var placeholder: PHObjectPlaceholder?
        performChanges({
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: imageAtURL)!
            createAssetRequest.creationDate = date
            createAssetRequest.location = location
            if let album = album {
                guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album),
                      let photoPlaceholder = createAssetRequest.placeholderForCreatedAsset else { return }
                placeholder = photoPlaceholder
                let fastEnumeration = NSArray(array: [photoPlaceholder] as [PHObjectPlaceholder])
                albumChangeRequest.addAssets(fastEnumeration)
            }
            
        }, completionHandler: { success, _ in
            guard let placeholder = placeholder else {
                return
            }
            if success {
                let assets: PHFetchResult<PHAsset> = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                let asset: PHAsset? = assets.firstObject
                completion?(asset)
            }
        })
    }
    
    private func saveVideo(videoAtURL: URL, album: PHAssetCollection?, date: Date = Date(), location: CLLocation? = nil, completion: ((PHAsset?) -> Void)? = nil) {
        var placeholder: PHObjectPlaceholder?
        performChanges({
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoAtURL)!
            createAssetRequest.creationDate = date
            createAssetRequest.location = location
            if let album = album {
                guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album),
                      let photoPlaceholder = createAssetRequest.placeholderForCreatedAsset else { return }
                placeholder = photoPlaceholder
                let fastEnumeration = NSArray(array: [photoPlaceholder] as [PHObjectPlaceholder])
                albumChangeRequest.addAssets(fastEnumeration)
            }
            
        }, completionHandler: { success, _ in
            guard let placeholder = placeholder else {
                completion?(nil)
                return
            }
            if success {
                let assets: PHFetchResult<PHAsset> = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                let asset: PHAsset? = assets.firstObject
                completion?(asset)
            } else {
                completion?(nil)
            }
        })
    }
    
    private func saveImage(image: UIImage, album: PHAssetCollection, completion: ((PHAsset?) -> Void)? = nil) {
        var placeholder: PHObjectPlaceholder?
        performChanges({
            let createAssetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            createAssetRequest.creationDate = Date()
            guard let albumChangeRequest = PHAssetCollectionChangeRequest(for: album),
                  let photoPlaceholder = createAssetRequest.placeholderForCreatedAsset else { return }
            placeholder = photoPlaceholder
            let fastEnumeration = NSArray(array: [photoPlaceholder] as [PHObjectPlaceholder])
            albumChangeRequest.addAssets(fastEnumeration)
        }, completionHandler: { success, _ in
            guard let placeholder = placeholder else {
                completion?(nil)
                return
            }
            if success {
                let assets: PHFetchResult<PHAsset> = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
                let asset: PHAsset? = assets.firstObject
                completion?(asset)
            } else {
                completion?(nil)
            }
        })
    }
}

extension AxcCameraManager: AVCaptureMetadataOutputObjectsDelegate {
    /**
     Called when a QR code is detected.
     */
    public func metadataOutput(_: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from _: AVCaptureConnection) {
        // Check if there is a registered handler.
        guard let handler = qrCodeDetectionHandler
        else { return }
        
        // Get the detection result.
        let stringValues = metadataObjects
            .compactMap { $0 as? AVMetadataMachineReadableCodeObject }
            .compactMap { $0.stringValue }
        
        guard let stringValue = stringValues.first
        else { return }
        
        handler(.success(stringValue))
    }
}
