//
//  AxcCTFrameEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/15.
//

import CoreText
import Foundation

// MARK: - CTFrame + AxcSpaceProtocol

extension CTFrame: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base: CTFrame { }

// MARK: - 类方法

public extension AxcSpace where Base: CTFrame { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: CTFrame {
    /// 获取所有行列
    var lines: NSArray {
        let nsArrayLines = CTFrameGetLines(base) as NSArray
        return nsArrayLines
    }

    /// 获取行数
    var numberOfLines: CFIndex {
        return CFArrayGetCount(lines)
    }

    /// 获取第一行
    var firstLine: CTLine? {
        guard let line = lines.firstObject else { return nil }
        return (line as! CTLine)
    }

    /// 获取某一行
    /// - Parameter index: 索引
    /// - Returns: CTLine
    func line(at index: Int) -> CTLine? {
        guard let line = lines.axc.object(at: index) else { return nil }
        return (line as! CTLine)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: CTFrame { }
