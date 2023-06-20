//
//  MoyaTest.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/23.
//

import Foundation
import Moya

extension ApiClass {
    enum Api {
        case login(paw: String, user: String)
        case tourist
    }
}
class ApiClass: TargetType {
    init(_ api: Api) {
        self.api = api
    }
    private var api: Api?
    
    var baseURL: URL {
        return "".axc_url!
    }
    
    var path: String{
        switch api {
        case .login(paw: _, user: _):
            return "/login/"
        case .tourist:
            return "/tourist/"
        default: return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".axc_data!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["123":""]
    }
    
    func request() {
        
    }
}
