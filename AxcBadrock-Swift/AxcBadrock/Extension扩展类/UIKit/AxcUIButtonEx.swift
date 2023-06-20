//
//  AxcUIButtonEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/18.
//

import UIKit

// MARK: - 类方法/属性
public extension UIButton {
    /// 初始化
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - state: 状态
    convenience init(title: String? = nil, image: UIImage? = nil, state: UIControl.State = .normal) {
        self.init()
        axc_set(title: title, image: image, state: state)
    }
    
    /// 初始化设置背景图片
    /// - Parameters:
    ///   - backgroundImage: 背景图片
    ///   - state: 状态
    convenience init(backgroundImage: UIImage, state: UIControl.State = .normal) {
        self.init()
        setBackgroundImage(backgroundImage, for: state)
    }
    
    /// 标题背景色按钮
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题色
    ///   - backgroundColor: 背景色
    convenience init(title: String,
                     font: UIFont,
                     titleColor: UIColor = .white,
                     backgroundColor: UIColor = .clear) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        axc_font = font
    }
}

// MARK: - 属性 & Api
private var kaxc_style = "kaxc_style"
public extension UIButton {
    /// 设置标题图片对应的状态
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - state: 状态
    func axc_set(title: String? = nil, image: UIImage? = nil, state: UIControl.State = .normal) {
        setTitle(title, for: state)
        setImage(image, for: state)
    }
    
    /// 根据状态设置背景色
    /// - Parameters:
    ///   - color: 颜色
    ///   - forState: 状态
    func axc_setBackgroundColor(_ color: UIColor, state: UIControl.State) {
        self.clipsToBounds = true
        guard let image = color.axc_image else { return }
        setBackgroundImage(image, for: state)
    }
    
    /// 设置字号
    var axc_font: UIFont? {
        set { titleLabel?.font = newValue }
        get { return titleLabel?.font }
    }
    
    /// 内容边距
    var axc_contentInset: UIEdgeInsets {
        set { contentEdgeInsets = newValue }
        get { return contentEdgeInsets }
    }
    /// 按钮样式
    @available(*, deprecated, message: "此api不够完善，禁用")
    var axc_style: AxcButtonStyle {
        set {
            AxcRuntime.setObj(self, &kaxc_style, newValue)
            reloadStyle()
        }
        get {
            guard let style: AxcButtonStyle = AxcRuntime.getObj(self, &kaxc_style) else {
                let style = AxcButtonStyle.imgLeft_textRight
                self.axc_style = style
                return style
            }
            return style
        }
    }
    
    #warning("此api不够完善，禁用")
    /// 按钮样式布局
    @available(*, deprecated, message: "此api不够完善，禁用")
    private func reloadStyle() {
        // 设置展示样式
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        let imageSize = imageRect.size
        let titleSize = currentAttributedTitle?.size() ?? CGSize.zero
        let spacing: CGFloat = 0
        
        switch axc_style {
        case .imgTop_textBottom:    // 图上文下
            titleEdgeInsets = UIEdgeInsets(top: (imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: -imageRect.width/2, bottom: spacing / 2 + titleSize.height, right: -imageRect.width/2)
        
        case .textTop_imgBottom:    // 文上图下
            titleEdgeInsets = UIEdgeInsets(top: -(imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: spacing / 2 + titleSize.height, left: -imageRect.width/2, bottom: 0, right: -imageRect.width/2)
        
        case .imgLeft_textRight:    // 图左文右
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing / 2)
        
        case .textLeft_imgRight:    // 文左图右
            imageEdgeInsets = UIEdgeInsets(0, titleSize.width, 0, -titleSize.width)//设置图片位置
            titleEdgeInsets = UIEdgeInsets(0, -imageSize.width, 0, imageSize.width)//设置文字位置
        
        case .img:  // 全图片
            break
        
        case .text: // 全文字
        break
        }
    }
    
}

// MARK: - 重写父类方法
extension UIButton {
    // 点击
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let superPoint = super.point(inside: point, with: event)
        guard let touchInsets = axc_touchInsets else { return superPoint }
        var rect = bounds
        rect.axc_y += touchInsets.top;          // top
        rect.axc_height -= touchInsets.top;
        rect.axc_x += touchInsets.left;         // left
        rect.axc_width -= touchInsets.left;
        rect.axc_height -= touchInsets.bottom;  // bottom
        rect.axc_width -= touchInsets.right;    // right
        if rect.contains(point) { return true }
        return superPoint
    }
}
// MARK: 触发范围
private var kaxc_touchInsets = "kaxc_touchInsets"
public extension UIButton {
    /// 控制触发范围
    var axc_touchInsets: UIEdgeInsets? {
        set { AxcRuntime.setObj(self, &kaxc_touchInsets, newValue) }
        get {
            guard let touchInsets: UIEdgeInsets = AxcRuntime.getObj(self, &kaxc_touchInsets) else { return nil }
            return touchInsets
        }
    }
}

// MARK: - 决策判断
public extension UIButton {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension UIButton {
}

// MARK: - 运算符
public extension UIButton {
}
