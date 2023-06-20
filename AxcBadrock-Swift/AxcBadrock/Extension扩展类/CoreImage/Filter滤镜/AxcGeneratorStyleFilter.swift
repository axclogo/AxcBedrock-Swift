//
//  AxcGeneratorStyleFilter.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//


import UIKit

// MARK: - 生成器滤镜组对象
public class AxcGeneratorStyleFilter: AxcBaseStyleFilter {}

// MARK: - 内部包含的所有可选滤镜链式语法
public extension AxcGeneratorStyleFilter {
    /// 生成一个阿兹特克码 Aztec Code
    var axc_aztecCodeGeneratorFilter: AxcAztecCodeGeneratorFilter {
        return AxcAztecCodeGeneratorFilter().axc_inputUIImage(image).axc_message( _defaultData )
//        .axc_layers(30).axc_correctionLevel(23)
    }
    
}

/// 阿兹特克码 Aztec Code
public class AxcAztecCodeGeneratorFilter: AxcBaseFilter,
                                          AxcFilterImageInterFace,
                                          AxcFilterMessageInterFace,
                                          AxcFilterCompactStyleInterFace,
                                          AxcFilterLayersInterFace,
                                          AxcFilterCorrectionLevelInterFace {
    override func setFilterName() -> String { return "CIAztecCodeGenerator" }
    override func drawRect() -> CGRect? {
        return CGRect(x: 0, y: 0, width: 19, height: 19)
    }
}
