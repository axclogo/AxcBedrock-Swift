//
//  Project.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/24.
//

import Foundation

public typealias AxcApp = AxcBedrockLib.App

// MARK: - [AxcBedrockLib.App]

public extension AxcBedrockLib {
    /// App相关
    struct App {
        /// infoDictionary
        public static let Info = Bundle.main.infoDictionary!
        /// 当前项目版本
        public static let Version = Info["CFBundleShortVersionString"]! as! String
        /// 当前项目名称
        public static let ProjectName = Info["CFBundleExecutable"]! as! String
        /// 当前项目Bundle Identifier
        public static let Identifier = Info["CFBundleIdentifier"]! as! String
        /// 当前项目app名称
        public static let AppName = Info["CFBundleDisplayName"]! as! String
        /// 当前appBuild版本
        public static var BuildVersion = Info["CFBundleVersion"] as! String
    }
}
