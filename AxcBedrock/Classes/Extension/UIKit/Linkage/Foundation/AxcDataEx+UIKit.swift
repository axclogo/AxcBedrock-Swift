//
//  AxcDataEx+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base == Data {
    /// data转图片
    var uiImage: UIImage? {
        return UIImage(data: base)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == Data { }

// MARK: - 属性 & Api

public extension AxcSpace where Base == Data { }

// MARK: - 决策判断

public extension AxcSpace where Base == Data { }

#endif
