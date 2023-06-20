//
//  AxcCFData.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/11.
//

import Foundation

public extension CFData {
    /// 转换NSData
    var axc_nsData: NSData {
        return self as NSData
    }
    /// 转换Data
    var axc_data: Data {
        return axc_nsData.axc_data
    }
}
