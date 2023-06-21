//
//  AxcDevice.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/8.
//

import Foundation

public typealias AxcDevice = AxcBedrockLib.Device

// MARK: - [AxcBedrockLib.Device]

public extension AxcBedrockLib {
    /// 设备相关
    struct Device { }
}

// MARK: - [AxcDevice.Info]

public extension AxcDevice {
    /// 设备信息对象
    struct Info {
        /// 值
        public enum Value {
            case value(_ value: String)
            case unknown
        }

        /// 产品迭代标识
        public let generation: Value
        /// 设备标识符
        public let identifier: String

        /// 实例化方法
        init(generation: Value,
             identifier: String) {
            self.generation = generation
            self.identifier = identifier
        }

        /// 产品迭代名
        public var generationName: String {
            switch generation {
            case let .value(value): return value
            case .unknown: return identifier
            }
        }
    }
}

// MARK: - 缓存表

fileprivate extension AxcLazyCache.TableKey {
    /// 设备信息表，启用缓存
    static let deviceInfoTable = AxcLazyCache.TableKey("deviceInfo_table", enableCache: true)
}

public extension AxcDevice {
    /// 获取设备信息对象
    /// 具有缓存功能
    static var Information: Info {
        let info: Info = AxcLazyCache.MemoryCache(table: .deviceInfoTable, key: "Information") {
            // 获取唯一标识符
            let identifier = Identifier
            // 获取设备迭代名
            var generation = identifier
            if identifier == "i386" || identifier == "x86_64" {
                generation = "Simulator"
            } else if let deviceGeneration = DeviceMap[identifier] {
                generation = deviceGeneration
            }
            return .init(generation: .value(generation), identifier: identifier)
        }
        return info
    }

    /// 唯一标识符
    static var Identifier: String {
        let identifier: String = AxcLazyCache.MemoryCache(table: .deviceInfoTable, key: "Identifier") {
            #if os(macOS)
            var identifier = "unknown Mac"
            var len = 0
            sysctlbyname("hw.model", nil, &len, nil, 0)
            guard len > 0 else { return identifier }
            var data = Data(count: len)
            sysctlbyname("hw.model", &data, &len, nil, 0)
            if let result = String(data: data, encoding: .utf8) {
                identifier = result
            }
            return identifier

            #elseif os(iOS) || os(tvOS) || os(watchOS)
            
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
            #endif
        }
        return identifier
    }
}

