//
//  AxcUnifiedImage.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/3/8.
//

import Foundation

// MARK: 图片统一互转协议
public protocol AxcUnifiedImage {}
extension String:   AxcUnifiedImage {}
extension NSString: AxcUnifiedImage {}
