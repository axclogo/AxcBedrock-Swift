//
//  ViewController.swift
//  macOS
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Cocoa
import AxcBedrock

class ViewController: NSViewController {
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
            //            @available(macOS 10.5, *)
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
            //            @available(macOS 10.5, *)
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
