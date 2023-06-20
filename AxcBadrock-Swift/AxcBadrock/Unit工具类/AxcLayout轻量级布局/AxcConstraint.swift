//
//  AxcConstraint.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

public final class AxcConstraint {
    internal let sourceLocation: (String, UInt)
    internal let label: String?
    
    private let from: AxcConstraintItem
    private let to: AxcConstraintItem
    private let relation: AxcConstraintRelation
    private let multiplier: AxcConstraintMultiplierTarget
    private var constant: AxcConstraintConstantTarget {
        didSet {
            self.updateConstantAndPriorityIfNeeded()
        }
    }
    private var priority: AxcConstraintPriorityTarget {
        didSet {
            self.updateConstantAndPriorityIfNeeded()
        }
    }
    public var layoutConstraints: [AxcLayoutConstraint]
    
    public var isActive: Bool {
        set {
            if newValue {
                activate()
            }
            else {
                deactivate()
            }
        }
        
        get {
            for layoutConstraint in self.layoutConstraints {
                if layoutConstraint.isActive {
                    return true
                }
            }
            return false
        }
    }
    
    // MARK: 初始化
    internal init(from: AxcConstraintItem,
                  to: AxcConstraintItem,
                  relation: AxcConstraintRelation,
                  sourceLocation: (String, UInt),
                  label: String?,
                  multiplier: AxcConstraintMultiplierTarget,
                  constant: AxcConstraintConstantTarget,
                  priority: AxcConstraintPriorityTarget) {
        self.from = from
        self.to = to
        self.relation = relation
        self.sourceLocation = sourceLocation
        self.label = label
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
        self.layoutConstraints = []
        
        let layoutFromAttributes = self.from.attributes.layoutAttributes
        let layoutToAttributes = self.to.attributes.layoutAttributes
        let layoutFrom = self.from.layoutConstraintItem!
        let layoutRelation = self.relation.layoutRelation
        for layoutFromAttribute in layoutFromAttributes {
            let layoutToAttribute: NSLayoutConstraint.Attribute
            if layoutToAttributes.count > 0 {
                if self.from.attributes == .edges && self.to.attributes == .margins {
                    switch layoutFromAttribute {
                    case .left:
                        layoutToAttribute = .leftMargin
                    case .right:
                        layoutToAttribute = .rightMargin
                    case .top:
                        layoutToAttribute = .topMargin
                    case .bottom:
                        layoutToAttribute = .bottomMargin
                    default:
                        if AxcBadrock.fatalError { fatalError() }
                        AxcLog("致命的布局错误", level: .fatal)
                        return
                    }
                } else if self.from.attributes == .margins && self.to.attributes == .edges {
                    switch layoutFromAttribute {
                    case .leftMargin:
                        layoutToAttribute = .left
                    case .rightMargin:
                        layoutToAttribute = .right
                    case .topMargin:
                        layoutToAttribute = .top
                    case .bottomMargin:
                        layoutToAttribute = .bottom
                    default:
                        if AxcBadrock.fatalError { fatalError() }
                        AxcLog("致命的布局错误", level: .fatal)
                        return
                    }
                } else if self.from.attributes == .directionalEdges && self.to.attributes == .directionalMargins {
                    switch layoutFromAttribute {
                    case .leading:
                        layoutToAttribute = .leadingMargin
                    case .trailing:
                        layoutToAttribute = .trailingMargin
                    case .top:
                        layoutToAttribute = .topMargin
                    case .bottom:
                        layoutToAttribute = .bottomMargin
                    default:
                        if AxcBadrock.fatalError { fatalError() }
                        AxcLog("致命的布局错误", level: .fatal)
                        return
                    }
                } else if self.from.attributes == .directionalMargins && self.to.attributes == .directionalEdges {
                    switch layoutFromAttribute {
                    case .leadingMargin:
                        layoutToAttribute = .leading
                    case .trailingMargin:
                        layoutToAttribute = .trailing
                    case .topMargin:
                        layoutToAttribute = .top
                    case .bottomMargin:
                        layoutToAttribute = .bottom
                    default:
                        if AxcBadrock.fatalError { fatalError() }
                        AxcLog("致命的布局错误", level: .fatal)
                        return
                    }
                } else if self.from.attributes == self.to.attributes {
                    layoutToAttribute = layoutFromAttribute
                } else {
                    layoutToAttribute = layoutToAttributes[0]
                }
            } else {
                if self.to.target == nil && (layoutFromAttribute == .centerX || layoutFromAttribute == .centerY) {
                    layoutToAttribute = layoutFromAttribute == .centerX ? .left : .top
                } else {
                    layoutToAttribute = layoutFromAttribute
                }
            }
            let layoutConstant: CGFloat = self.constant.constraintConstantTargetValueFor(layoutAttribute: layoutToAttribute)
            var layoutTo: AnyObject? = self.to.target
            if layoutTo == nil && layoutToAttribute != .width && layoutToAttribute != .height {
                layoutTo = layoutFrom.superview
            }
            let layoutConstraint = AxcLayoutConstraint(
                item: layoutFrom,
                attribute: layoutFromAttribute,
                relatedBy: layoutRelation,
                toItem: layoutTo,
                attribute: layoutToAttribute,
                multiplier: self.multiplier.constraintMultiplierTargetValue,
                constant: layoutConstant
            )
            layoutConstraint.label = self.label
            layoutConstraint.priority = UILayoutPriority(rawValue: self.priority.constraintPriorityTargetValue)
            layoutConstraint.constraint = self
            self.layoutConstraints.append(layoutConstraint)
        }
    }
    
