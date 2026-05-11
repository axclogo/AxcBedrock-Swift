//
//  AxcBedrockView.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/28.
//

#if os(macOS)
import AppKit

public typealias AxcBedrockView = NSView

#elseif os(iOS) || os(tvOS) || os(watchOS)

import UIKit

public typealias AxcBedrockView = UIView
#endif

// MARK: - 数据转换

public extension AxcSpace where Base: AxcBedrockView { }

// MARK: - 类方法

public extension AxcSpace where Base: AxcBedrockView {
    /// （💈跨平台标识）通过Nib进行加载
    /// - Returns: 视图
    static func CreateFromNib(name: String? = nil,
                              bundle: Bundle? = nil,
                              frame: CGRect = .zero) -> Base {
        var nibName: String = NSStringFromClass(Base.self)
        if let name = name {
            nibName = name
        }
        let nib = AxcBedrockNib.Axc.Create(nibName: nibName, bundle: bundle)
        #if os(macOS)
        var topLevelObjs: NSArray?
        let isSuccess = nib.instantiate(withOwner: self, topLevelObjects: &topLevelObjs)
        let views = topLevelObjs as? [Any]
        guard isSuccess, let views else {
            let log = "没有找到这个名称对应的Nib文件！\nname: \(nibName), bundle: \(String(describing: bundle))"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return Base() // 默认走实例化方法
            #endif
        }

        #elseif os(iOS) || os(tvOS) || os(watchOS)

        let views = nib.instantiate(withOwner: nil, options: nil)
        #endif

        var findView: Base?
        views.forEach { view in
            if let _view = view as? Base {
                findView = _view
            }
        }
        guard let _findView = findView else {
            let log = "没有找到这个名称对应的Nib文件！\nname: \(nibName), bundle: \(String(describing: bundle))"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return Base() // 默认走实例化方法
            #endif
        }
        _findView.frame = frame
        return _findView
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AxcBedrockView {
    /// （💈跨平台标识）读x
    var x: CGFloat {
        return origin.x
    }

    /// （💈跨平台标识）读y
    var y: CGFloat {
        return origin.y
    }

    /// （💈跨平台标识）读width
    var width: CGFloat {
        return size.width
    }

    /// （💈跨平台标识）读height
    var height: CGFloat {
        return size.height
    }

    /// （💈跨平台标识）读origin
    var origin: CGPoint {
        return base.frame.origin
    }

    /// （💈跨平台标识）读size
    var size: CGSize {
        return base.frame.size
    }

    /// （💈跨平台标识）设置x
    /// - Parameter x: x
    /// - Returns: 设置后的frame
    func set(x: AxcUnifiedNumber) {
        base.frame = base.frame.axc.set(x: x)
    }

    /// （💈跨平台标识）设置y
    /// - Parameter y: y
    /// - Returns: 设置后的frame
    func set(y: AxcUnifiedNumber) {
        base.frame = base.frame.axc.set(y: y)
    }

    /// （💈跨平台标识）设置width
    /// - Parameter width: width
    /// - Returns: 设置后的frame
    func set(width: AxcUnifiedNumber) {
        base.frame = base.frame.axc.set(width: width)
    }

    /// （💈跨平台标识）设置height
    /// - Parameter height: height
    /// - Returns: 设置后的frame
    func set(height: AxcUnifiedNumber) {
        base.frame = base.frame.axc.set(height: height)
    }

    /// （💈跨平台标识）设置origin
    /// - Parameter origin: origin
    /// - Returns: 设置后的frame
    func set(origin: CGPoint) {
        base.frame = base.frame.axc.set(origin: origin)
    }

    /// （💈跨平台标识）设置size
    /// - Parameter size: size
    /// - Returns: 设置后的frame
    func set(size: CGSize) {
        base.frame = base.frame.axc.set(size: size)
    }

    /// （💈跨平台标识）设置动画
    /// - Parameters:
    ///   - makeBlock: 设置代码块
    ///   - complete: 单个执行完的回调
    ///   - allComplete: 全部执行完的回调
    func makeAnimation(_ makeBlock: AxcBlock.Maker<AxcMaker.LayerAnimation>,
                       complete: AxcBlock.OneParam<CAAnimation>? = nil,
                       allComplete: AxcBlock.Empty? = nil) {
        let layer = base.layer
        #if os(macOS)
        guard let layer else { return }
        #endif
        layer.axc.makeAnimation(makeBlock, complete: complete, allComplete: allComplete)
    }

    /// （💈跨平台标识）设置独立圆角
    /// - Parameters:
    ///   - maskedCorners: 独立圆角位置
    ///   - cornerRadius: 半径
    @available(iOS 11.0, *)
    func set(corners: AxcCorner,
             cornerRadius: CGFloat) {
        let layer = base.layer
        #if os(macOS)
        guard let layer else { return }
        #endif
        layer.axc.set(corners: corners, cornerRadius: cornerRadius)
    }
}

// MARK: - 布局设置

public extension AxcSpace where Base: AxcBedrockView {
    /// （💈跨平台标识）布局全填充
    func layoutFillToSuperview() {
        base.translatesAutoresizingMaskIntoConstraints = false
        if let superview = base.superview {
            let centerX = base.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
            let centerY = base.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            let width = base.widthAnchor.constraint(equalTo: superview.widthAnchor)
            let height = base.heightAnchor.constraint(equalTo: superview.heightAnchor)
            NSLayoutConstraint.activate([centerX, centerY, width, height])
        }
    }

    /// （💈跨平台标识）设置width equal的NSLayoutConstraint
    /// - Parameter constant: 值
    /// - Returns: NSLayoutConstraint
    @discardableResult
    func layoutWidthEqual(_ constant: AxcUnifiedNumber) -> NSLayoutConstraint {
        return layoutEqual(.width, constant: constant)
    }

    /// （💈跨平台标识）设置height equal的NSLayoutConstraint
    /// - Parameter constant: 值
    /// - Returns: NSLayoutConstraint
    @discardableResult
    func layoutHeightEqual(_ constant: AxcUnifiedNumber) -> NSLayoutConstraint {
        return layoutEqual(.height, constant: constant)
    }

    /// （💈跨平台标识）设置单个equal的NSLayoutConstraint
    /// - Parameters:
    ///   - attribute: 参数
    ///   - constant: 值
    /// - Returns: NSLayoutConstraint
    @discardableResult
    func layoutEqual(_ attribute: NSLayoutConstraint.Attribute,
                     constant: AxcUnifiedNumber) -> NSLayoutConstraint {
        let layout = NSLayoutConstraint(item: base,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0.0,
                                        constant: assertTransformCGFloat(constant))
        base.addConstraint(layout)
        return layout
    }

    /// （💈跨平台标识）移除所有NSLayoutConstraint
    func layoutRemoveAll() {
        base.removeConstraints(base.constraints)
    }

    /// （💈跨平台标识）设置抗拉伸
    /// - Parameters:
    ///   - value: 值
    ///   - axis: 轴
    /// - Returns: Self
    @discardableResult
    func setHuggingPriority(priority: AxcBedrockLayoutPriority,
                            axis: AxcBedrockLayoutAxis) -> Base {
        base.setContentHuggingPriority(priority, for: axis)
        return base
    }

    /// （💈跨平台标识）设置抗压缩
    /// - Parameters:
    ///   - value: 值
    ///   - axis: 轴
    /// - Returns: Self
    func setCompressionResistance(priority: AxcBedrockLayoutPriority,
                                  axis: AxcBedrockLayoutAxis) -> Base {
        base.setContentCompressionResistancePriority(priority, for: axis)
        return base
    }
}

// MARK: - 外观设置

public extension AxcSpace where Base: AxcBedrockView {
    /// （💈跨平台标识）添加阴影
    /// - Parameters:
    ///   - color: 颜色
    ///   - offset: 偏移量
    ///   - opacity: 模糊度
    ///   - radius: 圆角
    func setShadow(color: AxcUnifiedColor,
                   offset: CGSize,
                   opacity: AxcUnifiedNumber,
                   radius: AxcUnifiedNumber) {
        let layer = base.layer
        #if os(macOS)
        guard let layer else { return }
        #endif
        layer.shadowColor = CGColor.Axc.CreateOptional(color)
        layer.shadowOffset = offset
        layer.shadowOpacity = Float.Axc.Create(opacity)
        layer.shadowRadius = CGFloat.Axc.Create(radius)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: AxcBedrockView {
    // MARK: 点

    /// （💈跨平台标识）判断这个点是否包含在本视图范围内
    func isContains(to point: CGPoint) -> Bool {
        return base.bounds.contains(point)
    }

    // MARK: 面

    /// （💈跨平台标识）判断这个视图是否包含在本视图范围内
    func isContains(to view: AxcBedrockView) -> Bool {
        return base.bounds.contains(view.bounds)
    }

    /// （💈跨平台标识）判断两个视图是否有交错
    func isIntersects(to view: AxcBedrockView) -> Bool {
        return base.bounds.intersects(view.bounds)
    }

    // MARK: 其他

    /// （💈跨平台标识）是否包含其他视图
    func isContains(_ anyClass: AnyClass) -> Bool {
        var isConstraints = false
        for view in base.subviews {
            if view.isKind(of: anyClass) {
                isConstraints = true
                break
            }
        }
        return isConstraints
    }
}
