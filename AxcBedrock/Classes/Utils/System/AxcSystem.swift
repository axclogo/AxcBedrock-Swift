//
//  AxcSystem.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/24.
//

import Foundation

public typealias AxcSystem = AxcBedrockLib.System

// MARK: - [AxcBedrockLib.System]

public extension AxcBedrockLib {
    /// System集合
    struct System { }
}

public extension AxcSystem {
    /// 通过CoreServices获取系统版本号
    /// MacOS、iOS、TvOS、WatchOS全平台通用
    static var Version: String {
        let processInfo: ProcessInfo = ProcessInfo.processInfo
        let majorVersion = processInfo.operatingSystemVersion.majorVersion
        let minorVersion = processInfo.operatingSystemVersion.minorVersion
        let patchVersion = processInfo.operatingSystemVersion.patchVersion
        return "\(majorVersion).\(minorVersion).\(patchVersion)"
    }

    /// 当前系统的语言
    static var Language: String {
        return NSLocale.preferredLanguages.first!
    }
}

// MARK: - [AxcSandboxPathProtocol]

public protocol AxcSandboxPathProtocol {
    static var Path: String { get }
}

public extension AxcSandboxPathProtocol {
    /// 沙盒路径获取
    /// - Parameter directory: 路径类型
    /// - Returns: 路径字符串地址
    static func SearchPath(_ directory: FileManager.SearchPathDirectory) -> String {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first!
    }
}

public extension AxcSystem {
    /// 保存应⽤运行时生成的需要持久化的数据
    /// iTunes同步设备时会备份该目录
    struct Documents: AxcSandboxPathProtocol {
        public static var Path: String {
            return SearchPath(.documentDirectory)
        }
    }

    /// 保存应⽤运行时所需的临时数据,使⽤完毕后再将相应的文件从该目录删除
    /// 应用 没有运行时,系统也可能会清除该目录下的文件
    /// iTunes同步设备时不会备份该目录
    struct Tmp: AxcSandboxPathProtocol {
        public static var Path: String {
            return NSTemporaryDirectory()
        }
    }

    /// 存放内容 苹果建议用来存放默认设置或其它状态信息
    struct Library: AxcSandboxPathProtocol {
        /// 保存应用运行时⽣成的需要持久化的数据
        /// iTunes同步设备时不会备份
        /// 该目录一般存储体积大、不需要备份的非重要数据，比如网络数据缓存存储到Caches下
        public struct Caches: AxcSandboxPathProtocol {
            public static var Path: String {
                return SearchPath(.cachesDirectory)
            }
        }

        /// 保存应用的所有偏好设置，如iOS的Settings(设置) 应⽤会在该目录中查找应⽤的设置信息
        /// iTunes同步设备时会备份该目录
        public struct Preference: AxcSandboxPathProtocol {
            public static var Path: String {
                return SearchPath(.preferencePanesDirectory)
            }
        }

    

        public static var Path: String {
            return SearchPath(.libraryDirectory)
        }
    }
}