    // MARK: 开放函数
    public func activate() {
        self.activateIfNeeded()
    }
    public func deactivate() {
        self.deactivateIfNeeded()
    }
    
    @discardableResult
    public func update(offset: AxcConstraintOffsetTarget) -> AxcConstraint {
        self.constant = offset.constraintOffsetTargetValue
        return self
    }
    
    @discardableResult
    public func update(inset: AxcConstraintInsetTarget) -> AxcConstraint {
        self.constant = inset.constraintInsetTargetValue
        return self
    }
    
    @discardableResult
    @available(iOS 11.0, tvOS 11.0, *)
    public func update(inset: AxcConstraintDirectionalInsetTarget) -> AxcConstraint {
        self.constant = inset.constraintDirectionalInsetTargetValue
        return self
    }
    
    @discardableResult
    public func update(priority: AxcConstraintPriorityTarget) -> AxcConstraint {
        self.priority = priority.constraintPriorityTargetValue
        return self
    }
    
    @discardableResult
    public func update(priority: AxcConstraintPriority) -> AxcConstraint {
        self.priority = priority.value
        return self
    }
    
    // MARK: 内部
    internal func updateConstantAndPriorityIfNeeded() {
        for layoutConstraint in self.layoutConstraints {
            let attribute = (layoutConstraint.secondAttribute == .notAnAttribute) ? layoutConstraint.firstAttribute : layoutConstraint.secondAttribute
            layoutConstraint.constant = self.constant.constraintConstantTargetValueFor(layoutAttribute: attribute)
            
            let requiredPriority = AxcConstraintPriority.required.value
            if (layoutConstraint.priority.rawValue < requiredPriority), (self.priority.constraintPriorityTargetValue != requiredPriority) {
                layoutConstraint.priority = UILayoutPriority(rawValue: self.priority.constraintPriorityTargetValue)
            }
        }
    }
    
    internal func activateIfNeeded(updatingExisting: Bool = false) {
        guard let item = self.from.layoutConstraintItem else { return }
        let layoutConstraints = self.layoutConstraints
        
        if updatingExisting {
            var existingLayoutConstraints: [AxcLayoutConstraint] = []
            for constraint in item.constraints {
                existingLayoutConstraints += constraint.layoutConstraints
            }
            
            for layoutConstraint in layoutConstraints {
                let existingLayoutConstraint = existingLayoutConstraints.first { $0 == layoutConstraint }
                guard let updateLayoutConstraint = existingLayoutConstraint else {
                    let logStr = "更新后的约束无法找到要更新的现有匹配约束: \(layoutConstraint)"
                    if AxcBadrock.fatalError { fatalError(logStr) }
                    AxcLog(logStr, level: .fatal)
                    return
                }
                
                let updateLayoutAttribute = (updateLayoutConstraint.secondAttribute == .notAnAttribute) ? updateLayoutConstraint.firstAttribute : updateLayoutConstraint.secondAttribute
                updateLayoutConstraint.constant = self.constant.constraintConstantTargetValueFor(layoutAttribute: updateLayoutAttribute)
            }
        } else {
            NSLayoutConstraint.activate(layoutConstraints)
            item.add(constraints: [self])
        }
    }
    
