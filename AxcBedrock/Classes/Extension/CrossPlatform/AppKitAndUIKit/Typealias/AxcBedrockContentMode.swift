//
//  AxcBedrock.swift
//  AxcBedrock
//
//  Created by 赵新 on 2022/2/11.
//

/// （💈跨平台标识）内容填充模式
public typealias AxcBedrockContentMode = AxcEnum.ContentMode

#if os(iOS) || os(tvOS)
import UIKit

public extension AxcEnum {
    typealias ContentMode = UIView.ContentMode
}

#elseif os(macOS) || os(watchOS)

public extension AxcEnum {
    enum ContentMode: Int {
        case scaleToFill
        case scaleAspectFit
        case scaleAspectFill
        case redraw
        case center
        case top
        case bottom
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
}
#endif
