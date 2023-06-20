//
//  AxcBaseClassProtocol.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

/// 初始化时配置参数接口
public protocol AxcBaseClassConfigProtocol {
    /// 初始化时配置参数接口
    func config()
}
/// 创建UI的接口
public protocol AxcBaseClassMakeUIProtocol {
    /// 创建UI的接口
    func makeUI()
}
/// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
public protocol AxcBaseClassMakeXibProtocol: AxcBaseClassMakeUIProtocol {
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    func makeXmlInterfaceBuilder()
}