    internal func deactivateIfNeeded() {
        guard let item = self.from.layoutConstraintItem else {
            AxcLog("警告: 从约束中获取项失败。解除行操作是无效的", level: .warning)
            return
        }
        let layoutConstraints = self.layoutConstraints
        NSLayoutConstraint.deactivate(layoutConstraints)
        item.remove(constraints: [self])
    }
}

// MARK: - 配置
public struct AxcConstraintConfig {
    public static var interfaceLayoutDirection: UIUserInterfaceLayoutDirection = .leftToRight
}

// MARK: - 间距触发者
public protocol AxcConstraintDirectionalInsetTarget: AxcConstraintConstantTarget {}
@available(iOS 11.0, tvOS 11.0, *)
extension NSDirectionalEdgeInsets: AxcConstraintDirectionalInsetTarget {}
extension AxcConstraintDirectionalInsetTarget {
    @available(iOS 11.0, tvOS 11.0, *)
    internal var constraintDirectionalInsetTargetValue: NSDirectionalEdgeInsets {
        if let amount = self as? NSDirectionalEdgeInsets {
            return amount
        } else {
            return NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
    }
}

// MARK: - 协议
// MARK: AxcConstraintInsetTarget
public protocol AxcConstraintInsetTarget: AxcConstraintConstantTarget {}
extension Int:          AxcConstraintInsetTarget {}
extension UInt:         AxcConstraintInsetTarget {}
extension Float:        AxcConstraintInsetTarget {}
extension Double:       AxcConstraintInsetTarget {}
extension CGFloat:      AxcConstraintInsetTarget {}
extension UIEdgeInsets: AxcConstraintInsetTarget {}

extension AxcConstraintInsetTarget {
    internal var constraintInsetTargetValue: UIEdgeInsets {
        if let amount = self as? UIEdgeInsets {
            return amount
        } else if let amount = self as? Float {
            return UIEdgeInsets(top: CGFloat(amount), left: CGFloat(amount), bottom: CGFloat(amount), right: CGFloat(amount))
        } else if let amount = self as? Double {
            return UIEdgeInsets(top: CGFloat(amount), left: CGFloat(amount), bottom: CGFloat(amount), right: CGFloat(amount))
        } else if let amount = self as? CGFloat {
            return UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
        } else if let amount = self as? Int {
            return UIEdgeInsets(top: CGFloat(amount), left: CGFloat(amount), bottom: CGFloat(amount), right: CGFloat(amount))
        } else if let amount = self as? UInt {
            return UIEdgeInsets(top: CGFloat(amount), left: CGFloat(amount), bottom: CGFloat(amount), right: CGFloat(amount))
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
}

// MARK: AxcConstraintMultiplierTarget
public protocol AxcConstraintMultiplierTarget {
    var constraintMultiplierTargetValue: CGFloat { get }
}
extension Int: AxcConstraintMultiplierTarget {
    public var constraintMultiplierTargetValue: CGFloat { return CGFloat(self) }
}
extension UInt: AxcConstraintMultiplierTarget {
    public var constraintMultiplierTargetValue: CGFloat { return CGFloat(self) }
}
extension Float: AxcConstraintMultiplierTarget {
    public var constraintMultiplierTargetValue: CGFloat { return CGFloat(self) }
}
extension Double: AxcConstraintMultiplierTarget {
    public var constraintMultiplierTargetValue: CGFloat { return CGFloat(self) }
}
extension CGFloat: AxcConstraintMultiplierTarget {
    public var constraintMultiplierTargetValue: CGFloat { return self }
}

// MARK: AxcConstraintOffsetTarget
public protocol AxcConstraintOffsetTarget: AxcConstraintConstantTarget {}
extension Int:      AxcConstraintOffsetTarget {}
extension UInt:     AxcConstraintOffsetTarget {}
extension Float:    AxcConstraintOffsetTarget {}
extension Double:   AxcConstraintOffsetTarget {}
extension CGFloat:  AxcConstraintOffsetTarget {}
extension AxcConstraintOffsetTarget {
    internal var constraintOffsetTargetValue: CGFloat {
        let offset: CGFloat
        if let amount = self as? Float {
            offset = CGFloat(amount)
        } else if let amount = self as? Double {
            offset = CGFloat(amount)
        } else if let amount = self as? CGFloat {
            offset = CGFloat(amount)
        } else if let amount = self as? Int {
            offset = CGFloat(amount)
        } else if let amount = self as? UInt {
            offset = CGFloat(amount)
        } else {
            offset = 0.0
        }
        return offset
    }
}

// MARK: AxcConstraintPriorityTarget
public protocol AxcConstraintPriorityTarget {
    var constraintPriorityTargetValue: Float { get }
}
extension Int: AxcConstraintPriorityTarget {
    public var constraintPriorityTargetValue: Float { return Float(self) }
}

extension UInt: AxcConstraintPriorityTarget {
    public var constraintPriorityTargetValue: Float { return Float(self) }
}

extension Float: AxcConstraintPriorityTarget {
    public var constraintPriorityTargetValue: Float { return self }
}

extension Double: AxcConstraintPriorityTarget {
    public var constraintPriorityTargetValue: Float { return Float(self) }
}

extension CGFloat: AxcConstraintPriorityTarget {
    public var constraintPriorityTargetValue: Float { return Float(self) }
}

extension UILayoutPriority: AxcConstraintPriorityTarget {
    public var constraintPriorityTargetValue: Float { return self.rawValue }
}

// MARK: AxcConstraintRelatableTarget
public protocol AxcConstraintRelatableTarget {}
extension Int:                      AxcConstraintRelatableTarget {}
extension UInt:                     AxcConstraintRelatableTarget {}
extension Float:                    AxcConstraintRelatableTarget {}
extension Double:                   AxcConstraintRelatableTarget {}
extension CGFloat:                  AxcConstraintRelatableTarget {}
extension CGSize:                   AxcConstraintRelatableTarget {}
extension CGPoint:                  AxcConstraintRelatableTarget {}
extension UIEdgeInsets:             AxcConstraintRelatableTarget {}
@available(iOS 11.0, *)
extension NSDirectionalEdgeInsets:  AxcConstraintRelatableTarget {}
extension AxcConstraintItem:        AxcConstraintRelatableTarget {}
extension UIView:                   AxcConstraintRelatableTarget {}
extension UILayoutGuide:            AxcConstraintRelatableTarget {}

// MARK: - Item
public final class AxcConstraintItem {
    internal weak var target: AnyObject?
    internal let attributes: AxcConstraintAttributes
    internal init(target: AnyObject?, attributes: AxcConstraintAttributes) {
        self.target = target
        self.attributes = attributes
    }
    internal var layoutConstraintItem: AxcLayoutConstraintItem? {
        return self.target as? AxcLayoutConstraintItem
    }
}

public func ==(lhs: AxcConstraintItem, rhs: AxcConstraintItem) -> Bool {
    guard lhs !== rhs else {
        return true
    }
    guard let target1 = lhs.target,
          let target2 = rhs.target,
          target1 === target2 && lhs.attributes == rhs.attributes else {
        return false
    }
    return true
}

// MARK: - UILayoutExtension
public extension UILayoutGuide {
    var axc: AxcUILayoutGuideDSL { return AxcUILayoutGuideDSL(guide: self) }
}
public extension UIView {
    var axc: AxcUIViewDSL { return AxcUIViewDSL(view: self) }
}
public extension UILayoutSupport {
    var axc: AxcLayoutSupportDSL { return AxcLayoutSupportDSL(support: self) }
}


// MARK: - make/remake/update/remove
public struct AxcUILayoutGuideDSL: AxcConstraintAttributesDSL {
    @discardableResult
    public func prepareConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) -> [AxcConstraint] {
        return AxcConstraintMaker.prepareConstraints(item: self.guide, closure: closure)
    }
    public func makeConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) {
        AxcConstraintMaker.makeConstraints(item: self.guide, closure: closure)
    }
    public func remakeConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) {
        AxcConstraintMaker.remakeConstraints(item: self.guide, closure: closure)
    }
    public func updateConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) {
        AxcConstraintMaker.updateConstraints(item: self.guide, closure: closure)
    }
    public func removeConstraints() {
        AxcConstraintMaker.removeConstraints(item: self.guide)
    }
    public var target: AnyObject? {
        return self.guide
    }
    internal let guide: UILayoutGuide
    internal init(guide: UILayoutGuide) {
        self.guide = guide
    }
}

