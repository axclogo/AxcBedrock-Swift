//
//  AxcNSDictionaryEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/11.
//

import Foundation

public extension NSDictionary {
    /// 转swift[String: Any]字典
    var axc_dic_StrAny: [String: Any] {
        return axc_dic()
    }
    /// 转swift字典
    func axc_dic<K,V>() -> [K:V] {
        var newDic = [K:V]()
        enumerateKeysAndObjects { (k, v, _) in
            if let key = k as? K,
               let value = v as? V{
                newDic[key] = value
            }
        }
        return newDic
    }
}
