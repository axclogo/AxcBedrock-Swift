//
//  AxcAVCaptureSessionEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/24.
//

import AVFoundation

// MARK: - 数据转换

public extension AxcSpace where Base: AVCaptureSession {}

// MARK: - 类方法

public extension AxcSpace where Base: AVCaptureSession {}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AVCaptureSession {
    /// 设置输出图像质量
    /// - Parameter preset: 质量枚举
    /// - Returns: 是否成功
    @discardableResult
    func setSession(preset: AVCaptureSession.Preset?) -> Bool {
        guard let preset = preset else { return false }
        if base.canSetSessionPreset(preset) {
            base.sessionPreset = preset
            return true
        }
        return false
    }

    /// 设置输入流
    /// - Parameter input: 输入流
    /// - Returns: 是否成功
    @discardableResult
    func addInput(_ input: AVCaptureInput?) -> Bool {
        guard let input = input else { return false }
        if base.canAddInput(input) {
            base.addInput(input)
            return true
        }
        return false
    }

    /// 移除输入流
    /// - Parameter output: 输出流
    /// - Returns: 是否成功
    @discardableResult
    func removeInput(_ input: AVCaptureInput?) -> Bool {
        guard let input = input else { return false }
        base.removeInput(input)
        return true
    }

    /// 设置输出流
    /// - Parameter output: 输出流
    /// - Returns: 是否成功
    @discardableResult
    func addOutput(_ output: AVCaptureOutput?) -> Bool {
        guard let output = output else { return false }
        if base.canAddOutput(output) {
            base.addOutput(output)
            return true
        }
        return false
    }

    /// 移除输出流
    /// - Parameter output: 输出流
    /// - Returns: 是否成功
    @discardableResult
    func removeOutput(_ output: AVCaptureOutput?) -> Bool {
        guard let output = output else { return false }
        base.removeOutput(output)
        return true
    }
    
    /// 进行配置
    /// - Parameter block: 配置块
    func configuration(_ block: AxcBlock.Empty) {
        base.beginConfiguration()
        block()
        base.commitConfiguration()
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: AVCaptureSession {}