// MARK: - UILayoutSupportDSL
public struct AxcLayoutSupportDSL: AxcConstraintDSL {
    public var target: AnyObject? {
        return self.support
    }
    internal let support: UILayoutSupport
    internal init(support: UILayoutSupport) {
        self.support = support
    }
    public var top: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.top)
    }
    public var bottom: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.bottom)
    }
    public var height: AxcConstraintItem {
        return AxcConstraintItem(target: self.target, attributes: AxcConstraintAttributes.height)
    }
}

// MARK: - AxcConstraintMakerFinalizable
public class AxcConstraintMakerFinalizable {
    internal let description: AxcConstraintDescription
    internal init(_ description: AxcConstraintDescription) {
        self.description = description
    }
    @discardableResult
    public func labeled(_ label: String) -> AxcConstraintMakerFinalizable {
        self.description.label = label
        return self
    }
    public var constraint: AxcConstraint {
        return self.description.constraint!
    }
}

// MARK: - AxcConstraintMakerFinalizable
public class AxcConstraintMakerPrioritizable: AxcConstraintMakerFinalizable {
    @discardableResult
    public func priority(_ amount: AxcConstraintPriority) -> AxcConstraintMakerFinalizable {
        self.description.priority = amount.value
        return self
    }
    @discardableResult
    public func priority(_ amount: AxcConstraintPriorityTarget) -> AxcConstraintMakerFinalizable {
        self.description.priority = amount
        return self
    }
    @discardableResult
    public func lowPriority() -> AxcConstraintMakerFinalizable {
        self.description.priority = 250
        return self
    }
    @discardableResult
    public func mediumPriority() -> AxcConstraintMakerFinalizable {
        self.description.priority = 500
        return self
    }
    @discardableResult
    public func heightPriority() -> AxcConstraintMakerFinalizable {
        self.description.priority = 750
        return self
    }
}

