//
//  TestVC.swift
//  iOS
//
//  Created by 赵洋 on 2023/4/18.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import AxcBedrock

class TestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("总共：\(UIDevice.YP.TotalDiskSpace_Bytes) - \(UIDevice.YP.TotalDiskSpace_MB) - \(UIDevice.YP.TotalDiskSpace_GB)")
//        print("已使用：\(UIDevice.YP.UsedDiskSpace_Bytes) - \(UIDevice.YP.UsedDiskSpace_MB) - \(UIDevice.YP.UsedDiskSpace_GB)")
//        print("可使用：\(UIDevice.YP.FreeDiskSpace_Bytes) - \(UIDevice.YP.FreeDiskSpace_MB) - \(UIDevice.YP.FreeDiskSpace_GB)")
        
        
    }
    let a = UIDevice.YP.UsedDiskSpace_GB
    
//    var current = 0
//
//    static var count = 3
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if current < Self.count {
//            let vc = TestVC()
//            vc.current = current + 1
//            present(vc, animated: true)
//        }else {
//            present(TestVC2(), animated: true)
//        }
//    }
    
}
