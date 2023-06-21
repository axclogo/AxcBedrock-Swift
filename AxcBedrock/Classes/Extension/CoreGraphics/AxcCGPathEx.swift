//
//  AxcCGPathEx.swift
//  Pods
//
//  Created by 赵新 on 2023/2/24.
//

import CoreGraphics

// MARK: - CGPath + AxcSpaceProtocol

extension CGPath: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == CGPath { }

// MARK: - 类方法

public extension AxcSpace where Base == CGPath { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == CGPath {
    /// Length
    var length: CGFloat {
        return getLength(with: elements)
    }

    /// 在给定的百分比下得到路径上的点
    ///
    /// - Parameter percent: 0-1百分比
    /// - Returns: 点位
    func point(at percent: CGFloat) -> CGPoint? {
        return point(at: percent, with: elements)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == CGPath { }
