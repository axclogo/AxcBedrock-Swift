//
//  AxcTextBannerView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/9.
//

import UIKit

// MARK: - AxcTextBannerView
/// Axc文字轮播
@IBDesignable
open class AxcTextBannerView: AxcContentBannerView {
    // MARK: - 回调
    // MARK: Block回调
    /// 返回需要滚动的内容数量
    open var axc_textBannerNumberBlock: ((_ textScrollView: AxcTextBannerView) -> Int)
        = { _ in return 1 }
    
    /// 返回需要滚动的文字内容
    open var axc_textBannerTextBlock: ((_ textScrollView: AxcTextBannerView, _ index: Int) -> String)?
    
    /// 返回需要滚动的富文本内容 会覆盖普通文本内容
    open var axc_textBannerAttributedTextBlock: ((_ textScrollView: AxcTextBannerView, _ index: Int) -> NSAttributedString)?
    
    /// 设置Label相关属性
    open var axc_textBannerItemLabelBlock: ((_ textScrollView: AxcTextBannerView, _ label: AxcBaseLabel, _ index: Int) -> Void)?
    
    /// 内容点击事件
    open var axc_textBannerItemActionBlock: ((_ textScrollView: AxcTextBannerView, _ index: Int) -> Void)
        = { (banner,idx) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(banner)\nIndex:\(idx)", level: .action)
        }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    open override func axc_reloadData() {
        // 数量
        axc_contentBannerNumberBlock = { [weak self] _ in
            guard let weakSelf = self else { return 0 }
            return weakSelf.axc_textBannerNumberBlock(weakSelf)
        }
        // 内容
        axc_contentBannerViewBlock = { [weak self] _,idx in
            let label = AxcBaseLabel()
            label.tag = idx
            guard let weakSelf = self else { return label }
            if let text = weakSelf.axc_textBannerTextBlock?(weakSelf, idx) {
                label.text = text
            }
            if let attributedText = weakSelf.axc_textBannerAttributedTextBlock?(weakSelf, idx) {
                label.attributedText = attributedText
            }
            weakSelf.axc_textBannerItemLabelBlock?(weakSelf, label, idx)
            return label
        }
        // 点击
        axc_contentBannerActionBlock = { [weak self] _,idx in
            guard let weakSelf = self else { return }
            weakSelf.axc_textBannerItemActionBlock(weakSelf, idx)
        }
        super.axc_reloadData()
    }
}
