//
//  AxcCIImageFilterInterFaceTarget.swift
//  AxcBedrock-Core
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [_AxcCIFilterNameProtocol]

protocol _AxcCIFilterNameProtocol {
    /// case值
    var rawValue: String { get }

    /// 滤镜名
    var filterName: String { get }
}

extension _AxcCIFilterNameProtocol {
    /// 滤镜名称
    var filterName: String {
        let upper = rawValue.axc.firstUppercased
        return "CI\(upper)"
    }
}
