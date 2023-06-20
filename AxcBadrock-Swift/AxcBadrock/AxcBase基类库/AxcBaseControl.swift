//
//  AxcBaseControl.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - AxcBaseControl
/// 基类Control视图
@IBDesignable
open class AxcBaseControl: UIControl,
                             AxcBaseClassConfigProtocol,
                             AxcBaseClassMakeXibProtocol,
                             AxcGradientLayerProtocol {
    // MARK: - 初始化
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
    
    // MARK: - 子类实现
    /// 配置参数
    open func config() { }
    /// 创建UI
    open func makeUI() { }
    /// 刷新布局
    open func reloadLayout() { }
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
