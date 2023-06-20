//
//  AxcExTemplate.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//

import UIKit

public protocol AxcConstraintConstantTarget {}
extension CGPoint:                      AxcConstraintConstantTarget {}
extension CGSize:                       AxcConstraintConstantTarget {}
extension UIEdgeInsets:                 AxcConstraintConstantTarget {}
@available(iOS 11.0, *)
extension NSDirectionalEdgeInsets:      AxcConstraintConstantTarget {}

extension AxcConstraintConstantTarget {
    internal func constraintConstantTargetValueFor(layoutAttribute: NSLayoutConstraint.Attribute) -> CGFloat {
        if let value = self as? CGFloat {
            return value
        }
        if let value = self as? Float {
            return CGFloat(value)
        }
        if let value = self as? Double {
            return CGFloat(value)
        }
        if let value = self as? Int {
            return CGFloat(value)
        }
        if let value = self as? UInt {
            return CGFloat(value)
        }
        if let value = self as? CGSize {
            if layoutAttribute == .width {
                return value.width
            } else if layoutAttribute == .height {
                return value.height
            } else {
                return 0.0
            }
        }
        if let value = self as? CGPoint {
            switch layoutAttribute {
            case .left, .right, .leading, .trailing, .centerX, .leftMargin, .rightMargin, .leadingMargin, .trailingMargin, .centerXWithinMargins:
                return value.x
            case .top, .bottom, .centerY, .topMargin, .bottomMargin, .centerYWithinMargins, .lastBaseline, .firstBaseline:
                return value.y
            case .width, .height, .notAnAttribute:
                return 0.0
            @unknown default:
                return 0.0
            }
        }
        if let value = self as? UIEdgeInsets {
            switch layoutAttribute {
            case .left, .leftMargin:
                return value.left
            case .top, .topMargin, .firstBaseline:
                return value.top
            case .right, .rightMargin:
                return -value.right
            case .bottom, .bottomMargin, .lastBaseline:
                return -value.bottom
            case .leading, .leadingMargin:
                return (AxcConstraintConfig.interfaceLayoutDirection == .leftToRight) ? value.left : value.right
            case .trailing, .trailingMargin:
                return (AxcConstraintConfig.interfaceLayoutDirection == .leftToRight) ? -value.right : -value.left
            case .centerX, .centerXWithinMargins:
                return (value.left - value.right) / 2
            case .centerY, .centerYWithinMargins:
                return (value.top - value.bottom) / 2
            case .width:
                return -(value.left + value.right)
            case .height:
                return -(value.top + value.bottom)
            case .notAnAttribute:
                return 0.0
            @unknown default:
                return 0.0
            }
        }
        if #available(iOS 11.0, *) {
            if let value = self as? NSDirectionalEdgeInsets {
                switch layoutAttribute {
                case .left, .leftMargin:
                    return (AxcConstraintConfig.interfaceLayoutDirection == .leftToRight) ? value.leading : value.trailing
                case .top, .topMargin, .firstBaseline:
                    return value.top
                case .right, .rightMargin:
                    return (AxcConstraintConfig.interfaceLayoutDirection == .leftToRight) ? -value.trailing : -value.leading
                case .bottom, .bottomMargin, .lastBaseline:
                    return -value.bottom
                case .leading, .leadingMargin:
                    return value.leading
                case .trailing, .trailingMargin:
                    return -value.trailing
                case .centerX, .centerXWithinMargins:
                    return (value.leading - value.trailing) / 2
                case .centerY, .centerYWithinMargins:
                    return (value.top - value.bottom) / 2
                case .width:
                    return -(value.leading + value.trailing)
                case .height:
                    return -(value.top + value.bottom)
                case .notAnAttribute:
                    return 0.0
                @unknown default:
                    return 0.0
                }
            }
        }
        return 0.0
    }
}