// MARK: - AxcConstraintPriority
public struct AxcConstraintPriority : ExpressibleByFloatLiteral, Equatable, Strideable {
    public typealias FloatLiteralType = Float
    public let value: Float
    public init(floatLiteral value: Float) {
        self.value = value
    }
    public init(_ value: Float) {
        self.value = value
    }
    public static var required: AxcConstraintPriority {
        return 1000.0
    }
    public static var high: AxcConstraintPriority {
        return 750.0
    }
    public static var medium: AxcConstraintPriority {
        return 500.0
    }
    
    public static var low: AxcConstraintPriority {
        return 250.0
    }
    
    public static func ==(lhs: AxcConstraintPriority, rhs: AxcConstraintPriority) -> Bool {
        return lhs.value == rhs.value
    }
    // MARK: Strideable
    public func advanced(by n: FloatLiteralType) -> AxcConstraintPriority {
        return AxcConstraintPriority(floatLiteral: value + n)
    }
    public func distance(to other: AxcConstraintPriority) -> FloatLiteralType {
        return other.value - value
    }
}

// MARK: AxcConstraintRelation
internal enum AxcConstraintRelation : Int {
    case equal = 1
    case lessThanOrEqual
    case greaterThanOrEqual
    
    internal var layoutRelation: NSLayoutConstraint.Relation {
        get {
            switch(self) {
            case .equal:
                return .equal
            case .lessThanOrEqual:
                return .lessThanOrEqual
            case .greaterThanOrEqual:
                return .greaterThanOrEqual
            }
        }
    }
}

