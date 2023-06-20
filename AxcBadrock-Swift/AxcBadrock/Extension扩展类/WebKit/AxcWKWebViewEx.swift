//
//  AxcWKWebViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/26.
//

import UIKit
import WebKit

// MARK: - 类方法/属性
public extension WKWebView {
    /// url初始化
    /// - Parameter url: url
    convenience init(_ url: URL) {
        self.init()
        axc_loadUrl(url)
    }
    
    /// urlStr初始化
    /// - Parameter urlStr: urlStr
    convenience init(_ urlStr: String) {
        self.init()
        axc_loadUrlStr(urlStr)
    }
    
    /// FileUrl初始化
    /// - Parameters:
    ///   - url: url
    ///   - readAccessUrl: readAccessUrl
    convenience init(_ url: URL, readAccessUrl: URL) {
        self.init()
        axc_loadFileUrl(url, allowingReadAccessTo: readAccessUrl)
    }
    
    /// HTMLStr初始化
    /// - Parameters:
    ///   - string: HTMLStr
    ///   - baseUrl: baseUrl
    convenience init(_ string: String, baseUrl: URL? = nil) {
        self.init()
        axc_loadHTMLStr(string, baseUrl: baseUrl)
    }
}

// MARK: - 属性 & Api
public var kEstimatedProgress = "estimatedProgress"
public var kWebTitle = "title"
public extension WKWebView {
    /// 添加标题观察者
    func axc_addTitleObserver() {
        axc_addObserver(kWebTitle)     // 添加
    }
    /// 移除标题观察者
    func axc_removeTitleObserver() {
        axc_removeObserver(kWebTitle)  // 移除
    }
    
    /// 添加进度观察者
    func axc_addProgressObserver() {
        axc_addObserver(kEstimatedProgress)     // 添加
    }
    /// 移除进度观察者
    func axc_removeProgressObserver() {
        axc_removeObserver(kEstimatedProgress)  // 移除
    }
    /// 加载url
    @discardableResult
    func axc_loadUrl(_ url: URL) -> WKNavigation? {
        return load( url.axc_request )
    }
    /// 加载url字符
    @discardableResult
    func axc_loadUrlStr(_ urlStr: String) -> WKNavigation? {
        guard let url = urlStr.axc_url else { return nil }
        return axc_loadUrl( url )
    }
    /// 加载文件
    @discardableResult
    func axc_loadFileUrl(_ url: URL, allowingReadAccessTo readAccessUrl: URL) -> WKNavigation? {
        return loadFileURL(url, allowingReadAccessTo: readAccessUrl)
    }
    /// 加载HTML字符
    @discardableResult
    func axc_loadHTMLStr(_ string: String, baseUrl: URL? = nil) -> WKNavigation? {
        return loadHTMLString(string, baseURL: baseUrl)
    }
}

// MARK: - 决策判断
public extension WKWebView {
}

