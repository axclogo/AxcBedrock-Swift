//
//  AxcProgressView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcProgressView {
    /// 进度样式
    enum Style {
        case `default`
    }
}

// MARK: - AxcWebView
/// Axc进度指示器
@IBDesignable
open class AxcProgressView: AxcBaseControl {
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    open var axc_style: AxcProgressView.Style = .default { didSet { reloadLayout() } }
    
    /// 设置起始点 支持按位或运算
    open var axc_startDirection: AxcDirection = [.top, .left, .bottom] { didSet { reloadLayout() } }
    
    /// 设置进度值
    open var axc_progress: CGFloat {
        set {
            var progress: CGFloat = 0
            if newValue < 0 { progress = 0 }
            if newValue > 1 { progress = 1 }
            progress = newValue
            _axc_progress = progress
            reloadLayout()
        }
        get { return _axc_progress }
    }
    
    /// 底部背景色
    open var axc_backgroundColor: UIColor = AxcBadrock.shared.backgroundColor {
        didSet { backgroundColor = axc_backgroundColor }
    }
    
    /// 设置进度颜色
    open var axc_indicatorColor: UIColor = AxcBadrock.shared.themeColor {
        didSet { axc_indicator.backgroundColor = axc_indicatorColor }
    }
    
    // MARK: 方法
    /// 设置底部渐变色
    open func axc_setBackgroundGradient(colors: [UIColor],
                                          startDirection: AxcDirection  = .left,
                                          endDirection: AxcDirection    = .right,
                                          locations: [CGFloat]? = nil,
                                          type: CAGradientLayerType = .axial) {
        axc_setGradient(colors: colors, startDirection: startDirection,
                        endDirection: endDirection,
                        locations: locations, type: type)
    }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 点击事件回调
    open var axc_actionBlock: ((_ progressView: AxcProgressView) -> Void)
        = { (pro) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(pro)", level: .action)
        }
    
    
    // MARK: - 私有
    /// 保存进度值
    private var _axc_progress: CGFloat = 0
    
    // MARK: - 父类重写
    /// 配置
    open override func config() {
        axc_addEvent { [weak self] (_) in   // 点击触发回调
            guard let weakSelf = self else { return }
            weakSelf.axc_actionBlock(weakSelf)
        }
    }
    /// 设置UI
    open override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        reloadLayout()
    }
    /// 刷新布局
    open override func reloadLayout() {
        UIView.animate(withDuration: Axc_duration) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.axc_indicator.axc.remakeConstraints { (make) in
                if weakSelf.axc_startDirection.contains(.top) && weakSelf.axc_startDirection.contains(.bottom){
                    make.width.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                }
                if weakSelf.axc_startDirection.contains(.left) && weakSelf.axc_startDirection.contains(.right){
                    make.height.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                }
                if weakSelf.axc_startDirection == .center {
                    make.width.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                    make.height.equalToSuperview().multipliedBy(weakSelf.axc_progress)
                }
                if weakSelf.axc_startDirection.contains(.top)    { make.top.equalToSuperview().heightPriority() }
                if weakSelf.axc_startDirection.contains(.left)   { make.left.equalToSuperview().heightPriority() }
                if weakSelf.axc_startDirection.contains(.bottom) { make.bottom.equalToSuperview().heightPriority() }
                if weakSelf.axc_startDirection.contains(.right)  { make.right.equalToSuperview().heightPriority() }
                if weakSelf.axc_startDirection.contains(.center) { make.center.equalToSuperview().heightPriority() }
            }
            weakSelf.layoutIfNeeded()
        }
    }
    
    // MARK: 私有
    /// 刷新样式
    private func reloadStyle(){
        switch axc_style {
        case .default: break
        }
    }
    
    // MARK: - 懒加载
    // MARK: 基础控件
    /// 指示器视图
    open lazy var axc_indicator: AxcBaseView = {
        let view = AxcBaseView()
        view.axc_setGradient()
        addSubview(view)
        return view
    }()
}
