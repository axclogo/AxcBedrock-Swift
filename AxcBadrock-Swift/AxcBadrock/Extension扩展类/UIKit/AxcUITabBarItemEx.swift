//
//  AxcUITabBarItemEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

// MARK: - 属性 & Api
public extension UITabBarItem {
    /// 文字未选中颜色
    func axc_normalTextColor(_ color: UIColor ) {
        setTitleTextAttributes([.foregroundColor : color], for:.normal)
    }
    /// 文字选中颜色
    func axc_selectedTextColor(_ color: UIColor ) {
        setTitleTextAttributes([.foregroundColor : color], for:.selected)
    }
}
