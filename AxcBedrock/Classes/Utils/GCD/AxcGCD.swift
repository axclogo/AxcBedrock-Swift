//
//  AxcGCD.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/11.
//

import Dispatch

/// GCD结构体
public typealias AxcGCD = AxcBedrockLib.GCD

// MARK: - [AxcBedrockLib.GCD]

public extension AxcBedrockLib {
    /// GCD结构体
    class GCD: NSObject { }
}

// MARK: - AxcGCD + AxcGCDTarget

extension AxcGCD: AxcGCDTarget { }
