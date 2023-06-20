//
//  AxcBadrockTabbar.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

class AxcBadrockTabbar: AxcBaseTabbarVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        
        axc_addTabItem(AxcTabItem(className: "SampleExtensionVC", title: "扩展示例", selectedImgColor: UIColor.systemBlue))
        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例2", selectedImgColor: UIColor.systemBlue))
        axc_addTabItem(AxcTabItem(className: "ProjectVC", title: "示例3", selectedImgColor: UIColor.systemBlue))

        
        
    }
    
    var idx = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        switch idx {
//        case 0:
//            AxcUrlConfig.shared.axc_switchEnvironment("release")
//        case 1:
//            AxcUrlConfig.shared.axc_switchEnvironment("prepare")
//        case 2:
//            AxcUrlConfig.shared.axc_switchEnvironment("test")
//        default:
//            break
//        }
//        // 主站单切
//        AxcUrlConfig.shared.axc_switchStandbyUrl("Main", environmentKey: "release", idx: Int(arc4random())%5)
//
//        idx += 1
//        if idx > 2 {
//            idx = 0
//        }
//        for module in AxcUrlConfig.shared.netModules {
//            print(module.currentUrl)
//        }
//        print("\n")
        
//        TestProvider.request(.liveInfo) { (data) in
//            print("\(data)")
//        } failure: { (err) in
//            print("\(err)")
//        }
    }

}
