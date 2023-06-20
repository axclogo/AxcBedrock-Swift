//
//  AxcConstraintMakerEditable.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/3.
//
    import UIKit


public class AxcConstraintMakerEditable: AxcConstraintMakerPrioritizable {

    @discardableResult
    public func multipliedBy(_ amount: AxcConstraintMultiplierTarget) -> AxcConstraintMakerEditable {
        self.description.multiplier = amount
        return self
    }
    
    @discardableResult
    public func dividedBy(_ amount: AxcConstraintMultiplierTarget) -> AxcConstraintMakerEditable {
        return self.multipliedBy(1.0 / amount.constraintMultiplierTargetValue)
    }
    
    @discardableResult
    public func offset(_ amount: AxcConstraintOffsetTarget) -> AxcConstraintMakerEditable {
        self.description.constant = amount.constraintOffsetTargetValue
        return self
    }
    
    @discardableResult
    public func inset(_ amount: AxcConstraintInsetTarget) -> AxcConstraintMakerEditable {
        self.description.constant = amount.constraintInsetTargetValue
        return self
    }
    
    @discardableResult
    @available(iOS 11.0, tvOS 11.0, *)
    public func inset(_ amount: AxcConstraintDirectionalInsetTarget) -> AxcConstraintMakerEditable {
        self.description.constant = amount.constraintDirectionalInsetTargetValue
        return self
    }
}
