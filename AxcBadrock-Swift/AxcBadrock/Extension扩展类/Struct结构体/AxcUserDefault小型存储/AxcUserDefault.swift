//
//  AxcUserDefault.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/19.
//

import UIKit

/// AxcUserDefault结构体
public struct AxcUserDefault {
    /// 存储时间戳的字符串
    public static let axc_saveTimeStamp: String = "_axcSaveTime"
    
    /// 存入一个对象
    /// - Parameters:
    ///   - model: 对象模型
    ///   - key: 键值
    public static func set<T>(_ model: T, key: String, useTimeStamp: Bool = false) where T : Codable {
        let modelData = try? JSONEncoder().encode(model)
        Axc_userDefaults.set(modelData, forKey: key)
        if useTimeStamp {
            Axc_userDefaults.set(Date(), forKey: key + axc_saveTimeStamp)
        }
        Axc_userDefaults.synchronize()
    }
    /// 获取一个模型
    /// - Parameter key: 键值
    /// - Returns: 对象
    public static func get<T>(_ key: String) -> T? where T : Codable {
        guard let modelData = Axc_userDefaults.data(forKey: key),
              let model = try? JSONDecoder().decode(T.self, from: modelData)
        else { return nil }
        return model
    }
    /// 获取一个模型存储的时间戳
    /// - Parameter key: 键值
    /// - Returns: 对象存储时间
    public static func getTimeStamp(_ key: String) -> Date? {
        guard let modelData: Date = get(key + axc_saveTimeStamp)
        else { return nil }
        return modelData
    }
    
    /// 移除一个模型
    /// - Parameter key: 键值
    public static func remove(_ key: String) {
        Axc_userDefaults.removeObject(forKey: key)
        Axc_userDefaults.removeObject(forKey: key + axc_saveTimeStamp)
        Axc_userDefaults.synchronize()
    }
}
