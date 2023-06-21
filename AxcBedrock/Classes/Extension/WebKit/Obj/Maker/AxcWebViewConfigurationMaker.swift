//
//  AxcWebViewConfigurationMaker.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/27.
//

import WebKit

// MARK: - [AxcBedrockLib.WebViewConfigurationMaker]

public extension AxcBedrockLib {
    /// WebView配置器
    class WebViewConfigurationMaker {
        init(configuration: WKWebViewConfiguration) {
            self.configuration = configuration
        }

        var configuration: WKWebViewConfiguration
    }
}

// MARK: - AxcBedrockLib.WebViewConfigurationMaker + AxcAssertUnifiedTransformTarget

extension AxcBedrockLib.WebViewConfigurationMaker: AxcAssertUnifiedTransformTarget { }

public extension AxcBedrockLib.WebViewConfigurationMaker {
    /// 进程池，从中获取视图的web内容的过程
    @discardableResult
    func set(processPool: WKProcessPool) -> Self {
        configuration.processPool = processPool
        return self
    }

    /// web视图使用的首选项设置
    @discardableResult
    func set(preferences: WKPreferences) -> Self {
        configuration.preferences = preferences
        return self
    }

    /// 要关联到web视图的用户内容控制器
    @discardableResult
    func set(userContentController: WKUserContentController) -> Self {
        configuration.userContentController = userContentController
        return self
    }

    /// web视图使用的网站数据存储
    @discardableResult
    func set(websiteDataStore: WKWebsiteDataStore) -> Self {
        configuration.websiteDataStore = websiteDataStore
        return self
    }

    /// 一个布尔值，指示web视图是否抑制内容呈现，直到完全加载到内存中
    @discardableResult
    func set(suppressesIncrementalRendering: Bool) -> Self {
        configuration.suppressesIncrementalRendering = suppressesIncrementalRendering
        return self
    }

    /// 在用户代理字符串中使用的应用程序的名称
    @discardableResult
    func set(applicationNameForUserAgent: String?) -> Self {
        configuration.applicationNameForUserAgent = applicationNameForUserAgent
        return self
    }

    /// 一个布尔值，指示是否允许AirPlay
    @discardableResult
    func set(allowsAirPlayForMediaPlayback: Bool) -> Self {
        configuration.allowsAirPlayForMediaPlayback = allowsAirPlayForMediaPlayback
        return self
    }

    /// 一个布尔值，指示对已知支持HTTPS的服务器的HTTP请求是否应该自动升级为HTTPS请求
    @available(iOS 15.0, macOS 11.3, *)
    func set(upgradeKnownHostsToHTTPS: Bool) -> Self {
        configuration.upgradeKnownHostsToHTTPS = upgradeKnownHostsToHTTPS
        return self
    }

    /// 播放时需要用户操作的媒体类型
    @discardableResult
    func set(mediaTypesRequiringUserActionForPlayback: WKAudiovisualMediaTypes) -> Self {
        configuration.mediaTypesRequiringUserActionForPlayback = mediaTypesRequiringUserActionForPlayback
        return self
    }

    /// 加载和呈现内容时使用的默认网页首选项集
    @available(iOS 13.0, *)
    @discardableResult
    func set(defaultWebpagePreferences: WKWebpagePreferences!) -> Self {
        configuration.defaultWebpagePreferences = defaultWebpagePreferences
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult
    func set(limitsNavigationsToAppBoundDomains: Bool) -> Self {
        configuration.limitsNavigationsToAppBoundDomains = limitsNavigationsToAppBoundDomains
        return self
    }

    #if os(iOS)
    /// 一个布尔值，指示HTML5视频是否内联播放(YES)或使用本机全屏控制器(NO)
    @discardableResult
    func set(allowsInlineMediaPlayback: Bool) -> Self {
        configuration.allowsInlineMediaPlayback = allowsInlineMediaPlayback
        return self
    }

    /// 用户可以交互使用的粒度级别在web视图中选择内容
    @discardableResult
    func set(selectionGranularity: WKSelectionGranularity) -> Self {
        configuration.selectionGranularity = selectionGranularity
        return self
    }

    /// 一个布尔值，指示是否可以播放HTML5视频画中画
    @available(iOS 9.0, *)
    @discardableResult
    func set(allowsPictureInPictureMediaPlayback: Bool) -> Self {
        configuration.allowsPictureInPictureMediaPlayback = allowsPictureInPictureMediaPlayback
        return self
    }

    /// 指示所需数据检测类型的枚举值
    @available(iOS 10.0, *)
    @discardableResult
    func set(dataDetectorTypes: WKDataDetectorTypes) -> Self {
        configuration.dataDetectorTypes = dataDetectorTypes
        return self
    }

    /// 一个布尔值，指示WKWebView是否应该总是允许网页缩放，而不考虑作者的意图
    @available(iOS 10.0, *)
    @discardableResult
    func set(ignoresViewportScaleLimits: Bool) -> Self {
        configuration.ignoresViewportScaleLimits = ignoresViewportScaleLimits
        return self
    }
    #endif
}
