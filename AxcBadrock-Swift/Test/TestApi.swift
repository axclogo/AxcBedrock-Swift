//
//  TestApi.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/6.
//

import UIKit
import Moya

public enum TestApi {
    
    case liveInfo
}

extension TestApi: TargetType, BaseApi {
    // 地址
    public var path: String {
        switch self {
        case .liveInfo:
            return "/system/config/tx/live/info"
            
        }
    }
    // 地址对应的方法
    public var method: Moya.Method {
        switch self {
        
        case .liveInfo:
            
            return .get
        }
    }

    // 地址对应的Accept
    var accept: String {
        switch self {
        case .liveInfo:
            return acceptForm
        default:
            return acceptJson
        }
    }
    
    public var task: Task {
        switch self {
        default:
            if let parameters = parameters {
                
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .liveInfo: break
        }
        return params
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}
