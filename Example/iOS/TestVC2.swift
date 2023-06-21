//
//  TestVC2.swift
//  iOS
//
//  Created by 赵洋 on 2023/4/18.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import AxcBedrock

class TestVC2: UIViewController {

    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vcs = navigationController?.viewControllers
        print(vcs)
        
        let currentVC = YPApp.CurrentVC(filterClassNames: [TestVC2.YP.ClassName])
        print(currentVC)
    }
}
