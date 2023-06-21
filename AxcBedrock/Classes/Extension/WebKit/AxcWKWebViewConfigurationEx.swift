//
//  AxcWeb.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/26.
//

import WebKit

// MARK: - 数据转换

public extension AxcSpace where Base: WKWebViewConfiguration {}

// MARK: - 类方法

public extension AxcSpace where Base: WKWebViewConfiguration {
    /// 生成配置属性
    static func CreateConfiguration(_ makeBlock: AxcBlock.Maker<AxcBedrockLib.WebViewConfigurationMaker>)
        -> WKWebViewConfiguration
    {
        return .init().axc.makeConfiguration(makeBlock)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: WKWebViewConfiguration {
    /// 设置配置属性
    func makeConfiguration(_ makeBlock: AxcBlock.Maker<AxcBedrockLib.WebViewConfigurationMaker>)
        -> WKWebViewConfiguration
    {
        let maker: AxcBedrockLib.WebViewConfigurationMaker = .init(configuration: base)
        makeBlock(maker)
        return maker.configuration
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: WKWebViewConfiguration {}