// MARK: AxcUIViewDSL
public struct AxcUIViewDSL: AxcConstraintAttributesDSL {
    @discardableResult
    public func prepareConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) -> [AxcConstraint] {
        return AxcConstraintMaker.prepareConstraints(item: self.view, closure: closure)
    }
    public func makeConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) {
        AxcConstraintMaker.makeConstraints(item: self.view, closure: closure)
    }
    public func remakeConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) {
        AxcConstraintMaker.remakeConstraints(item: self.view, closure: closure)
    }
    public func updateConstraints(_ closure: (_ make: AxcConstraintMaker) -> Void) {
        AxcConstraintMaker.updateConstraints(item: self.view, closure: closure)
    }
    public func removeConstraints() {
        AxcConstraintMaker.removeConstraints(item: self.view)
    }
    public var contentHuggingHorizontalPriority: Float {
        get {
            return self.view.contentHuggingPriority(for: .horizontal).rawValue
        }
        nonmutating set {
            self.view.setContentHuggingPriority(UILayoutPriority(rawValue: newValue), for: .horizontal)
        }
    }
    public var contentHuggingVerticalPriority: Float {
        get {
            return self.view.contentHuggingPriority(for: .vertical).rawValue
        }
        nonmutating set {
            self.view.setContentHuggingPriority(UILayoutPriority(rawValue: newValue), for: .vertical)
        }
    }
    public var contentCompressionResistanceHorizontalPriority: Float {
        get {
            return self.view.contentCompressionResistancePriority(for: .horizontal).rawValue
        }
        nonmutating set {
            self.view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: newValue), for: .horizontal)
        }
    }
    public var contentCompressionResistanceVerticalPriority: Float {
        get {
            return self.view.contentCompressionResistancePriority(for: .vertical).rawValue
        }
        nonmutating set {
            self.view.setContentCompressionResistancePriority(UILayoutPriority(rawValue: newValue), for: .vertical)
        }
    }
    public var target: AnyObject? {
        return self.view
    }
    internal let view: UIView
    internal init(view: UIView) { self.view = view }
}


