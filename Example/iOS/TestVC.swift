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
        
//        print("总共：\(UIDevice.Axc.TotalDiskSpace_Bytes) - \(UIDevice.Axc.TotalDiskSpace_MB) - \(UIDevice.Axc.TotalDiskSpace_GB)")
//        print("已使用：\(UIDevice.Axc.UsedDiskSpace_Bytes) - \(UIDevice.Axc.UsedDiskSpace_MB) - \(UIDevice.Axc.UsedDiskSpace_GB)")
//        print("可使用：\(UIDevice.Axc.FreeDiskSpace_Bytes) - \(UIDevice.Axc.FreeDiskSpace_MB) - \(UIDevice.Axc.FreeDiskSpace_GB)")
        
        
    }
    let a = UIDevice.Axc.UsedDiskSpace_GB
    
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
