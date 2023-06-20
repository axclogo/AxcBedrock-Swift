//
//  AxcBaseCollectionCell.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/24.
//

import UIKit

// MARK: - AxcBaseCollectionCell
/// 基类CollectionViewCell
@IBDesignable
open class AxcBaseCollectionCell: UICollectionViewCell,
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
    // Xib显示前
    open override func prepareForInterfaceBuilder() {
        makeXmlInterfaceBuilder()
    }
    
    // MARK: - 父类重写
    // 使本身layer为渐变色layer
    open override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    // MARK: - 子类实现
    /// 配置 执行于makeUI()之前
    open func config() { }
    /// 设置UI布局
    open func makeUI() { }
    /// 刷新UI布局
    open func reloadLayout() { }
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    open func makeXmlInterfaceBuilder() { }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    open lazy var axc_button: AxcButton = {
        let button = AxcButton()
        contentView.addSubview(button)
        return button
    }()
    
    // MARK: - 销毁
    deinit { AxcLog("\(AxcClassFromString(self))CollectionCell： \(self) 已销毁", level: .trace) }
}
