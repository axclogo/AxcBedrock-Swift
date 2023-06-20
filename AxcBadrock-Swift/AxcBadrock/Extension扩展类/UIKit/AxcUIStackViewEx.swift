//
//  AxcUIStackViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/7/14.
//

import UIKit

public extension UIStackView {
    /// 移除全部的arrangedSubview视图
    func axc_removeAllArrangedSubviews() {
        arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
    
    /// 用于读写arrangedSubviews
    var axc_arrangedSubview: [UIView] {
        set {
            axc_removeAllArrangedSubviews() // 先清空
            newValue.forEach{ addArrangedSubview($0) }  // 遍历添加
        }
        get { return arrangedSubviews }
    }
    
}
