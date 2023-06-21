//
//  AxcDevice+Platform.swift
//  Kanna
//
//  Created by 赵新 on 2023/2/28.
//

#if os(macOS)
import AppKit

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
#endif

public extension AxcDevice {
    /// （💈跨平台标识）设备名称
    static var DeviceName: String {
        #if os(macOS)
        return Host.current().localizedName ?? ""

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        return UIDevice.current.name
        #endif
    }
}
