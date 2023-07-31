//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

public extension AxcCIFilterCategory {
    /// 平铺效果
    enum TileEffect: String {
        /// 仿射夹紧
        case affineClamp
        /// 仿射平铺
        case affineTile
        /// 夹紧
        case clamp
        /// 八折反射平铺
        case eightfoldReflectedTile
        /// 四折反射平铺
        case fourfoldReflectedTile
        /// 四折旋转平铺
        case fourfoldRotatedTile
        /// 四折平移平铺
        case fourfoldTranslatedTile
        /// 滑动反射平铺
        case glideReflectedTile
        /// 凯利多斯科普平铺
        case kaleidoscope
        /// OP平铺
        case opTile
        /// 平行四边形平铺
        case parallelogramTile
        /// 透视平铺
        case perspectiveTile
        /// 六折反射平铺
        case sixfoldReflectedTile
        /// 六折旋转平铺
        case sixfoldRotatedTile
        /// 三角形凯利多斯科普平铺
        case triangleKaleidoscope
        /// 三角形平铺
        case triangleTile
        /// 十二折反射平铺
        case twelvefoldReflectedTile
    }
}
