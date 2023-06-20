//
//  AxcWebView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit
import WebKit


// MARK: - 样式扩展带参枚举
public extension AxcWebView {
    /// 网页样式
    enum Style {
        case `default`
    }
}

// MARK: - AxcWebView
/// Axc网页视图
@IBDesignable
open class AxcWebView: WKWebView,
                         AxcBaseClassConfigProtocol,
                         AxcBaseClassMakeXibProtocol,
                         AxcGradientLayerProtocol  {
    // MARK: - 初始化
    public required init?(coder: NSCoder) { super.init(coder: coder)
        config()
        makeUI()
    }
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        config()
        makeUI()
    }
    open override func awakeFromNib() { super.awakeFromNib()
        config()
        makeUI()
    }
    // Xib显示前
    open override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    open var axc_style: AxcWebView.Style = .default { didSet { reloadLayout() } }
    
    /// 设置进度条的高度
    open var axc_progressHeight: CGFloat = 2 { didSet { reloadLayout() } }
    
    /// 设置进度条的方位
    open var axc_progressDirection: AxcDirection = [.top, .left, .right] { didSet { reloadLayout() } }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 标题读取回调
    open var axc_titleBlock: ((_ webView: AxcWebView,
                                 _ title: String) -> Void)
        = { (webView,title) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(webView)\nTitle: \(title)", level: .action)
        }
    
    /// 加载进度读取回调
    open var axc_progressBlock: ((_ webView: AxcWebView,
                                    _ progress: CGFloat) -> Void)
        = { (webView,progress) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(webView)\nProgress: \(progress)", level: .action)
        }
    
    // MARK: - 子类实现
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    open func makeXmlInterfaceBuilder() { }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置 执行于makeUI()之前
    open func config() {
        axc_addProgressObserver()
        axc_addTitleObserver()
    }
    /// 设置UI布局
    open func makeUI() {
        reloadLayout()
    }
    /// 刷新UI布局
    open func reloadLayout() {
        axc_progressView.axc.remakeConstraints { (make) in
            if axc_progressDirection.contains(.top)    { make.top.equalToSuperview() }
            if axc_progressDirection.contains(.left)   { make.left.equalToSuperview() }
            if axc_progressDirection.contains(.bottom) { make.bottom.equalToSuperview() }
            if axc_progressDirection.contains(.right)  { make.right.equalToSuperview() }
            make.height.equalTo(axc_progressHeight)
        }
    }
    
    // MARK: 私有
    /// 刷新样式
    private func reloadStyle(){
        switch axc_style {
        case .default: break
        }
    }
    
    // MARK: 超类&抽象类
    /// 使本身layer为渐变色layer
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    /// KVC
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == kEstimatedProgress {  // 进度
            axc_progressView.isHidden = false
            var progress = estimatedProgress.axc_cgFloat
            axc_progressView.axc_progress = progress
            if progress >= 1.0 {
                progress = 1
                axc_progressView.axc_animationInoutFade(isIn: false) {  [weak self] (_,_)  in
                    guard let weakSelf = self else { return }
                    weakSelf.axc_progressView.axc_progress = 0
                }
                axc_progressBlock(self, progress)
            }
        }else if keyPath == kWebTitle {  // 标题
            if let _title = title { axc_titleBlock(self, _title) }
        }else{  // 其他的
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    /// 进度条
    open lazy var axc_progressView: AxcProgressView = {
        let progressView = AxcProgressView()
        progressView.isHidden = true
        addSubview(progressView)
        return progressView
    }()
    
    // MARK: - 销毁
    deinit {
        axc_removeProgressObserver()
        axc_removeTitleObserver()
        AxcLog("AxcWebView视图： \(self) 已销毁", level: .trace)
    }
}
