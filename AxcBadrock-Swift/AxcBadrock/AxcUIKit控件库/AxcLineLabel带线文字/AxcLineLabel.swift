//
//  AxcLineLabel.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/24.
//

import UIKit

// MARK: - AxcLineLabel
/// Axc带线文字控件
@IBDesignable
open class AxcLineLabel: AxcBaseView, AxcLeftRightViewProtocol {
    // MARK: - Api
    // MARK: UI属性
    /// 内容边距 默认0
    open var axc_contentInset: UIEdgeInsets = .zero { didSet { reloadLayout() } }
    
    /// 文字对齐 左中右 默认中
    open var axc_textDirection: AxcDirection = .center { didSet { reloadLayout() } }
    
    /// 文字宽度 默认自适应
    open var axc_textWidth: CGFloat? = nil { didSet { reloadLayout() } }
    
    /// 文字内容
    open var axc_text: String? {
        set { axc_lineLabel.text = newValue }
        get { return axc_lineLabel.text }
    }
    /// 字体
    open var axc_font: UIFont {
        set { axc_lineLabel.font = newValue }
        get { return axc_lineLabel.font }
    }
    /// 字色
    open var axc_textColor: UIColor {
        set { axc_lineLabel.textColor = newValue }
        get { return axc_lineLabel.textColor }
    }
    /// 富文本内容
    open var axc_attributedText: NSAttributedString? {
        set { axc_lineLabel.attributedText = newValue }
        get { return axc_lineLabel.attributedText }
    }
    
    /// 线宽度 默认1
    open var axc_lineWidth: CGFloat = 1 { didSet { reloadLayout() } }
    
    /// 线颜色 默认 AxcBadrock.shared.lineColor
    open var axc_lineColor: UIColor = AxcBadrock.shared.lineColor {
        didSet {
            axc_leftView.backgroundColor = axc_lineColor
            axc_rightView.backgroundColor = axc_lineColor
        }
    }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    public override func makeUI() {
        super.makeUI()
        reloadLayout()
    }
    public override func reloadLayout() {
        axc_contentView.axc_remakeConstraintsInset(axc_contentInset) // 内容边距
        guard axc_textDirection.selectType([.left, .center, .right]) else { return } // 可选左中右
        axc_lineLabel.axc.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            if let width = axc_textWidth {
                make.width.equalTo(width)
            }else{
                let estimatedWidth = axc_lineLabel.axc_estimatedWidth() + axc_lineLabel.axc_contentInset.axc_horizontal
                make.width.equalTo(estimatedWidth) // 自适应
            }
            if axc_textDirection == .left { make.left.equalToSuperview() }      // 左
            if axc_textDirection == .right { make.right.equalToSuperview() }    // 中
            if axc_textDirection == .center { make.centerX.equalToSuperview() } // 右
        }
        axc_leftView.axc.remakeConstraints { (make) in
            make.left.centerY.equalToSuperview()
            make.right.equalTo(axc_lineLabel.axc.left)
            make.height.equalTo(axc_lineWidth)
        }
        axc_rightView.axc.remakeConstraints { (make) in
            make.right.centerY.equalToSuperview()
            make.left.equalTo(axc_lineLabel.axc.right)
            make.height.equalTo(axc_lineWidth)
        }
    }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    open lazy var axc_lineLabel: AxcBaseLabel = {
        let label = AxcBaseLabel()
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 1
        axc_contentView.addSubview(label)
        return label
    }()
    open lazy var axc_contentView: AxcBaseView = {
        let view = AxcBaseView()
        addSubview(view)
        return view
    }()
    
    // MARK: 协议控件
    public func axc_settingView(direction: AxcDirection) -> AxcBaseView {
        let view = AxcBaseView()
        axc_contentView.addSubview(view)
        return view
    }
}
