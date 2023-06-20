//
//  AxcBadrockProtocol.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/19.
//

import UIKit

// BadRock公用开放功能性协议

// MARK: - UIView协议
// MARK: Nib加载协议
/// Nib加载协议，遵循协议后，可以通过Class.axc_loadNib来进行加载
public protocol AxcNibLoadableProtocol {}
public extension AxcNibLoadableProtocol where Self : UIView {
    /// 通过Nib加载
    static func axc_loadNib(_ bundle: Bundle? = nil, frame: CGRect? = nil) -> Self {
        let _bundle = bundle ?? Axc_bundle
        let loadName = "\(self)"
        guard let nibObj = _bundle.loadNibNamed(loadName, owner: nil, options: nil)?.first
                as? Self else { fatalError("Nib加载失败！请检查Xib文件是否设置正确") }
        if let rect = frame { nibObj.frame = rect }
        return nibObj
    }
}

// MARK: 渐变色
/// view底层渐变色
public protocol AxcGradientLayerProtocol {}
public extension AxcGradientLayerProtocol where Self : UIView {
    /// 获取渐变色Layer
    var axc_gradientLayer: CAGradientLayer? {
        guard let gradientLayer = layer as? CAGradientLayer else { return nil }
        return gradientLayer
    }
    /// 设置背景色渐变
    /// - Parameters:
    ///   - colors: 渐变色组 默认主题渐变
    ///   - startDirection: 开始点位，支持按位或运算
    ///   - endDirection: 结束点位，支持按位或运算
    ///   - locations: 比率
    ///   - type: type
    func axc_setGradient(colors: [UIColor]? = nil,
                         startDirection: AxcDirection  = .left,
                         endDirection: AxcDirection    = .right,
                         locations: [CGFloat]? = nil,
                         type: CAGradientLayerType = .axial ) {
        backgroundColor = UIColor.clear // 清除背景色
        let _colors = colors ?? AxcBadrock.shared.themeGradientColors
        axc_gradientLayer?.colors = _colors.map(\.cgColor)
        axc_gradientLayer?.locations = locations?.map { NSNumber(value: Double($0)) }
        axc_gradientLayer?.startPoint = CAGradientLayer.axc_point(with: startDirection)
        axc_gradientLayer?.endPoint = CAGradientLayer.axc_point(with: endDirection)
        axc_gradientLayer?.type = type
    }
    /// 移除背景色渐变
    func axc_removeGradient() {
        axc_gradientLayer?.colors = nil
    }
}

// MARK: 视图组动画协议
/// 子视图动画协议
public protocol AxcSubviewsAnimationProtocol {
    /// 遵循协议的类需要返回需要执行动画的视图组
    /// - Parameter style: 准备执行的动画
    func axc_animationViews(_ animation: CAAnimation) -> [UIView]
}
public extension AxcSubviewsAnimationProtocol {
    /// 计算动画开始时间的Block
    typealias AxcConfigAnimationBlock = (_ idx: Int, _ animation: CAAnimation) -> Void
    /// 执行一组视图动画
    /// - Parameters:
    ///   - style: 动画样式
    ///   - configAnimationBlock: 配置动画其他属性的Block回调
    func axc_startSubviewAnimation(_ animation: CAAnimation, configAnimationBlock: AxcConfigAnimationBlock? = nil) {
        let views = axc_animationViews(animation)
        for (index, view) in views.enumerated() {
            if let block = configAnimationBlock { block(index, animation) }
            view.axc_addAnimation(animation)
        }
    }
}

