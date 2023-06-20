//
//  AxcConstraintAttributes.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

internal struct AxcConstraintAttributes : OptionSet, ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = UInt
    internal init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    internal init(_ rawValue: UInt) {
        self.init(rawValue: rawValue)
    }
    internal init(nilLiteral: ()) {
        self.rawValue = 0
    }
    internal init(integerLiteral rawValue: IntegerLiteralType) {
        self.init(rawValue: rawValue)
    }
    internal private(set) var rawValue: UInt
    internal static var allZeros: AxcConstraintAttributes { return 0 }
    internal static func convertFromNilLiteral() -> AxcConstraintAttributes { return 0 }
    internal var boolValue: Bool { return self.rawValue != 0 }
    
    internal func toRaw() -> UInt { return self.rawValue }
    internal static func fromRaw(_ raw: UInt) -> AxcConstraintAttributes? { return self.init(raw) }
    internal static func fromMask(_ raw: UInt) -> AxcConstraintAttributes { return self.init(raw) }
    
    // 常规使用
    internal static let none:           AxcConstraintAttributes = 0
    internal static let left:           AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 0)
    internal static let top:            AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 1)
    internal static let right:          AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 2)
    internal static let bottom:         AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 3)
    internal static let leading:        AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 4)
    internal static let trailing:       AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 5)
    internal static let width:          AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 6)
    internal static let height:         AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 7)
    internal static let centerX:        AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 8)
    internal static let centerY:        AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 9)
    internal static let lastBaseline:   AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 10)
    // 综合使用
    internal static let firstBaseline:  AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 11)
    internal static let leftMargin:     AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 12)
    internal static let rightMargin:    AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 13)
    internal static let topMargin:      AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 14)
    internal static let bottomMargin:   AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 15)
    internal static let leadingMargin:  AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 16)
    internal static let trailingMargin: AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 17)
    internal static let centerXWithinMargins: AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 18)
    internal static let centerYWithinMargins: AxcConstraintAttributes = AxcConstraintAttributes(UInt(1) << 19)
    // 嵌套使用
    internal static let edges:                      AxcConstraintAttributes = [.horizontalEdges, .verticalEdges]
    internal static let horizontalEdges:            AxcConstraintAttributes = [.left, .right]
    internal static let verticalEdges:              AxcConstraintAttributes = [.top, .bottom]
    internal static let directionalEdges:           AxcConstraintAttributes = [.directionalHorizontalEdges, .directionalVerticalEdges]
    internal static let directionalHorizontalEdges: AxcConstraintAttributes = [.leading, .trailing]
    internal static let directionalVerticalEdges:   AxcConstraintAttributes = [.top, .bottom]
    internal static let size:                       AxcConstraintAttributes = [.width, .height]
    internal static let center:                     AxcConstraintAttributes = [.centerX, .centerY]
    internal static let margins:                    AxcConstraintAttributes = [.leftMargin, .topMargin, .rightMargin, .bottomMargin]
    internal static let directionalMargins:         AxcConstraintAttributes = [.leadingMargin, .topMargin, .trailingMargin, .bottomMargin]
    internal static let centerWithinMargins:        AxcConstraintAttributes = [.centerXWithinMargins, .centerYWithinMargins]
    
    // 布局属性
    internal var layoutAttributes:[NSLayoutConstraint.Attribute] {
        var attrs = [NSLayoutConstraint.Attribute]()
        if (self.contains(.left)) {
            attrs.append(.left)
        }
        if (self.contains(.top)) {
            attrs.append(.top)
        }
        if (self.contains(.right)) {
            attrs.append(.right)
        }
        if (self.contains(.bottom)) {
            attrs.append(.bottom)
        }
        if (self.contains(.leading)) {
            attrs.append(.leading)
        }
        if (self.contains(.trailing)) {
            attrs.append(.trailing)
        }
        if (self.contains(.width)) {
            attrs.append(.width)
        }
        if (self.contains(.height)) {
            attrs.append(.height)
        }
        if (self.contains(.centerX)) {
            attrs.append(.centerX)
        }
        if (self.contains(.centerY)) {
            attrs.append(.centerY)
        }
        if (self.contains(.lastBaseline)) {
            attrs.append(.lastBaseline)
        }
        if (self.contains(.firstBaseline)) {
            attrs.append(.firstBaseline)
        }
        if (self.contains(.leftMargin)) {
            attrs.append(.leftMargin)
        }
        if (self.contains(.rightMargin)) {
            attrs.append(.rightMargin)
        }
        if (self.contains(.topMargin)) {
            attrs.append(.topMargin)
        }
        if (self.contains(.bottomMargin)) {
            attrs.append(.bottomMargin)
        }
        if (self.contains(.leadingMargin)) {
            attrs.append(.leadingMargin)
        }
        if (self.contains(.trailingMargin)) {
            attrs.append(.trailingMargin)
        }
        if (self.contains(.centerXWithinMargins)) {
            attrs.append(.centerXWithinMargins)
        }
        if (self.contains(.centerYWithinMargins)) {
            attrs.append(.centerYWithinMargins)
        }
        return attrs
    }
}

internal func + (left: AxcConstraintAttributes, right: AxcConstraintAttributes) -> AxcConstraintAttributes {
    return left.union(right)
}

internal func += (left: inout AxcConstraintAttributes, right: AxcConstraintAttributes) {
    left.formUnion(right)
}

internal func -= (left: inout AxcConstraintAttributes, right: AxcConstraintAttributes) {
    left.subtract(right)
}

internal func == (left: AxcConstraintAttributes, right: AxcConstraintAttributes) -> Bool {
    return left.rawValue == right.rawValue
}
