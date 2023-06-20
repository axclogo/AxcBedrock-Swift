//
//  AxcNSMutableDataEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/11.
//

import Foundation

public extension NSMutableData {
    /// 转换 CFMutableData
    var axc_cfMutableData: CFMutableData {
        return self as CFMutableData
    }
}
