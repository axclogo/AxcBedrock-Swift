//
//  AxcWebVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit
import WebKit

// MARK: - 样式扩展带参枚举
public extension AxcWebVC {
    /// 网页控制器样式
    enum Style {
        case `default`
    }
}

// MARK: - AxcWebVC
/// Axc网页控制器
@IBDesignable
open class AxcWebVC: AxcBaseVC {
    // MARK: - 初始化
    /// 容易造成主线程阻塞
    /// - Parameter url: url
    public convenience init(_ url: URL, configuration: WKWebViewConfiguration? = nil) {
        self.init()
        axc_webConfiguration = configuration
        axc_loadUrl(url)
    }
    
    /// 使用配置方式初始化
    /// - Parameter configuration: WKWebView配置对象
    public convenience init(configuration: WKWebViewConfiguration) {
        self.init()
        axc_webConfiguration = configuration
    }
    
    // MARK: - Api
    // MARK: 加载
    /// 加载url
    @discardableResult
    open func axc_loadUrl(_ url: URL) -> WKNavigation? {
        return axc_webView.axc_loadUrl( url )
    }
    /// 加载url字符
    @discardableResult
    open func axc_loadUrlStr(_ urlStr: String) -> WKNavigation? {
        return axc_webView.axc_loadUrlStr( urlStr )
    }
    /// 加载文件
    @discardableResult
    open func axc_loadFileUrl(_ url: URL, allowingReadAccessTo readAccessURL: URL) -> WKNavigation? {
        return axc_webView.axc_loadFileUrl(url, allowingReadAccessTo: readAccessURL)
    }
    /// 加载HTML字符
    @discardableResult
    open func axc_loadHTMLStr(_ string: String, baseUrl: URL? = nil) -> WKNavigation? {
        return axc_webView.axc_loadHTMLStr(string, baseUrl: baseUrl)
    }
    
    // MARK: UI属性
    /// 设置样式
    open var axc_style: AxcWebVC.Style = .default { didSet { reloadLayout() } }
    
    /// 设置WKWebView配置
    open var axc_webConfiguration: WKWebViewConfiguration?
    
    /// 是否使用滑动透明导航条
    open var axc_isUseClear: Bool = false { didSet { reloadLayout() } }
    
    /// 设置内容边距 webview
    open var axc_contentInset: UIEdgeInsets = .zero { didSet { reloadLayout() } }
    
    /// 是否使用加载网页的标题
    open var axc_isUseWebTitle = true
    
    
    // MARK: 自定义导航设置
    /// 是否使用自定义导航
    open var axc_isUseCustomNavBar: Bool = false {
        didSet { axc_setIsUseCustomNavBar( axc_isUseCustomNavBar, animated: false ) }
    }
    /// 设置是否使用自定义透明导航，可选动画
    open func axc_setIsUseCustomNavBar(_ useCustomNavBar: Bool, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: Axc_duration) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.reloadLayout()
                weakSelf.view.layoutIfNeeded()
            }
        }else{
            reloadLayout()
        }
    }
    /// 是否使用随滑动逐渐变透明效果
    /// 仅适用于自定义导航
    open var axc_isUseScrollClearNav: Bool = false
    
    /// 随滑动彻底变透明的临界值 默认200
    /// 仅适用于自定义导航
    open var axc_scrollClearCriticalHeight: CGFloat = 200
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    open override func config() {
        configNavView()
    }
    /// 设置UI
    open override func makeUI() {
        let _axc_isUseCustomNavBar = axc_isUseCustomNavBar
        axc_isUseCustomNavBar = _axc_isUseCustomNavBar
        reloadLayout()
    }
    // MARK: 私有
    /// 刷新布局
    private func reloadLayout() {
        // webView边距
        axc_webView.axc.makeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
        if axc_isUseClear { // 使用透明
            let topHeight = Axc_navBarHeight + Axc_statusHeight
            axc_webView.scrollView.contentInset = UIEdgeInsets(top: topHeight, left: 0, bottom: 0, right: 0)
            view.addSubview(axc_navBar)
            axc_navBar.axc.remakeConstraints { (make) in
                make.top.left.right.equalTo(0)
                make.height.equalTo(topHeight)
            }
        }else{
            axc_navBar.removeFromSuperview()
            axc_webView.scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    /// 刷新样式
    private func reloadStyle(){
        switch axc_style {
        case .default: break
        }
    }
    /// 设置barView
    private func configNavView() {
        axc_navBar.axc_addBackItem()
        axc_navBar.axc_itemActionBlock = { [weak self] (_,direction,idx) in
            guard let weakSelf = self else { return }
            if direction == .left && idx == 0{  // 返回
                weakSelf.axc_popViewController()
            }
        }
    }
    
    // MARK: - 懒加载
    open lazy var axc_webView: AxcWebView = {
        var configuration = WKWebViewConfiguration()
        if let config = axc_webConfiguration { configuration = config } // 判断外部是否传入了配置
        let webView = AxcWebView(frame: .zero, configuration: configuration)
        webView.scrollView.delegate = self
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.axc_titleBlock = { [weak self] (_,title) in
            guard let weakSelf = self else { return }
            if weakSelf.axc_isUseWebTitle { weakSelf.title = title }
        }
        view.addSubview(webView)
        return webView
    }()
}

// MARK: - 协议代理
extension AxcWebVC: WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate {
    // 滑动时
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if axc_isUseScrollClearNav {    // 使用滑动透明效果
            axc_navBar.axc_setScrollClear(scrollView, criticalHeight: axc_scrollClearCriticalHeight)
        }
    }
}
