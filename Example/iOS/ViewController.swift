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
        let allCategory = [
            kCICategoryDistortionEffect,
            kCICategoryGeometryAdjustment,
            kCICategoryCompositeOperation,
            kCICategoryHalftoneEffect,
            kCICategoryColorAdjustment,
            kCICategoryColorEffect,
            kCICategoryTransition,
            kCICategoryTileEffect,
            kCICategoryGenerator,
            kCICategoryReduction,
            kCICategoryGradient,
            kCICategoryStylize,
            kCICategorySharpen,
            kCICategoryBlur,
            kCICategoryVideo,
            kCICategoryStillImage,
            kCICategoryInterlaced,
            kCICategoryNonSquarePixels,
            kCICategoryHighDynamicRange,
            kCICategoryBuiltIn,
            kCICategoryFilterGenerator,
        ]
        
        for category in allCategory {
            let filterNames = CIFilter.filterNames(inCategory: category)
            print("\(category)>>>>>>>>>>>>")
            for filterName in filterNames {
                print(filterName)
            }
            print("\(category)<<<<<<<<<<<<")
        }
    }

    
}
