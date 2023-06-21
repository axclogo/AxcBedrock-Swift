//
//  AxcUnifiedColorTarget.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/19.
//

import Foundation

public protocol AxcUnifiedColor {}
extension Int: AxcUnifiedColor {}
extension Int8: AxcUnifiedColor {}
extension Int16: AxcUnifiedColor {}
extension Int32: AxcUnifiedColor {}
extension Int64: AxcUnifiedColor {}
extension UInt: AxcUnifiedColor {}
extension UInt8: AxcUnifiedColor {}
extension UInt16: AxcUnifiedColor {}
extension UInt32: AxcUnifiedColor {}
extension UInt64: AxcUnifiedColor {}
extension String: AxcUnifiedColor {}