// MARK: AxcLayoutDebugging
public extension AxcLayoutConstraint {
    override var description: String {
        var description = "<"
        description += descriptionForObject(self)
        if let firstItem = conditionalOptional(from: self.firstItem) { description += " \(descriptionForObject(firstItem))" }
        if self.firstAttribute != .notAnAttribute { description += ".\(descriptionForAttribute(self.firstAttribute))" }
        description += " \(descriptionForRelation(self.relation))"
        if let secondItem = self.secondItem { description += " \(descriptionForObject(secondItem))" }
        if self.secondAttribute != .notAnAttribute { description += ".\(descriptionForAttribute(self.secondAttribute))" }
        if self.multiplier != 1.0 { description += " * \(self.multiplier)" }
        if self.secondAttribute == .notAnAttribute { description += " \(self.constant)" }
        else {
            if self.constant > 0.0 { description += " + \(self.constant)" }
            else if self.constant < 0.0 { description += " - \(abs(self.constant))" }
        }
        if self.priority.rawValue != 1000.0 { description += " ^\(self.priority)" }
        description += ">"
        return description
    }
}
private func descriptionForRelation(_ relation: NSLayoutConstraint.Relation) -> String {
    switch relation {
    case .equal:                return "=="
    case .greaterThanOrEqual:   return ">="
    case .lessThanOrEqual:      return "<="
    @unknown default:           return "unknown"
    }
}
private func descriptionForAttribute(_ attribute: NSLayoutConstraint.Attribute) -> String {
        switch attribute {
        case .notAnAttribute:       return "notAnAttribute"
        case .top:                  return "top"
        case .left:                 return "left"
        case .bottom:               return "bottom"
        case .right:                return "right"
        case .leading:              return "leading"
        case .trailing:             return "trailing"
        case .width:                return "width"
        case .height:               return "height"
        case .centerX:              return "centerX"
        case .centerY:              return "centerY"
        case .lastBaseline:         return "lastBaseline"
        case .firstBaseline:        return "firstBaseline"
        case .topMargin:            return "topMargin"
        case .leftMargin:           return "leftMargin"
        case .bottomMargin:         return "bottomMargin"
        case .rightMargin:          return "rightMargin"
        case .leadingMargin:        return "leadingMargin"
        case .trailingMargin:       return "trailingMargin"
        case .centerXWithinMargins: return "centerXWithinMargins"
        case .centerYWithinMargins: return "centerYWithinMargins"
        @unknown default:           return "unknown"
    }
}
private func conditionalOptional<T>(from object: Optional<T>) -> Optional<T> {
    return object
}
private func conditionalOptional<T>(from object: T) -> Optional<T> {
    return Optional.some(object)
}
private func descriptionForObject(_ object: AnyObject) -> String {
    let pointerDescription = String(format: "%p", UInt(bitPattern: ObjectIdentifier(object)))
    var desc = ""
    desc += type(of: object).description()
    if let object = object as? UIView { desc += ":\(object.axc.label() ?? pointerDescription)" }
    else if let object = object as? AxcLayoutConstraint { desc += ":\(object.label ?? pointerDescription)" }
    else { desc += ":\(pointerDescription)" }
    if let object = object as? AxcLayoutConstraint, let file = object.constraint?.sourceLocation.0, let line = object.constraint?.sourceLocation.1 {
        desc += "@\((file as NSString).lastPathComponent)#\(line)"
    }
    desc += ""
    return desc
}

// MARK: AxcLayoutConstraint
public class AxcLayoutConstraint : NSLayoutConstraint {
    public var label: String? {
        get { return self.identifier }
        set { self.identifier = newValue }
    }
    internal weak var constraint: AxcConstraint? = nil
}
internal func ==(lhs: AxcLayoutConstraint, rhs: AxcLayoutConstraint) -> Bool {
    guard lhs.firstAttribute == rhs.firstAttribute &&
          lhs.secondAttribute == rhs.secondAttribute &&
          lhs.relation == rhs.relation &&
          lhs.priority == rhs.priority &&
          lhs.multiplier == rhs.multiplier &&
          lhs.secondItem === rhs.secondItem &&
          lhs.firstItem === rhs.firstItem else {
        return false
    }
    return true
}

// MARK: AxcLayoutConstraintItem
public protocol AxcLayoutConstraintItem: class {}
@available(iOS 9.0, OSX 10.11, *)
extension UILayoutGuide : AxcLayoutConstraintItem {}
extension UIView : AxcLayoutConstraintItem {}

extension AxcLayoutConstraintItem {
    internal func prepare() {
        if let view = self as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    internal var superview: UIView? {
        if let view = self as? UIView {
            return view.superview
        }
        if let guide = self as? UILayoutGuide {
            return guide.owningView
        }
        return nil
    }
    internal var constraints: [AxcConstraint] {
        return self.constraintsSet.allObjects as! [AxcConstraint]
    }
    internal func add(constraints: [AxcConstraint]) {
        let constraintsSet = self.constraintsSet
        for constraint in constraints {
            constraintsSet.add(constraint)
        }
    }
    internal func remove(constraints: [AxcConstraint]) {
        let constraintsSet = self.constraintsSet
        for constraint in constraints {
            constraintsSet.remove(constraint)
        }
    }
    private var constraintsSet: NSMutableSet {
        let constraintsSet: NSMutableSet
        
        if let existing = objc_getAssociatedObject(self, &constraintsKey) as? NSMutableSet {
            constraintsSet = existing
        } else {
            constraintsSet = NSMutableSet()
            objc_setAssociatedObject(self, &constraintsKey, constraintsSet, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return constraintsSet
    }
}
private var constraintsKey: UInt8 = 0
