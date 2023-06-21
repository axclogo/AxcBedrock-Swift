//
//  AxcCMSampleBufferEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/6/6.
//

import CoreMedia

// MARK: - 扩展CMSampleBuffer + AxcSpaceProtocol

extension CMSampleBuffer: AxcSpaceProtocol {}

// MARK: - 数据转换

public extension AxcSpace where Base: CMSampleBuffer {
    /// 转换成CVBuffer
    var cvBuffer: CVBuffer? {
        return CMSampleBufferGetImageBuffer(base)
    }

}

// MARK: - 类方法

public extension AxcSpace where Base: CMSampleBuffer {}

// MARK: - 属性 & Api

public extension AxcSpace where Base: CMSampleBuffer {}

// MARK: - 决策判断

public extension AxcSpace where Base: CMSampleBuffer {}
