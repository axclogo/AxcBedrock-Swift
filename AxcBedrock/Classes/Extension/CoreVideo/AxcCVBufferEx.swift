//
//  AxcCVPixelBufferEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/6/6.
//

import CoreVideo

// MARK: - CVBuffer + AxcSpaceProtocol

/*
 @typedef    CVPixelBufferRef
 @abstract   Based on the image buffer type. The pixel buffer implements the memory storage for an image buffer.

 public typealias CVPixelBuffer = CVImageBuffer

    本质上CVPixelBuffer == CVImageBuffer

 @typedef    CVImageBufferRef
 @abstract   Base type for all CoreVideo image buffers

 public typealias CVImageBuffer = CVBuffer

    本质上CVImageBuffer == CVBuffer
 */

extension CVBuffer: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base: CVBuffer { }

// MARK: - 类方法

public extension AxcSpace where Base: CVBuffer { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: CVBuffer { }

// MARK: - 决策判断

public extension AxcSpace where Base: CVBuffer { }

//// MARK: - To-CoreImage
//
//#if canImport(CoreImage)
//import CoreImage
//
//public extension AxcSpace where Base: CVBuffer {
//    func ciImage() -> CIImage {
//        return .init(cvImageBuffer: base)
//    }
//}
//#endif

// MARK: - To-VideoToolbox

#if canImport(VideoToolbox)
import VideoToolbox

public extension AxcSpace where Base: CVBuffer {
    /// 转换成CMSampleBuffer
    var cmSampleBuffer: CMSampleBuffer? {
        return cmSampleBuffer()
    }

    /// 转换成CMSampleBuffer
    func cmSampleBuffer(timimgInfo: CMSampleTimingInfo = .invalid,
                        videoInfo: CMVideoFormatDescription? = nil) -> CMSampleBuffer? {
        var newSampleBuffer: CMSampleBuffer?
        var _timimgInfo = timimgInfo
        var _videoInfo: CMVideoFormatDescription?
        if let videoInfo = videoInfo {
            _videoInfo = videoInfo
        } else {
            CMVideoFormatDescriptionCreateForImageBuffer(allocator: nil,
                                                         imageBuffer: base,
                                                         formatDescriptionOut: &_videoInfo)
        }
        guard let _videoInfo = _videoInfo else { return nil }
        CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault,
                                           imageBuffer: base,
                                           dataReady: true,
                                           makeDataReadyCallback: nil,
                                           refcon: nil,
                                           formatDescription: _videoInfo,
                                           sampleTiming: &_timimgInfo,
                                           sampleBufferOut: &newSampleBuffer)
        return newSampleBuffer
    }

    /// 转换成CGImage
    /// - Parameter options: 选项
    /// - Returns: CGImage
    func cgImage(options: CFDictionary? = nil) -> CGImage? {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(base, options: options, imageOut: &cgImage)
        return cgImage
    }
}
#endif
