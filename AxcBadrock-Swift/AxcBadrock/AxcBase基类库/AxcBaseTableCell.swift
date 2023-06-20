//
//  AxcBaseTableCell.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

// MARK: - AxcBaseTableCell
/// 基类AxcBaseTableCell
@IBDesignable
open class AxcBaseTableCell: UITableViewCell,
                        AxcBaseClassConfigProtocol,
                        AxcBaseClassMakeXibProtocol,
                        AxcGradientLayerProtocol {
    // MARK: - 初始化
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    // MARK: - 子类实现方法
    /// 配置 执行于makeUI()之前
    open func config() {
        selectionStyle = .none
    }
    /// 设置UI布局
    open func makeUI() { }
    /// 刷新UI布局
    open func reloadLayout() { }
    /// Xib加载显示前会调用，这里设置默认值用来显示Xib前的最后一道关卡
    open func makeXmlInterfaceBuilder() { }
    
    // MARK: - 父类重写
    /// 使本身layer为渐变色layer
    open override class var layerClass: AnyClass { return CAGradientLayer.self }
    /// 设置选中状态
    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    open lazy var axc_button: AxcButton = {
        let button = AxcButton()
        contentView.addSubview(button)
        return button
    }()
    
    // MARK: - 销毁
    deinit { AxcLog("\(AxcClassFromString(self))TableCell： \(self) 已销毁", level: .trace) }
}
