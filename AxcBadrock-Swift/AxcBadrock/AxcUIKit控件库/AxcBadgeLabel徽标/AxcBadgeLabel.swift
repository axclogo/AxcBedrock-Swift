//
//  AxcBadgeswift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcBadgeLabel {
    /// AxcBadgeLabel徽标的样式
    enum Style {
        /// 无样式，默认
        case `default`
    }
}

// MARK: - AxcBadgeLabel
/// Axc徽标控件
@IBDesignable
open class AxcBadgeLabel: AxcBaseLabel {
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    open var axc_style: AxcBadgeLabel.Style = .default { didSet{ reloadLayout() } }
    
    /// 设置徽标位置
    open var axc_direction: AxcDirection = [.top, .right] { didSet{ reloadLayout() } }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 气泡点击回调
    open var axc_actionBlock: ((_ badge: AxcBadgeLabel ) -> Void)
        = { (badge) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(badge)", level: .action)
        }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置 执行于makeUI()之前
    open override func config() {
        super.config()  // 执行父类的配置
        textColor = AxcBadrock.shared.themeFillContentColor
        font = UIFont.systemFont(ofSize: 10)
        axc_setGradient()
        axc_addTapGesture { [weak self] (_) in  // 添加点击回调
            guard let weakSelf = self else { return }
            weakSelf.axc_actionBlock(weakSelf)
        }
    }
    /// 设置UI布局
    open override func makeUI() {
        super.makeUI()
    }
    /// 刷新布局
    open override func reloadLayout() {
        guard superview != nil else { return }
        sizeToFit()
        var spacing = font.pointSize
        if spacing < 10 { spacing = 10 } // 边距最少10pt
        axc_width += spacing
        
        self.axc.remakeConstraints { (make) in
            // Y 轴
            if axc_direction.contains(.top) { make.top.equalToSuperview() }         // 上
            if axc_direction.contains(.center) { make.centerY.equalToSuperview() }  // 中
            if axc_direction.contains(.bottom) { make.bottom.equalToSuperview() }   // 下
            if axc_direction.contains(.top) && axc_direction.contains(.bottom) {    // 上+下=中
                make.centerY.equalToSuperview()
            }
            // X 轴
            if axc_direction.contains(.left) { make.left.equalToSuperview() }       // 左
            if axc_direction.contains(.center) { make.centerX.equalToSuperview() }  // 中
            if axc_direction.contains(.right) { make.right.equalToSuperview() }     // 右
            if axc_direction.contains(.left) && axc_direction.contains(.right) {    // 左+右=中
                make.centerX.equalToSuperview()
            }
            make.size.equalTo( axc_size )
        }
        
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新样式
    private func reloadStyle() {
        switch axc_style {
        case .default: break
        }
    }
    
    // MARK: 超类&抽象类
    /// 每当需要布局时
    open override func layoutSubviews() {
        super.layoutSubviews()
        axc_cornerRadius = axc_size.axc_smaller / 2
    }
    /// text属性被改变时，自适应
    open override var text: String? {
        didSet { super.text = text; reloadLayout() }
    }
    /// font属性被改变时，自适应
    open override var font: UIFont! {
        didSet { super.font = font; reloadLayout() }
    }
    /// attributedText属性被改变时，自适应
    open override var attributedText: NSAttributedString? {
        didSet { super.attributedText = attributedText; reloadLayout() }
    }
    /// numberOfLines属性被改变时，自适应
    open override var numberOfLines: Int {
        didSet { super.numberOfLines = numberOfLines; reloadLayout() }
    }
}
