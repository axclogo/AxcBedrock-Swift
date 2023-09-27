//
//  AxcBedrockIndexPath.swift
//  AxcBedrock
//
//  Created by 赵新 on 26/9/2023.
//

#if os(macOS)
import AppKit

/// （💈跨平台标识）IndexPath
public typealias AxcBedrockIndexPath = IndexPath

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

/// （💈跨平台标识）IndexPath
public typealias AxcBedrockIndexPath = IndexPath
#endif

// MARK: - AxcBedrockIndexPath + AxcSpaceProtocol

extension AxcBedrockIndexPath: AxcSpaceProtocol { }

public extension AxcSpace where Base == AxcBedrockIndexPath {
    /// （💈跨平台标识）row
    var row: Int {
        #if os(macOS)
        return base.item
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        return base.row
        #endif
    }

    /// （💈跨平台标识）section
    var section: Int {
        return base.section
    }
}

public extension AxcSpace where Base == AxcBedrockIndexPath {
    /// （💈跨平台标识）创建IndexPath
    /// - Parameters:
    ///   - section: section
    ///   - row: row
    /// - Returns: IndexPath
    static func Create(section: Int, row: Int) -> AxcBedrockIndexPath {
        #if os(macOS)
        return IndexPath(item: row, section: section)
        #elseif os(iOS) || os(tvOS) || os(watchOS)
        return IndexPath(row: row, section: section)
        #endif
    }
}
