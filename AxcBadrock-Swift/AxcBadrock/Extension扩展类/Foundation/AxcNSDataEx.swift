//
//  AxcNSDataEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/11.
//

import Foundation

public extension NSData {
    /// 转换CFData
    var axc_cfData: CFData {
        return self as CFData
    }
    /// 转换Data
    var axc_data: Data {
        return self as Data
    }
    
}
