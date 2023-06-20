//
//  AxcConstraintMakerExtendable.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

public class AxcConstraintMakerRelatable {
    internal let description: AxcConstraintDescription
    internal init(_ description: AxcConstraintDescription) {
        self.description = description
    }
    internal func relatedTo(_ other: AxcConstraintRelatableTarget, relation: AxcConstraintRelation, file: String, line: UInt) -> AxcConstraintMakerEditable {
        let related: AxcConstraintItem
        let constant: AxcConstraintConstantTarget
        let editable = AxcConstraintMakerEditable(self.description)
        
        if let other = other as? AxcConstraintItem {
            guard other.attributes == AxcConstraintAttributes.none ||
                    other.attributes.layoutAttributes.count <= 1 ||
                    other.attributes.layoutAttributes == self.description.attributes.layoutAttributes ||
                    other.attributes == .edges && self.description.attributes == .margins ||
                    other.attributes == .margins && self.description.attributes == .edges ||
                    other.attributes == .directionalEdges && self.description.attributes == .directionalMargins ||
                    other.attributes == .directionalMargins && self.description.attributes == .directionalEdges else {
                
                let logStr = "不能约束多个不同的属性. (\(file), \(line))"
                if AxcBadrock.fatalError { fatalError(logStr) }
                AxcLog(logStr, level: .fatal)
                return editable
            }
            related = other
            constant = 0.0
        } else if let other = other as? UIView {
            related = AxcConstraintItem(target: other, attributes: AxcConstraintAttributes.none)
            constant = 0.0
        } else if let other = other as? AxcConstraintConstantTarget {
            related = AxcConstraintItem(target: nil, attributes: AxcConstraintAttributes.none)
            constant = other
        } else if #available(iOS 9.0, OSX 10.11, *), let other = other as? UILayoutGuide {
            related = AxcConstraintItem(target: other, attributes: AxcConstraintAttributes.none)
            constant = 0.0
        } else {
            let logStr = "无效约束. (\(file), \(line))"
            if AxcBadrock.fatalError { fatalError(logStr) }
            AxcLog(logStr, level: .fatal)
            return editable
        }
        
        editable.description.sourceLocation = (file, line)
        editable.description.relation = relation
        editable.description.related = related
        editable.description.constant = constant
        return editable
    }
    
    @discardableResult
    public func equalTo(_ other: AxcConstraintRelatableTarget, _ file: String = #file, _ line: UInt = #line) -> AxcConstraintMakerEditable {
        return self.relatedTo(other, relation: .equal, file: file, line: line)
    }
    
    @discardableResult
    public func equalToSuperview(_ file: String = #file, _ line: UInt = #line) -> AxcConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("试图获取父视图，但在尝试make constraint ' equalToSuperview '时发现为nil`.")
        }
        return self.relatedTo(other, relation: .equal, file: file, line: line)
    }
    
    @discardableResult
    public func lessThanOrEqualTo(_ other: AxcConstraintRelatableTarget, _ file: String = #file, _ line: UInt = #line) -> AxcConstraintMakerEditable {
        return self.relatedTo(other, relation: .lessThanOrEqual, file: file, line: line)
    }
    
    @discardableResult
    public func lessThanOrEqualToSuperview(_ file: String = #file, _ line: UInt = #line) -> AxcConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("试图获取父视图，但在尝试make constraint ' lessThanOrEqualToSuperview '时发现为nil`.")
        }
        return self.relatedTo(other, relation: .lessThanOrEqual, file: file, line: line)
    }
    
    @discardableResult
    public func greaterThanOrEqualTo(_ other: AxcConstraintRelatableTarget, _ file: String = #file, line: UInt = #line) -> AxcConstraintMakerEditable {
        return self.relatedTo(other, relation: .greaterThanOrEqual, file: file, line: line)
    }
    
    @discardableResult
    public func greaterThanOrEqualToSuperview(_ file: String = #file, line: UInt = #line) -> AxcConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("试图获取父视图，但在尝试创建约束' greaterThanOrEqualToSuperview '时发现为nil.")
        }
        return self.relatedTo(other, relation: .greaterThanOrEqual, file: file, line: line)
    }
}

//MARK: 扩展
extension AxcConstraintMakerRelatable {
  
    @discardableResult
    public func equalToSuperview<T: AxcConstraintRelatableTarget>(_ closure: (UIView) -> T, _ file: String = #file, line: UInt = #line) -> AxcConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("试图获取父视图，但在尝试创建约束' equalToSuperview '时发现为nil.")
        }
        return self.relatedTo(closure(other), relation: .equal, file: file, line: line)
    }
  
    @discardableResult
    public func lessThanOrEqualToSuperview<T: AxcConstraintRelatableTarget>(_ closure: (UIView) -> T, _ file: String = #file, line: UInt = #line) -> AxcConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("试图获取父视图，但在尝试创建约束' lessThanOrEqualToSuperview '时发现为nil.")
        }
        return self.relatedTo(closure(other), relation: .lessThanOrEqual, file: file, line: line)
    }
  
    @discardableResult
    public func greaterThanOrEqualTo<T: AxcConstraintRelatableTarget>(_ closure: (UIView) -> T, _ file: String = #file, line: UInt = #line) -> AxcConstraintMakerEditable {
        guard let other = self.description.item.superview else {
            fatalError("试图获取父视图，但在尝试创建约束' greaterThanOrEqualToSuperview '时发现为nil.")
        }
        return self.relatedTo(closure(other), relation: .greaterThanOrEqual, file: file, line: line)
    }
  
}
