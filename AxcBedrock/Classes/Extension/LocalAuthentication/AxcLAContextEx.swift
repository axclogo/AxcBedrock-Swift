//
//  AxcLAContextEx.swift
//  Pods
//
//  Created by 赵新 on 2023/2/24.
//

import LocalAuthentication

public extension AxcBedrockError {
    static var NotHasBiometrics: AxcBedrockError = .init(rawValue: "设备未发现生物识别功能！")
}

// MARK: - 数据转换

public extension AxcSpace where Base: LAContext { }

// MARK: - 类方法

public extension AxcSpace where Base: LAContext { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: LAContext {
    /// 设备所有者将使用生物识别方法(Touch ID或Face ID)进行身份验证。
    /// - Parameters:
    ///   - reason: 理由
    ///   - successBlock: 成功
    ///   - failureBlock: 失败
    func verifiBiometrics(reason: String,
                          successBlock: @escaping AxcBlock.Empty,
                          failureBlock: @escaping (Error) -> Void) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                AxcGCD.Main {
                    if let err = error {
                        failureBlock(err)
                    } else if success {
                        successBlock()
                    }
                }
            }
        } else {
            failureBlock(AxcBedrockError.NotHasBiometrics)
        }
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: LAContext { }
