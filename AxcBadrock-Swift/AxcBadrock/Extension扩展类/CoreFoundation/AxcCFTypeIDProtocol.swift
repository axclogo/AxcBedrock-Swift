//
//  AxcCFTypeProtocol.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/5/15.
//

import UIKit

/// CF统一类型协议
public protocol AxcCFTypeIDProtocol {
    static var typeID: CFTypeID { get }
}

// MARK: Core Foundation
extension CGFont:           AxcCFTypeIDProtocol {}
extension CGColor:          AxcCFTypeIDProtocol {}
extension CGImage:          AxcCFTypeIDProtocol {}
extension CGLayer:          AxcCFTypeIDProtocol {}
extension CGPath:           AxcCFTypeIDProtocol {}

// MARK: Core Text
extension CTFont:   AxcCFTypeIDProtocol {
    public static var typeID: CFTypeID { return CTFontGetTypeID() }
}
extension CFString: AxcCFTypeIDProtocol {
    public static var typeID: CFTypeID { return CFStringGetTypeID() }
}