//// MARK: - 代理转Block
//private var kaxc_webNavigationDelegate = "kaxc_webNavigationDelegate"
//private var kaxc_webUIDelegate = "kaxc_webUIDelegate"
//public extension WKWebView {
//    /// 返回WKWebView的Block声明
//    typealias AxcBlock<T> = (WKWebView) -> T
//    /// 返回WKWebView,WKNavigationAction,WKWebpagePreferences,@escaping的Block声明
//    @available(iOS 13.0, *)
//    typealias AxcNavigationActionWebpagePreferencesBlock<T> = (WKWebView,WKNavigationAction,WKWebpagePreferences,@escaping (WKNavigationActionPolicy) -> Void) -> T
//    /// 返回WKWebView,URLAuthenticationChallenge,@escaping的Block声明
//    typealias AxcURLAuthenticationChallengeBlock<T> = (WKWebView,URLAuthenticationChallenge,@escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> T
//    /// 返回WKWebView,URLAuthenticationChallenge,@escaping的Block声明
//    typealias AxcURLAuthenticationChallengeBoolBlock<T> = (WKWebView,URLAuthenticationChallenge,@escaping (Bool) -> Void) -> T
//    /// 返回WKWebView,WKNavigation!,Error的Block声明
//    typealias AxcNavigationErrorBlock<T> = (WKWebView,WKNavigation,Error) -> T
//    /// 返回WKWebView,WKNavigationAction,@escaping的Block声明
//    typealias AxcNavigationActionBlock<T> = (WKWebView,WKNavigationAction,@escaping (WKNavigationActionPolicy) -> Void) -> T
//    /// 返回WKWebView,WKNavigation!的Block声明
//    typealias AxcNavigationBlock<T> = (WKWebView,WKNavigation) -> T
//    /// 返回WKWebView,WKNavigationResponse,@escaping的Block声明
//    typealias AxcNavigationResponseBlock<T> = (WKWebView,WKNavigationResponse,@escaping (WKNavigationResponsePolicy) -> Void) -> T
//
//    /// 代理桥接者
//    var axc_webNavigationDelegate: AxcWebNavigationDelegate {
//        set { AxcRuntime.setObj(self, &kaxc_webNavigationDelegate, newValue) }
//        get {
//            guard let delegate: AxcWebNavigationDelegate  = AxcRuntime.getObj(self, &kaxc_webNavigationDelegate)
//            else {
//                let delegate = AxcWebNavigationDelegate()
//                self.axc_webNavigationDelegate = delegate
//                self.navigationDelegate = delegate
//                return delegate
//            }
//            return delegate
//        }
//    }
//    /// 块设置代理方法
//    /// - Parameter block: block
//    func axc_makeWebNavigationDelegate(_ block: (AxcWebNavigationDelegate) -> Void) {
//        block(axc_webNavigationDelegate)
//    }
//
//    /// 返回WKWebView,UIViewController的Block声明
//    typealias AxcViewControllerBlock<T> = (WKWebView,UIViewController) -> T
//    /// 返回WKWebView,WKWebViewConfiguration,WKNavigationAction,WKWindowFeatures的Block声明
//    typealias AxcConfigurationNavigationActionWindowFeaturesBlock<T> = (WKWebView,WKWebViewConfiguration,WKNavigationAction,WKWindowFeatures) -> T
//    /// 返回WKWebView,String,String?,WKFrameInfo,@escaping的Block声明
//    typealias AxcStringStringFrameInfoBlock<T> = (WKWebView,String,String?,WKFrameInfo,@escaping (String?) -> Void) -> T
//    /// 返回WKWebView,WKContextMenuElementInfo,UIContextMenuInteractionCommitAnimating的Block声明
//    @available(iOS 13.0, *)
//    typealias AxcContextMenuElementInfoContextMenuInteractionCommitAnimatingBlock<T> = (WKWebView,WKContextMenuElementInfo,UIContextMenuInteractionCommitAnimating) -> T
//    /// 返回WKWebView,WKPreviewElementInfo的Block声明
//    typealias AxcPreviewElementInfoBlock<T> = (WKWebView,WKPreviewElementInfo) -> T
//    /// 返回WKWebView,WKContextMenuElementInfo,@escaping的Block声明
//    @available(iOS 13.0, *)
//    typealias AxcContextMenuElementInfoBlock<T> = (WKWebView,WKContextMenuElementInfo) -> T
//    /// 返回WKWebView,WKContextMenuElementInfo,@escaping的Block声明
//    @available(iOS 13.0, *)
//    typealias AxcContextMenuElementInfoMenuConfigBlock<T> = (WKWebView,WKContextMenuElementInfo,@escaping (UIContextMenuConfiguration?) -> Void) -> T
//    /// 返回WKWebView,String,WKFrameInfo,@escaping的Block声明
//    typealias AxcStringFrameInfoBlock<T> = (WKWebView,String,WKFrameInfo,@escaping () -> Void) -> T
//    /// 返回WKWebView,String,WKFrameInfo,@escaping的Block声明
//    typealias AxcStringFrameInfoBoolBlock<T> = (WKWebView,String,WKFrameInfo,@escaping (Bool) -> Void) -> T
//    /// 返回WKWebView,WKPreviewElementInfo,[WKPreviewActionItem]的Block声明
//    typealias AxcPreviewElementInfoPreviewActionItemsBlock<T> = (WKWebView,WKPreviewElementInfo,[WKPreviewActionItem]) -> T
//
//    /// 代理桥接者
//    var axc_webUIDelegate: AxcWebUIDelegate {
//        set { AxcRuntime.setObj(self, &kaxc_webUIDelegate, newValue) }
//        get {
//            guard let delegate: AxcWebUIDelegate  = AxcRuntime.getObj(self, &kaxc_webUIDelegate)
//            else {
//                let delegate = AxcWebUIDelegate()
//                self.axc_webUIDelegate = delegate
//                self.uiDelegate = delegate
//                return delegate
//            }
//            return delegate
//        }
//    }
//    /// 块设置代理方法
//    /// - Parameter block: block
//    func axc_makeWebUIDelegate(_ block: (AxcWebUIDelegate) -> Void) {
//        block(axc_webUIDelegate)
//    }
//}
//
//// MARK: NavigationDelegate桥接者
///// 代理转Block桥接者
//open class AxcWebNavigationDelegate: NSObject, WKNavigationDelegate {
//    /// optional func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
//    @discardableResult
//    open func axc_setWebViewDecidePolicyForDecisionHandlerBlock(_ block: @escaping WKWebView.AxcNavigationActionBlock<Void>) -> Self {
//        axc_webViewDecidePolicyForDecisionHandlerBlock = block
//        return self
//    }
//    open lazy var axc_webViewDecidePolicyForDecisionHandlerBlock: WKWebView.AxcNavigationActionBlock<Void>
//        = { _,_,_ in  }
//    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void ) -> Void {
//         axc_webViewDecidePolicyForDecisionHandlerBlock(webView,navigationAction,decisionHandler)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setWebViewDecidePolicyForPreferencesDecisionHandlerBlock(_ block: @escaping WKWebView.AxcNavigationActionWebpagePreferencesBlock<Void>) -> Self {
//        axc_webViewDecidePolicyForPreferencesDecisionHandlerBlock = block
//        return self
//    }
//    @available(iOS 13.0, *)
//    open lazy var axc_webViewDecidePolicyForPreferencesDecisionHandlerBlock: WKWebView.AxcNavigationActionWebpagePreferencesBlock<Void>
//        = { _,_,_,_ in  }
//    @available(iOS 13.0, *)
//    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) -> Void {
//         axc_webViewDecidePolicyForPreferencesDecisionHandlerBlock(webView,navigationAction,preferences,decisionHandler)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void)
//    @discardableResult
//    open func axc_setWebViewDecidePolicyForDecisionHandlerPolicyBlock(_ block: @escaping WKWebView.AxcNavigationResponseBlock<Void>) -> Self {
//        axc_webViewDecidePolicyForDecisionHandlerPolicyBlock = block
//        return self
//    }
//    open lazy var axc_webViewDecidePolicyForDecisionHandlerPolicyBlock: WKWebView.AxcNavigationResponseBlock<Void>
//        = { _,_,_ in  }
//    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) -> Void {
//         axc_webViewDecidePolicyForDecisionHandlerPolicyBlock(webView,navigationResponse,decisionHandler)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
//    @discardableResult
//    open func axc_setWebViewDidStartProvisionalNavigationBlock(_ block: @escaping WKWebView.AxcNavigationBlock<Void>) -> Self {
//        axc_webViewDidStartProvisionalNavigationBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidStartProvisionalNavigationBlock: WKWebView.AxcNavigationBlock<Void>
//        = { _,_ in  }
//    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) -> Void {
//         axc_webViewDidStartProvisionalNavigationBlock(webView,navigation)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!)
//    @discardableResult
//    open func axc_setWebViewDidReceiveServerRedirectForProvisionalNavigationBlock(_ block: @escaping WKWebView.AxcNavigationBlock<Void>) -> Self {
//        axc_webViewDidReceiveServerRedirectForProvisionalNavigationBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidReceiveServerRedirectForProvisionalNavigationBlock: WKWebView.AxcNavigationBlock<Void>
//        = { _,_ in  }
//    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) -> Void {
//         axc_webViewDidReceiveServerRedirectForProvisionalNavigationBlock(webView,navigation)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
//    @discardableResult
//    open func axc_setWebViewDidFailProvisionalNavigationWithErrorBlock(_ block: @escaping WKWebView.AxcNavigationErrorBlock<Void>) -> Self {
//        axc_webViewDidFailProvisionalNavigationWithErrorBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidFailProvisionalNavigationWithErrorBlock: WKWebView.AxcNavigationErrorBlock<Void>
//        = { _,_,_ in  }
//    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) -> Void {
//         axc_webViewDidFailProvisionalNavigationWithErrorBlock(webView,navigation,error)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
//    @discardableResult
//    open func axc_setWebViewDidCommitBlock(_ block: @escaping WKWebView.AxcNavigationBlock<Void>) -> Self {
//        axc_webViewDidCommitBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidCommitBlock: WKWebView.AxcNavigationBlock<Void>
//        = { _,_ in  }
//    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) -> Void {
//         axc_webViewDidCommitBlock(webView,navigation)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
//    @discardableResult
//    open func axc_setWebViewDidFinishBlock(_ block: @escaping WKWebView.AxcNavigationBlock<Void>) -> Self {
//        axc_webViewDidFinishBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidFinishBlock: WKWebView.AxcNavigationBlock<Void>
//        = { _,_ in  }
//    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) -> Void {
//         axc_webViewDidFinishBlock(webView,navigation)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
//    @discardableResult
//    open func axc_setWebViewDidFailWithErrorBlock(_ block: @escaping WKWebView.AxcNavigationErrorBlock<Void>) -> Self {
//        axc_webViewDidFailWithErrorBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidFailWithErrorBlock: WKWebView.AxcNavigationErrorBlock<Void>
//        = { _,_,_ in  }
//    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) -> Void {
//         axc_webViewDidFailWithErrorBlock(webView,navigation,error)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
//    @discardableResult
//    open func axc_setWebViewDidReceiveCompletionHandlerBlock(_ block: @escaping WKWebView.AxcURLAuthenticationChallengeBlock<Void>) -> Self {
//        axc_webViewDidReceiveCompletionHandlerBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidReceiveCompletionHandlerBlock: WKWebView.AxcURLAuthenticationChallengeBlock<Void>
//        = { _,_,_ in  }
//    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void {
//         axc_webViewDidReceiveCompletionHandlerBlock(webView,challenge,completionHandler)
//    }
//
//
//    /// optional func webViewWebContentProcessDidTerminate(_ webView: WKWebView)
//    @discardableResult
//    open func axc_setWebViewWebContentProcessDidTerminateBlock(_ block: @escaping WKWebView.AxcBlock<Void>) -> Self {
//        axc_webViewWebContentProcessDidTerminateBlock = block
//        return self
//    }
//    open lazy var axc_webViewWebContentProcessDidTerminateBlock: WKWebView.AxcBlock<Void>
//        = { _ in  }
//    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) -> Void {
//         axc_webViewWebContentProcessDidTerminateBlock(webView)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, authenticationChallenge challenge: URLAuthenticationChallenge, shouldAllowDeprecatedTLS decisionHandler: @escaping (Bool) -> Void)
//    @available(iOS 14.0, *)
//    @discardableResult
//    open func axc_setWebViewAuthenticationChallengeShouldAllowDeprecatedTLSBlock(_ block: @escaping WKWebView.AxcURLAuthenticationChallengeBoolBlock<Void>) -> Self {
//        axc_webViewAuthenticationChallengeShouldAllowDeprecatedTLSBlock = block
//        return self
//    }
//    open lazy var axc_webViewAuthenticationChallengeShouldAllowDeprecatedTLSBlock: WKWebView.AxcURLAuthenticationChallengeBoolBlock<Void>
//        = { _,_,_ in  }
//    @available(iOS 14.0, *)
//    public func webView(_ webView: WKWebView, authenticationChallenge challenge: URLAuthenticationChallenge, shouldAllowDeprecatedTLS decisionHandler: @escaping (Bool) -> Void) -> Void {
//         axc_webViewAuthenticationChallengeShouldAllowDeprecatedTLSBlock(webView,challenge,decisionHandler)
//    }
//}
//
//// MARK: UIDelegate桥接者
///// 代理转Block桥接者
//open class AxcWebUIDelegate: NSObject, WKUIDelegate {
//    /// optional func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?
//    @discardableResult
//    open func axc_setWebViewCreateWebViewWithForWindowFeaturesBlock(_ block: @escaping WKWebView.AxcConfigurationNavigationActionWindowFeaturesBlock<WKWebView?>) -> Self {
//        axc_webViewCreateWebViewWithForWindowFeaturesBlock = block
//        return self
//    }
//    open lazy var axc_webViewCreateWebViewWithForWindowFeaturesBlock: WKWebView.AxcConfigurationNavigationActionWindowFeaturesBlock<WKWebView?>
//        = { _,_,_,_ in return nil }
//    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        return axc_webViewCreateWebViewWithForWindowFeaturesBlock(webView,configuration,navigationAction,windowFeatures)
//    }
//
//
//    /// optional func webViewDidClose(_ webView: WKWebView)
//    @discardableResult
//    open func axc_setWebViewDidCloseBlock(_ block: @escaping WKWebView.AxcBlock<Void>) -> Self {
//        axc_webViewDidCloseBlock = block
//        return self
//    }
//    open lazy var axc_webViewDidCloseBlock: WKWebView.AxcBlock<Void>
//        = { _ in  }
//    public func webViewDidClose(_ webView: WKWebView) -> Void {
//         axc_webViewDidCloseBlock(webView)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void)
//    @discardableResult
//    open func axc_setWebViewRunJavaScriptAlertPanelWithMessageInitiatedByFrameCompletionHandlerBlock(_ block: @escaping WKWebView.AxcStringFrameInfoBlock<Void>) -> Self {
//        axc_webViewRunJavaScriptAlertPanelWithMessageInitiatedByFrameCompletionHandlerBlock = block
//        return self
//    }
//    open lazy var axc_webViewRunJavaScriptAlertPanelWithMessageInitiatedByFrameCompletionHandlerBlock: WKWebView.AxcStringFrameInfoBlock<Void>
//        = { _,_,_,_ in  }
//    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) -> Void {
//         axc_webViewRunJavaScriptAlertPanelWithMessageInitiatedByFrameCompletionHandlerBlock(webView,message,frame,completionHandler)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void)
//    @discardableResult
//    open func axc_setWebViewRunJavaScriptConfirmPanelWithMessageInitiatedByFrameCompletionHandlerBlock(_ block: @escaping WKWebView.AxcStringFrameInfoBoolBlock<Void>) -> Self {
//        axc_webViewRunJavaScriptConfirmPanelWithMessageInitiatedByFrameCompletionHandlerBlock = block
//        return self
//    }
//    open lazy var axc_webViewRunJavaScriptConfirmPanelWithMessageInitiatedByFrameCompletionHandlerBlock: WKWebView.AxcStringFrameInfoBoolBlock<Void>
//        = { _,_,_,_ in  }
//    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) -> Void {
//         axc_webViewRunJavaScriptConfirmPanelWithMessageInitiatedByFrameCompletionHandlerBlock(webView,message,frame,completionHandler)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void)
//    @discardableResult
//    open func axc_setWebViewRunJavaScriptTextInputPanelWithPromptDefaultTextInitiatedByFrameCompletionHandlerBlock(_ block: @escaping WKWebView.AxcStringStringFrameInfoBlock<Void>) -> Self {
//        axc_webViewRunJavaScriptTextInputPanelWithPromptDefaultTextInitiatedByFrameCompletionHandlerBlock = block
//        return self
//    }
//    open lazy var axc_webViewRunJavaScriptTextInputPanelWithPromptDefaultTextInitiatedByFrameCompletionHandlerBlock: WKWebView.AxcStringStringFrameInfoBlock<Void>
//        = { _,_,_,_,_ in  }
//    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) -> Void {
//         axc_webViewRunJavaScriptTextInputPanelWithPromptDefaultTextInitiatedByFrameCompletionHandlerBlock(webView,prompt,defaultText,frame,completionHandler)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool
//    @discardableResult
//    open func axc_setWebViewShouldPreviewElementBlock(_ block: @escaping WKWebView.AxcPreviewElementInfoBlock<Bool>) -> Self {
//        axc_webViewShouldPreviewElementBlock = block
//        return self
//    }
//    open lazy var axc_webViewShouldPreviewElementBlock: WKWebView.AxcPreviewElementInfoBlock<Bool>
//        = { _,_ in return true }
//    public func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
//        return axc_webViewShouldPreviewElementBlock(webView,elementInfo)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController?
//    @discardableResult
//    open func axc_setWebViewPreviewingViewControllerForElementDefaultActionsBlock(_ block: @escaping WKWebView.AxcPreviewElementInfoPreviewActionItemsBlock<UIViewController?>) -> Self {
//        axc_webViewPreviewingViewControllerForElementDefaultActionsBlock = block
//        return self
//    }
//    open lazy var axc_webViewPreviewingViewControllerForElementDefaultActionsBlock: WKWebView.AxcPreviewElementInfoPreviewActionItemsBlock<UIViewController?>
//        = { _,_,_ in return nil }
//    public func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
//        return axc_webViewPreviewingViewControllerForElementDefaultActionsBlock(webView,elementInfo,previewActions)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController)
//    @discardableResult
//    open func axc_setWebViewCommitPreviewingViewControllerBlock(_ block: @escaping WKWebView.AxcViewControllerBlock<Void>) -> Self {
//        axc_webViewCommitPreviewingViewControllerBlock = block
//        return self
//    }
//    open lazy var axc_webViewCommitPreviewingViewControllerBlock: WKWebView.AxcViewControllerBlock<Void>
//        = { _,_ in  }
//    public func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) -> Void {
//         axc_webViewCommitPreviewingViewControllerBlock(webView,previewingViewController)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, contextMenuConfigurationForElement elementInfo: WKContextMenuElementInfo, completionHandler: @escaping (UIContextMenuConfiguration?) -> Void)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setWebViewContextMenuConfigurationForElementCompletionHandlerBlock(_ block: @escaping WKWebView.AxcContextMenuElementInfoMenuConfigBlock<Void>) -> Self {
//        axc_webViewContextMenuConfigurationForElementCompletionHandlerBlock = block
//        return self
//    }
//    @available(iOS 13.0, *)
//    open lazy var axc_webViewContextMenuConfigurationForElementCompletionHandlerBlock: WKWebView.AxcContextMenuElementInfoMenuConfigBlock<Void>
//        = { _,_,_ in  }
//    @available(iOS 13.0, *)
//    public func webView(_ webView: WKWebView, contextMenuConfigurationForElement elementInfo: WKContextMenuElementInfo, completionHandler: @escaping (UIContextMenuConfiguration?) -> Void) -> Void {
//         axc_webViewContextMenuConfigurationForElementCompletionHandlerBlock(webView,elementInfo,completionHandler)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setWebViewContextMenuWillPresentForElementBlock(_ block: @escaping WKWebView.AxcContextMenuElementInfoBlock<Void>) -> Self {
//        axc_webViewContextMenuWillPresentForElementBlock = block
//        return self
//    }
//    @available(iOS 13.0, *)
//    open lazy var axc_webViewContextMenuWillPresentForElementBlock: WKWebView.AxcContextMenuElementInfoBlock<Void>
//        = { _,_ in  }
//    @available(iOS 13.0, *)
//    public func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo) -> Void {
//         axc_webViewContextMenuWillPresentForElementBlock(webView,elementInfo)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, contextMenuForElement elementInfo: WKContextMenuElementInfo, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setWebViewContextMenuForElementWillCommitWithAnimatorBlock(_ block: @escaping WKWebView.AxcContextMenuElementInfoContextMenuInteractionCommitAnimatingBlock<Void>) -> Self {
//        axc_webViewContextMenuForElementWillCommitWithAnimatorBlock = block
//        return self
//    }
//    @available(iOS 13.0, *)
//    open lazy var axc_webViewContextMenuForElementWillCommitWithAnimatorBlock: WKWebView.AxcContextMenuElementInfoContextMenuInteractionCommitAnimatingBlock<Void>
//        = { _,_,_ in  }
//    @available(iOS 13.0, *)
//    public func webView(_ webView: WKWebView, contextMenuForElement elementInfo: WKContextMenuElementInfo, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating) -> Void {
//         axc_webViewContextMenuForElementWillCommitWithAnimatorBlock(webView,elementInfo,animator)
//    }
//
//
//    /// optional func webView(_ webView: WKWebView, contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setWebViewContextMenuDidEndForElementBlock(_ block: @escaping WKWebView.AxcContextMenuElementInfoBlock<Void>) -> Self {
//        axc_webViewContextMenuDidEndForElementBlock = block
//        return self
//    }
//    @available(iOS 13.0, *)
//    open lazy var axc_webViewContextMenuDidEndForElementBlock: WKWebView.AxcContextMenuElementInfoBlock<Void>
//        = { _,_ in  }
//    @available(iOS 13.0, *)
//    public func webView(_ webView: WKWebView, contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo) -> Void {
//         axc_webViewContextMenuDidEndForElementBlock(webView,elementInfo)
//    }
//}
