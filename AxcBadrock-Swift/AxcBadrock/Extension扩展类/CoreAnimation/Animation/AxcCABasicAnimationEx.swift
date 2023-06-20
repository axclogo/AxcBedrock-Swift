//
//  AxcCABasicAnimationEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - 链式语法
public extension CABasicAnimation {
    /// 从。。。值
    /// - Parameter fromValue: 从。。。值
    /// - Returns: Self
    @discardableResult
    func axc_setFromValue(_ fromValue: Any?) -> Self {
        self.fromValue = fromValue
        return self
    }
    
    /// 到。。。值
    /// - Parameter toValue: 到。。。值
    /// - Returns: Self
    @discardableResult
    func axc_setToValue(_ toValue: Any?) -> Self {
        self.toValue = toValue
        return self
    }
    
    /// 经过。。。值
    /// - Parameter byValue: 经过。。。值
    /// - Returns: Self
    @discardableResult
    func axc_setByValue(_ byValue: Any?) -> Self {
        self.byValue = byValue
        return self
    }
}
