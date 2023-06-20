//
//  AxcConstraintDSL.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

public protocol AxcConstraintDSL {
    var target: AnyObject? { get }
    func setLabel(_ value: String?)
    func label() -> String?
}

extension AxcConstraintDSL {
    public func setLabel(_ value: String?) {
        objc_setAssociatedObject(self.target as Any, &labelKey, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    public func label() -> String? {
        return objc_getAssociatedObject(self.target as Any, &labelKey) as? String
    }
}
private var labelKey: UInt8 = 0

public protocol AxcConstraintBasicAttributesDSL : AxcConstraintDSL {}
extension AxcConstraintBasicAttributesDSL {
    // MARK: 基础
    public var left: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.left)
    }
    public var top: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.top)
    }
    public var right: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.right)
    }
    public var bottom: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.bottom)
    }
    public var leading: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.leading)
    }
    public var trailing: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.trailing)
    }
    public var width: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.width)
    }
    public var height: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.height)
    }
    public var centerX: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.centerX)
    }
    public var centerY: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.centerY)
    }
    public var edges: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.edges)
    }
    public var directionalEdges: AxcConstraintItem {
      return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.directionalEdges)
    }
    public var horizontalEdges: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.horizontalEdges)
    }
    public var verticalEdges: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.verticalEdges)
    }
    public var directionalHorizontalEdges: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.directionalHorizontalEdges)
    }
    public var directionalVerticalEdges: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.directionalVerticalEdges)
    }
    public var size: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.size)
    }
    public var center: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.center)
    }
}

public protocol AxcConstraintAttributesDSL : AxcConstraintBasicAttributesDSL {}
extension AxcConstraintAttributesDSL {
    // MARK: 基线
    public var lastBaseline: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.lastBaseline)
    }
    public var firstBaseline: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.firstBaseline)
    }
    
    // MARK: 间距
    public var leftMargin: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.leftMargin)
    }
    public var topMargin: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.topMargin)
    }
    public var rightMargin: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.rightMargin)
    }
    public var bottomMargin: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.bottomMargin)
    }
    public var leadingMargin: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.leadingMargin)
    }
    public var trailingMargin: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.trailingMargin)
    }
    public var centerXWithinMargins: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.centerXWithinMargins)
    }
    public var centerYWithinMargins: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.centerYWithinMargins)
    }
    public var margins: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.margins)
    }
    public var directionalMargins: AxcConstraintItem {
      return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.directionalMargins)
    }
    public var centerWithinMargins: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.centerWithinMargins)
    }
}
