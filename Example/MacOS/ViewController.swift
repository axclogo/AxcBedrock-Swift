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
        ]
        
//        for category in allCategory {
//            let filterNames = CIFilter.filterNames(inCategory: category)
//            let _ccc = category.axc.removePrefix(string: "CICategory")
//            print("enum \(_ccc){")
//            for filterName in filterNames {
////                print("\(category) --- \(filterName)")
//                var newStr = filterName.axc.removePrefix(string: "CI")
//                let first = newStr.prefix(1).lowercased()
//                newStr = newStr.axc.removePrefix(count: 1) ?? ""
//                let printStr = "    case \(first + newStr)"
//                print(printStr)
//            }
//            print("}")
////            print("\(category)<<<<<<<<<<<<")
//        }
        
        
        let str = "\n\n\n\n\n\nasdasdasdasdasd     \n\n\n"
        print(str.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
