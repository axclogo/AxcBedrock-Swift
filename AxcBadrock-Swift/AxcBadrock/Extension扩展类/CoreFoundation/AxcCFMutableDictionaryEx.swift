//
//  AxcCFMutableDictionaryEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/11.
//

import Foundation

public extension CFMutableDictionary {
    /// 转NS可变字典
    var axc_nsMutableDic: NSMutableDictionary {
        return self as NSMutableDictionary
    }
}