// MARK: 长按复制协议
/// 长按复制协议
public protocol AxcLongPressCopyProtocol {
    /// 遵循协议的类需要返回在点击复制后，复制的文本
    func axc_pasteboardStr(sender: Any? ) -> String?
}
private var kaxc_openLongPressCopy  = "kaxc_openLongPressCopy"
private var kaxc_longPressGesture   = "kaxc_longPressGesture"
public extension AxcLongPressCopyProtocol where Self : UIView {
    /// 是否开启长按复制功能
    var axc_openLongPressCopy: Bool {
        set {
            newValue ? addLongPressGesture() : removeLongPressGesture()
            AxcRuntime.setObj(self, &kaxc_openLongPressCopy, newValue )
        }
        get {   // runtime 懒加载
            guard let open: Bool = AxcRuntime.getObj(self, &kaxc_openLongPressCopy) else {
                self.axc_openLongPressCopy = false  // 默认设置成false
                return false
            }
            return open
        }
    }
    // 长按手势的set&get
    private var _longPressGesture: UILongPressGestureRecognizer {
        set { AxcRuntime.setObj(self, &kaxc_longPressGesture, newValue) }
        get {   // runtime 懒加载
            guard let longPressGesture: UILongPressGestureRecognizer = AxcRuntime.getObj(self, &kaxc_longPressGesture) else {
                let lazyLong = UILongPressGestureRecognizer()
                self._longPressGesture = lazyLong   // set
                return lazyLong
            }
            return longPressGesture
        }
    }
    // 添加长按手势
    private func addLongPressGesture() {
        isUserInteractionEnabled = true
        removeLongPressGesture()    // 确保不重复添加
        axc_addGesture(_longPressGesture)
        _longPressGesture.axc_actionBlock =  { [weak self] (sender) in
            guard let weakSelf = self else { return }
            if sender == weakSelf._longPressGesture {
                if sender.state == .ended {
                    let alentController = UIAlertController(title: AxcBadrockLanguage("复制文本"),
                                                            actionTitles: [ AxcBadrockLanguage("复制") ]) { [weak self] (action) in
                        guard let weakSelf = self else { return }   // 通过协议接口回调拿到需要复制的文本
                        UIPasteboard.general.string = weakSelf.axc_pasteboardStr(sender: action)
                    }
                    alentController.axc_show()
                }
            }
        }
    }
    // 移除长按手势
    private func removeLongPressGesture() { // 移除
        removeGestureRecognizer(_longPressGesture)
    }
}

// MARK: 添加左右按钮协议
public protocol AxcLeftRightBtnProtocol {
    /// 设置按钮样式
    /// - Parameter direction: 当前设置的按钮方位 左/右
    func axc_settingBtn(direction: AxcDirection) -> AxcButton
}
private var kaxc_leftButton = "kaxc_leftButton"
private var kaxc_rightButton = "kaxc_rightButton"
public extension AxcLeftRightBtnProtocol where Self: UIView {
    /// 左按钮
    var axc_leftButton: AxcButton {
        set { AxcRuntime.setObj(self, &kaxc_leftButton, newValue) }
        get {
            guard let axc_leftButton: AxcButton = AxcRuntime.getObj(self, &kaxc_leftButton) else {
                let btn = axc_settingBtn(direction: .left)
                self.axc_leftButton = btn
                return btn
            }
            return axc_leftButton
        }
    }
    /// 右按钮
    var axc_rightButton: AxcButton {
        set { AxcRuntime.setObj(self, &kaxc_rightButton, newValue) }
        get {
            guard let axc_rightButton: AxcButton = AxcRuntime.getObj(self, &kaxc_rightButton) else {
                let btn = axc_settingBtn(direction: .right)
                self.axc_rightButton = btn
                return btn
            }
            return axc_rightButton
        }
    }
}

// MARK: 添加左右视图协议
public protocol AxcLeftRightViewProtocol {
    /// 设置按钮样式
    /// - Parameter direction: 当前设置的按钮方位 左/右
    func axc_settingView(direction: AxcDirection) -> AxcBaseView
}
private var kaxc_leftView = "kaxc_leftView"
private var kaxc_rightView = "kaxc_rightView"
public extension AxcLeftRightViewProtocol where Self: UIView {
    /// 左视图
    var axc_leftView: AxcBaseView {
        set { AxcRuntime.setObj(self, &kaxc_leftView, newValue) }
        get {
            guard let axc_leftView: AxcBaseView = AxcRuntime.getObj(self, &kaxc_leftView) else {
                let view = axc_settingView(direction: .left)
                self.axc_leftView = view
                return view
            }
            return axc_leftView
        }
    }
    /// 右视图
    var axc_rightView: AxcBaseView {
        set { AxcRuntime.setObj(self, &kaxc_rightView, newValue) }
        get {
            guard let axc_rightView: AxcBaseView = AxcRuntime.getObj(self, &kaxc_rightView) else {
                let view = axc_settingView(direction: .right)
                self.axc_rightView = view
                return view
            }
            return axc_rightView
        }
    }
}

