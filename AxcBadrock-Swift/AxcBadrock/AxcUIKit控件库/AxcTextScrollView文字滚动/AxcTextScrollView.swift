//
//  AxcTextScrollView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/8.
//

import UIKit

// MARK: - AxcTextScrollView
/// Axc文字滚动器
@IBDesignable
open class AxcTextScrollView: AxcContentScrollView {
    // MARK: - 回调
    // MARK: Block回调
    /// 返回需要滚动的内容数量
    open var axc_textScrollNumberBlock: ((_ textScrollView: AxcTextScrollView) -> Int)
        
        = { _ in return 1 }
    /// 返回需要滚动的文字内容
    open var axc_textScrollTextBlock: ((_ textScrollView: AxcTextScrollView, _ index: Int) -> String)?
    
    /// 返回需要滚动的富文本内容 会覆盖普通文本内容
    open var axc_textScrollAttributedTextBlock: ((_ textScrollView: AxcTextScrollView, _ index: Int) -> NSAttributedString)?
    
    /// 设置Label相关属性
    open var axc_textScrollItemLabelBlock: ((_ textScrollView: AxcTextScrollView, _ label: AxcBaseLabel, _ index: Int) -> Void)?
    
    /// 内容点击事件
    open var axc_textScrollItemActionBlock: ((_ textScrollView: AxcTextScrollView, _ index: Int) -> Void)
        = { (scroll,idx) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(scroll)\nIndex:\(idx)", level: .action)
        }
    
    // MARK: - 私有
    /// 视图组
    private var viewsArr: [AxcBaseLabel] = []
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 刷新数据
    override func axc_reloadData() {
        viewsArr.removeAll()
        // 配置数量
        axc_contentScrollNumberBlock = { [weak self] _ in
            guard let weakSelf = self else { return 1 }
            return weakSelf.axc_textScrollNumberBlock(weakSelf)
        }
        // 配置视图
        axc_contentScrollViewBlock = { [weak self] _,idx in
            let label = AxcBaseLabel()
            label.tag = idx
            guard let weakSelf = self else { return label }
            label.axc_addTapGesture { [weak self] (_) in    // 添加手势触发
                guard let weakSelf = self else { return }
                weakSelf.axc_textScrollItemActionBlock(weakSelf, label.tag)
            }
            if let text = weakSelf.axc_textScrollTextBlock?(weakSelf, idx) {
                label.text = text
            }
            if let attributedText = weakSelf.axc_textScrollAttributedTextBlock?(weakSelf, idx) {
                label.attributedText = attributedText
            }
            weakSelf.axc_textScrollItemLabelBlock?(weakSelf, label, idx)
            weakSelf.viewsArr.append(label)
            return label
        }
        // 配置大小
        axc_contentScrollViewSizeBlock = { [weak self] _,idx in
            guard let weakSelf = self else { return CGSize.zero }
            guard let label = weakSelf.viewsArr.axc_objAtIdx(idx) else { return CGSize.zero }
            var size = label.axc_estimatedSize()
            size.width += label.axc_contentInset.axc_horizontal
            size.height += label.axc_contentInset.axc_verticality
            if weakSelf.axc_startPoint == .left || weakSelf.axc_startPoint == .right {
                return CGSize(width: size.width, height: weakSelf.axc_height)
            }else{
                return CGSize(width: weakSelf.axc_width, height: size.height)
            }
        }
        super.axc_reloadData()
    }
}
