//
//  AxcUnifiedFont.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/21.
//

import Foundation

// MARK: 字体统一互转协议
public protocol AxcUnifiedFont {}
extension Int:          AxcUnifiedFont {}
extension Int8:         AxcUnifiedFont {}
extension Int16:        AxcUnifiedFont {}
extension Int32:        AxcUnifiedFont {}
extension Int64:        AxcUnifiedFont {}

extension UInt:         AxcUnifiedFont {}
extension UInt8:        AxcUnifiedFont {}
extension UInt16:       AxcUnifiedFont {}
extension UInt32:       AxcUnifiedFont {}
extension UInt64:       AxcUnifiedFont {}

extension Float:        AxcUnifiedFont {}
extension Double:       AxcUnifiedFont {}

extension String:       AxcUnifiedFont {}
extension Character:    AxcUnifiedFont {}
extension NSNumber:     AxcUnifiedFont {}
extension NSString:     AxcUnifiedFont {}