// MARK: 添加背景图片视图协议
public protocol AxcBackgroundImageViewProtocol {}
private var kaxc_backgroundImageView = "kaxc_rightView"
public extension AxcBackgroundImageViewProtocol where Self: NSObject {
    var axc_backgroundImageView: UIImageView {
        set { AxcRuntime.setObj(self, &kaxc_backgroundImageView, newValue) }
        get {
            guard let backgroundImageView: UIImageView = AxcRuntime.getObj(self, &kaxc_backgroundImageView) else {
                let imgV = UIImageView()
                self.axc_backgroundImageView = imgV
                return imgV
            }
            return backgroundImageView
        }
    }
}

// MARK: ActionBlock协议
/// 添加触发Block协议
public protocol AxcActionBlockProtocol {}
public typealias AxcActionBlock = (Any?) -> Void
/// actionBlock的键
private var kaxc_actionBlock = "kaxc_actionBlock"
public extension AxcActionBlockProtocol {
    func axc_setActionBlock(_ block: @escaping AxcActionBlock ) {
        AxcRuntime.setObj(self, &kaxc_actionBlock, block, .OBJC_ASSOCIATION_COPY)
    }
    func axc_getActionBlock() -> AxcActionBlock? {
        guard let block: AxcActionBlock = AxcRuntime.getObj(self, &kaxc_actionBlock) else { return nil }
        return block
    }
}

// MARK: tag标签协议
public protocol AxcTagsProtocol {}
private var kaxc_intTag     = "kaxc_intTag"
private var kaxc_floatTag   = "kaxc_floatTag"
private var kaxc_cgFloatTag = "kaxc_cgFloatTag"
private var kaxc_strTag     = "kaxc_strTag"
public extension AxcTagsProtocol {
    /// 长整型Tag
    var axc_intTag: Int {
        get { guard let tag: Int = AxcRuntime.getObj(self, &kaxc_intTag) else {
                let _tag = 0
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_intTag, newValue) }
    }
    /// 浮点型Tag
    var axc_floatTag: Float {
        get { guard let tag: Float = AxcRuntime.getObj(self, &kaxc_floatTag) else {
                let _tag: Float = 0
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_floatTag, newValue) }
    }
    /// 浮点型Tag
    var axc_cgFloatTag: CGFloat {
        get { guard let tag: CGFloat = AxcRuntime.getObj(self, &kaxc_cgFloatTag) else {
                let _tag: CGFloat = 0
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_cgFloatTag, newValue) }
    }
    /// 字符串型Tag
    var axc_strTag: String {
        get { guard let tag: String = AxcRuntime.getObj(self, &kaxc_strTag) else {
                let _tag = ""
                AxcRuntime.setObj(self, &kaxc_strTag, _tag)
                return _tag
            }
            return tag
        }
        set { AxcRuntime.setObj(self, &kaxc_strTag, newValue) }
    }
}

// MARK: 唯一标识符协议
public protocol AxcIdentifierProtocol {
    /// 返回设置的唯一标识符
    func axc_identifier() -> String
}

// MARK: - 属性监听类协议
// MARK: 发生LayoutSubview时回调
/// LayoutSubview回调的Block
public protocol AxcLayoutSubviewProtocol {}
public typealias AxcLayoutSubviewBlock = (CGRect) -> Void
private var kaxc_layoutSubviewBlock = "kaxc_layoutSubviewBlock"
extension AxcLayoutSubviewProtocol where Self: UIView{
    var axc_layoutSubviewBlock: AxcLayoutSubviewBlock? {
        set { AxcRuntime.setObj(self, &kaxc_layoutSubviewBlock, newValue) }
        get {
            guard let block: AxcLayoutSubviewBlock = AxcRuntime.getObj(self, &kaxc_layoutSubviewBlock)
            else { return nil }
            return block
        }
    }
}
