//
//  TestProvider.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/6.
//

import UIKit
import Moya

class TestProvider {
    static let provider = MoyaProvider<TestApi>()

    static func request(_ target: TestApi,
                        success: @escaping ([String:Any]) -> Void,
                        failure: @escaping (String) -> Void){

        provider.request(target) { (result) in
            
               switch result{
               case let .success(response):
                   if let json = try? response.mapJSON() as! [String:Any]{
                    success(json)
                   }
                   else{
                       print("服务器连接成功,数据获取失败")
                   }
               case let .failure(error):
                failure(error.errorDescription!)
               }
           }
       }
}
