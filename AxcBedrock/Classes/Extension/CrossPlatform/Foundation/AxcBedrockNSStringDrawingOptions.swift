//
//  AxcNSStringDrawingOptions.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//


/*
 真就离谱，这都没统一，苹果是写了两套代码吗？
 */

#if os(macOS)
import AppKit
public typealias AxcBedrockNSStringDrawingOptions = NSString.DrawingOptions

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit
public typealias AxcBedrockNSStringDrawingOptions = NSStringDrawingOptions
#endif
