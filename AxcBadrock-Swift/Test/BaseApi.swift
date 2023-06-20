//
//  BaseApi.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/6.
//

import Foundation

public protocol BaseApi {
}

public extension BaseApi {
    // 设置当前域名
    var baseURL: URL {
        return "https://www.beckyspremium.com".axc_url!
    }
    // 表单
    var acceptForm: String  {
        return "application/x-www-form-urlencoded"
    }
    // json对象
    var acceptJson: String{
        return "application/json"
    }
    var sampleData: Data {
        return "".axc_data ?? Data()
    }
    //
    // 地址对应的头
    var headers: [String : String]? {
        var currentHeader: [String : String] = [
            "Accept":"application/json",
            "isToken":"false",
            "Content-Type": AxcNetWorkContentType.form_data.rawValue
        ]
        return currentHeader
    }
    
}
