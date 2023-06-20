//
//  AxcBaseLabel.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/3.
//

import UIKit

// MARK: - AxcBaseLabel
/// 基类Label视图
@IBDesignable
open class AxcBaseLabel: UILabel,
                           AxcBaseClassConfigProtocol,
                           AxcBaseClassMakeUIProtocol,
                           AxcGradientLayerProtocol {
    // MARK: - 初始化
    /// 重写初始化
    /// - Parameter frame: 框坐标
    public override init(frame: CGRect) { super.init(frame: frame)
        config()
        makeUI()
    }
    public required init?(coder: NSCoder) { super.init(coder: coder)
        config()
        makeUI()
    }
    open override func awakeFromNib() { super.awakeFromNib()
        config()
        makeUI()
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 内容对齐方式
    open var axc_contentAlignment: AxcDirection = .center { didSet { reloadLayout() } }
    /// 内容边距
    open var axc_contentInset: UIEdgeInsets = .zero { didSet { reloadLayout() } }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 当label被设置完文字后会调用
    public typealias AxcBaseLabelSetTextBlock = (_ label: AxcBaseLabel, _ text: String?) -> Void
    
    /// 当label设置Text前会调用
    open var axc_willSetTextBlock: AxcBaseLabelSetTextBlock?
    /// 当label设置Text后会调用
    open var axc_didSetTextBlock: AxcBaseLabelSetTextBlock?
    
    // MARK: func回调
    /// 当label设置Text前会调用
    /// - Parameters:
    ///   - label: label
    ///   - text: text
    open func axc_willSetText(label: AxcBaseLabel, text: String?) { }
    /// 当label设置Text后会调用
    /// - Parameters:
    ///   - label: label
    ///   - text: text
    open func axc_didSetText(label: AxcBaseLabel, text: String?) { }
    
    // MARK: - 私有
    
    // MARK: 复用
    
    // MARK: - 子类实现
    /// 配置参数
    open func config() {
        font = UIFont.systemFont(ofSize: 14)
        numberOfLines = 0
    }
    /// 创建UI
    open func makeUI() { }
    /// 刷新布局
    open func reloadLayout() {
        // 执行重绘
        setNeedsDisplay()
    }
    /// Xib显示前会执行
    open func makeXmlInterfaceBuilder() { }
    /// 被添加进视图
    /// - Parameter superView: 父视图
    open func addSelf(superView: UIView) { }
    /// 被移除视图
    open func removeSelf() { }
    
    // MARK: - 父类重写
    /// 使本身layer为渐变色layer
    open override class var layerClass: AnyClass { return CAGradientLayer.self }
    /// Xib显示前会执行
    open override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    /// 文字输入
    open override var text: String? {
        set {
            axc_willSetTextBlock?(self, text)
            axc_willSetText(label: self, text: text)
            super.text = newValue
            axc_didSetTextBlock?(self, text)
            axc_didSetText(label: self, text: text)
        }
        get { return super.text }
    }
    // MARK: 视图父类
    /// 文本绘制
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let center = CGPoint(((axc_width  - textRect.width ) / 2,
                              (axc_height - textRect.height) / 2))
        var textPoint = center
        if axc_contentAlignment.contains(.top) { textPoint.y = axc_contentInset.top }
        if axc_contentAlignment.contains(.left) { textPoint.x = axc_contentInset.left }
        if axc_contentAlignment.contains(.bottom) { textPoint.y = axc_height - textRect.height - axc_contentInset.bottom }
        if axc_contentAlignment.contains(.right) { textPoint.x = axc_width - textRect.width - axc_contentInset.right }
        if axc_contentAlignment.contains(.center) { textPoint = center }
        textRect.origin = textPoint
        return textRect
    }
    /// 绘制文字
    open override func drawText(in rect: CGRect) {
        let newRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: newRect)
    }
    /// 视图移动
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let superview = newSuperview {   // 添加进视图
            addSelf(superView: superview)
        }else{  // 被移除
            removeSelf()
        }
    }
    
    // MARK: - 销毁
    deinit { AxcLog("\(AxcClassFromString(self))视图： \(self) 已销毁", level: .trace) }
}

// MARK: - 代理&数据源
