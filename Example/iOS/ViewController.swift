//
//  ViewController.swift
//  iOS
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import WebKit
import AxcBedrock
import LocalAuthentication

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dic = ["a": 1]
        let data = dic.yp.jsonData
        
        let a1 = AA.YP.Create(fromJsonObject: dic)
        
        let c3 = AA.YP.Create(fromJsonData: data)
        
        let obj: AA? = dic.yp.jsonClass()

        let obj2: AA? = [1,2,3].yp.jsonClass()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(TestVC(), animated: true)
    }
}


class AA: Decodable {
    
}
