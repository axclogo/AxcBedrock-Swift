//
//  AxcConstraintDescription.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

public class AxcConstraintDescription {
    internal let item: AxcLayoutConstraintItem
    internal var attributes: AxcConstraintAttributes
    internal var relation: AxcConstraintRelation? = nil
    internal var sourceLocation: (String, UInt)? = nil
    internal var label: String? = nil
    internal var related: AxcConstraintItem? = nil
    internal var multiplier: AxcConstraintMultiplierTarget = 1.0
    internal var constant: AxcConstraintConstantTarget = 0.0
    internal var priority: AxcConstraintPriorityTarget = 1000.0
    internal lazy var constraint: AxcConstraint? = {
        guard let relation = self.relation,
              let related = self.related,
              let sourceLocation = self.sourceLocation else {
            return nil
        }
        let from = AxcConstraintItem(target: self.item, attributes: self.attributes)
        
        return AxcConstraint(
            from: from,
            to: related,
            relation: relation,
            sourceLocation: sourceLocation,
            label: self.label,
            multiplier: self.multiplier,
            constant: self.constant,
            priority: self.priority
        )
    }()
    // MARK: 初始化
    internal init(item: AxcLayoutConstraintItem, attributes: AxcConstraintAttributes) {
        self.item = item
        self.attributes = attributes
    }
}
