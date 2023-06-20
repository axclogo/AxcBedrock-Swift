//
//  AxcLanguageManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/17.
//

import UIKit

// 请注意, 这个命名不是随意的, 是根据你本地的语言包,可以show in finder 看到. en.lproj / zh-Hans.lproj
public enum AxcLanguageEnum: String, CaseIterable{
    /// 简中
    case zh_Hans    = "zh-Hans"
    /// 繁中
    case zh_Hant    = "zh-Hant"
    /// 英文
    case en         = "en"
}

open class AxcLanguageManager {
    /// 单例实例化
    public static let shared: AxcLanguageManager = {
        let manager = AxcLanguageManager()
        return manager
    }()
    /// 锁死初始化
    private init() {}
    
    /// 获取本地当前的语言
    /// - Returns: nil 为枚举中没有的
    public static func localeLanguage() -> AxcLanguageEnum? {
        guard let lang = Locale.preferredLanguages.first else {
            AxcLog("获取本地系统语言失败！", level: .warning)
            return nil
        }
        let allCases = AxcLanguageEnum.allCases
        for item in allCases {
            if lang.axc_hasSubStr( item.rawValue ) || item.rawValue.axc_hasSubStr(lang) {
                return item
            }
        }
        return nil
    }
    /// 获取语言资源文件Bundle
    public static var languageBundle: Bundle? {
        let resource = AxcLanguageManager.localeLanguage()?.rawValue
        guard let lproj_path = Axc_BadrockBundle.path(forResource: resource, ofType: "lproj") else {
            AxcLog("获取语言文件Bundle失败！请检查目录！\nResource:%@", resource, level: .warning)
            return nil
        }
        return Bundle(path: lproj_path)
    }
}

