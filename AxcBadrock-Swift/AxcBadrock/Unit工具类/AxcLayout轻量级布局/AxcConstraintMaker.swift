//
//  AxcConstraintMaker.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

public class AxcConstraintMaker {
    /// 已使用的布局属性
    var useConstraint: [AxcConstraintAttributes] = []
    
    public var left: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.left)
    }
    public var isMakeLeft: Bool { return useConstraint.contains(.left) }
    
    public var top: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.top)
    }
    public var isMakeTop: Bool { return useConstraint.contains(.top) }
    
    public var bottom: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.bottom)
    }
    public var isMakeBottom: Bool { return useConstraint.contains(.bottom) }
    
    public var right: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.right)
    }
    public var isMakeRight: Bool { return useConstraint.contains(.right) }
    
    public var leading: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.leading)
    }
    public var isMakeLeading: Bool { return useConstraint.contains(.leading) }
    
    public var trailing: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.trailing)
    }
    public var isMakeTrailing: Bool { return useConstraint.contains(.trailing) }
    
    public var width: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.width)
    }
    public var isMakeWidth: Bool { return useConstraint.contains(.width) }
    
    public var height: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.height)
    }
    public var isMakeHeight: Bool { return useConstraint.contains(.height) }
    
    public var centerX: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.centerX)
    }
    public var isMakeCenterX: Bool { return useConstraint.contains(.centerX) }
    
    public var centerY: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.centerY)
    }
    public var isMakeCenterY: Bool { return useConstraint.contains(.centerY) }
    
    public var lastBaseline: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.lastBaseline)
    }
    public var isMakeLastBaseline: Bool { return useConstraint.contains(.leading) }
    
    public var firstBaseline: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.firstBaseline)
    }
    public var isMakeFirstBaseline: Bool { return useConstraint.contains(.firstBaseline) }
    
    public var leftMargin: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.leftMargin)
    }
    public var isMakeLeftMargin: Bool { return useConstraint.contains(.leftMargin) }
    
    public var rightMargin: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.rightMargin)
    }
    public var isMakeRightMargin: Bool { return useConstraint.contains(.rightMargin) }
    
    public var topMargin: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.topMargin)
    }
    public var isMakeTopMargin: Bool { return useConstraint.contains(.topMargin) }
    
    public var bottomMargin: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.bottomMargin)
    }
    public var isMakeBottomMargin: Bool { return useConstraint.contains(.bottomMargin) }
    
    public var leadingMargin: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.leadingMargin)
    }
    public var isMakeLeadingMargin: Bool { return useConstraint.contains(.leadingMargin) }
    
    public var trailingMargin: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.trailingMargin)
    }
    public var isMakeTrailingMargin: Bool { return useConstraint.contains(.trailingMargin) }
    
    public var centerXWithinMargins: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.centerXWithinMargins)
    }
    public var isMakeCenterXWithinMargins: Bool { return useConstraint.contains(.centerXWithinMargins) }
    
    public var centerYWithinMargins: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.centerYWithinMargins)
    }
    public var isMakeCenterYWithinMargins: Bool { return useConstraint.contains(.centerYWithinMargins) }
    
    
    public var edges: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.edges)
    }
    public var isMakeEdges: Bool { return useConstraint.contains(.edges) }
    
    public var horizontalEdges: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.horizontalEdges)
    }
    public var isMakeHorizontalEdges: Bool { return useConstraint.contains(.horizontalEdges) }
    
    public var verticalEdges: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.verticalEdges)
    }
    public var isMakeVerticalEdges: Bool { return useConstraint.contains(.verticalEdges) }
    
    public var directionalEdges: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.directionalEdges)
    }
    public var isMakeDirectionalEdges: Bool { return useConstraint.contains(.directionalEdges) }
    
    public var directionalHorizontalEdges: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.directionalHorizontalEdges)
    }
    public var isMakeDirectionalHorizontalEdges: Bool { return useConstraint.contains(.directionalHorizontalEdges) }
    
    public var directionalVerticalEdges: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.directionalVerticalEdges)
    }
    public var isMakeDirectionalVerticalEdges: Bool { return useConstraint.contains(.directionalVerticalEdges) }
    
    public var size: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.size)
    }
    public var isMakeSize: Bool { return useConstraint.contains(.size) }
    
    public var center: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.center)
    }
    public var isMakeCenter: Bool { return useConstraint.contains(.center) }
    
    
    public var margins: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.margins)
    }
    public var isMakeMargins: Bool { return useConstraint.contains(.margins) }
    
    public var directionalMargins: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.directionalMargins)
    }
    public var isMakeDirectionalMargins: Bool { return useConstraint.contains(.directionalMargins) }
    
    public var centerWithinMargins: AxcConstraintMakerExtendable {
        return makeExtendableWithAttributes(.centerWithinMargins)
    }
    public var isMakeCenterWithinMargins: Bool { return useConstraint.contains(.centerWithinMargins) }
    
    
    private let item: AxcLayoutConstraintItem
    private var descriptions = [AxcConstraintDescription]()
    
    internal init(item: AxcLayoutConstraintItem) {
        self.item = item
        self.item.prepare()
    }
    
    internal func makeExtendableWithAttributes(_ attributes: AxcConstraintAttributes) -> AxcConstraintMakerExtendable {
        useConstraint.append(attributes)
        let description = AxcConstraintDescription(item: item, attributes: attributes)
        descriptions.append(description)
        return AxcConstraintMakerExtendable(description)
    }
    
    internal static func prepareConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) -> [AxcConstraint] {
        let maker = AxcConstraintMaker(item: item)
        closure(maker)
        var constraints: [AxcConstraint] = []
        for description in maker.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
        return constraints
    }
    
    internal static func makeConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) {
        let constraints = prepareConstraints(item: item, closure: closure)
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: false)
        }
    }
    
    internal static func remakeConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) {
        removeConstraints(item: item)
        makeConstraints(item: item, closure: closure)
    }
    
    internal static func updateConstraints(item: AxcLayoutConstraintItem, closure: (_ make: AxcConstraintMaker) -> Void) {
        guard item.constraints.count > 0 else {
            makeConstraints(item: item, closure: closure)
            return
        }
        
        let constraints = prepareConstraints(item: item, closure: closure)
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: true)
        }
    }
    
    internal static func removeConstraints(item: AxcLayoutConstraintItem) {
        let constraints = item.constraints
        for constraint in constraints {
            constraint.deactivateIfNeeded()
        }
    }
    
}
