//
//  AxcContentScrollView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/8.
//

import UIKit

// MARK: - AxcProtocolControl
/// Axc内容滚动器
@IBDesignable
open class AxcContentScrollView: AxcBaseView,
                                   AxcLeftRightBtnProtocol {
    // MARK: - Api
    // MARK: UI属性
    /// 起始点，结束点默认对应关系，
    open var axc_startPoint: AxcDirection = .right { didSet { configScrollView() } }
    
    /// 滚动速度，默认1 取值 0-1
    open var axc_speed: CGFloat = 1 { didSet { configDispalyLink() } }
    
    /// 两个内容之间的间距
    open var axc_contentSpacing: CGFloat = 10 { didSet { configScrollView() } }
    
    /// 内容边距
    open var axc_contentInset: UIEdgeInsets = .zero { didSet { reloadLayout() } }
    
    /// 左按钮宽度
    open var axc_leftBtnWidth: CGFloat = 0 { didSet { reloadLayout() } }
    
    /// 右按钮宽度
    open var axc_rightBtnWidth: CGFloat = 0 { didSet { reloadLayout() } }
    
    // MARK: 方法
    /// 开始滚动
    open func axc_start() {
        axc_stop()
        dispalyLink = CADisplayLink.init(target: self, selector: #selector(running))
        configDispalyLink()
        dispalyLink?.add(to: .main, forMode: .common)
    }
    /// 停止滚动
    open func axc_stop() {
        dispalyLink?.invalidate()
        dispalyLink = nil
    }
    /// 刷新数据
    func axc_reloadData() {
        configScrollView()
    }
    
    // MARK: 回调
    /// 返回需要滚动的内容数量
    open var axc_contentScrollNumberBlock: ((_ contentScrollView: AxcContentScrollView) -> Int)
        = { _ in return 1 }
    /// 返回需要滚动的内容视图
    open var axc_contentScrollViewBlock: ((_ contentScrollView: AxcContentScrollView, _ index: Int) -> UIView)
        = { _,_ in return UIView() }
    /// 返回需要滚动的内容视图大小
    open var axc_contentScrollViewSizeBlock: ((_ contentScrollView: AxcContentScrollView, _ index: Int) -> CGSize)
        = { _,_ in return CGSize.zero }
    
    // MARK: 私有
    /// 划帧计时器
    private var dispalyLink: CADisplayLink?
    /// 单帧滚动的像素
    private var pointsPerFrame: CGFloat = 0.5
    /// 帧每秒
    private var framesPerSecond: Int { return 30 }
    /// 配置计时器
    private func configDispalyLink() {
        if #available(iOS 10.0, *) {
            dispalyLink?.preferredFramesPerSecond = framesPerSecond
        } else {
            dispalyLink?.frameInterval = framesPerSecond
        }
    }
    /// 配置滚动视图
    private func configScrollView() {
        scrollView.layer.removeAllAnimations()
        scrollView.axc_removeAllSubviews()
        var tmpItem = UIView()
        let coutentNum = axc_contentScrollNumberBlock(self)
        for idx in 0..<coutentNum {
            let itemView = axc_contentScrollViewBlock(self, idx)
            var itemFrame: CGRect = CGRect.zero
            let itemSize = axc_contentScrollViewSizeBlock(self, idx)
            if axc_startPoint == .right || axc_startPoint == .left {
                itemFrame = CGRect(x: tmpItem.axc_right + axc_contentSpacing, y: 0,
                                   width: itemSize.width, height: itemSize.height)
            } else if axc_startPoint == .bottom || axc_startPoint == .top {
                itemFrame = CGRect(x: 0, y: tmpItem.axc_bottom + axc_contentSpacing,
                                   width: itemSize.width, height: itemSize.height)
            }
            itemView.frame = itemFrame
            scrollView.addSubview(itemView)
            tmpItem = itemView // 保存指向上一个视图
        }
        var scrollRect = CGRect.zero
        if axc_startPoint == .right || axc_startPoint == .left {
            scrollView.contentSize = CGSize(width: tmpItem.axc_x + tmpItem.axc_width, height: 0);
            if axc_startPoint == .left {
                scrollRect = CGRect(x: -scrollView.contentSize.width, y: 0,
                                    width: scrollView.contentSize.width, height: tmpItem.axc_height)
            } else {
                scrollRect = CGRect(x: axc_width, y: 0,
                                    width: axc_width + scrollView.contentSize.width, height: tmpItem.axc_height)
            }
        } else if axc_startPoint == .bottom || axc_startPoint == .top {
            scrollView.contentSize = CGSize(width: 0, height: tmpItem.axc_y + tmpItem.axc_height);
            if axc_startPoint == .top {
                scrollRect = CGRect(x: 0, y: -scrollView.contentSize.height,
                                    width: axc_width, height: scrollView.contentSize.height)
            } else {
                scrollRect = CGRect(x: 0, y: axc_height,
                                    width: axc_width, height: scrollView.contentSize.height)
            }
        }
        configScrollViewRect(scrollRect)
    }
    /// 计时器运行
    @objc private func running() {
        var rect = scrollView.frame
        if axc_startPoint == .right {
            rect.origin.x -= pointsPerFrame
            if rect.origin.x <= -scrollView.contentSize.width {
                rect.origin.x = axc_width
            }
        } else if axc_startPoint == .left {
            rect.origin.x += pointsPerFrame
            if rect.origin.x >= axc_width {
                rect.origin.x = -scrollView.contentSize.width
            }
        } else if axc_startPoint == .top {
            rect.origin.y += pointsPerFrame
            if rect.origin.y >= axc_height {
                rect.origin.y = -scrollView.contentSize.height
            }
        } else if axc_startPoint == .bottom {
            rect.origin.y -= pointsPerFrame
            if rect.origin.y <= -scrollView.contentSize.height {
                rect.origin.y = axc_height
            }
        }
        configScrollViewRect(rect)
    }
    /// 配置滚动视图frame
    private func configScrollViewRect(_ rect: CGRect) {
        scrollView.axc_remakeConstraintsFrame(rect)
    }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    open override func config() {
        clipsToBounds = true
    }
    /// 设置UI
    open override func makeUI() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        reloadLayout()
    }
    /// 刷新布局
    open override func reloadLayout() {
        axc_contentView.axc.remakeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
        if axc_leftBtnWidth > 0 {
            axc_leftButton.axc.remakeConstraints { (make) in
                make.top.bottom.left.equalToSuperview()
                make.width.equalTo(axc_leftBtnWidth)
            }
        }
        if axc_rightBtnWidth > 0 {
            axc_rightButton.axc.remakeConstraints { (make) in
                make.top.bottom.left.equalToSuperview()
                make.width.equalTo(axc_rightBtnWidth)
            }
        }
        scrollView.axc.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(axc_leftBtnWidth)
            make.right.equalTo(axc_rightBtnWidth)
        }
    }
    /// 解决当父View释放时，当前视图因为被计时器强引用而不能释放的问题
    open override func removeSelf() {
        axc_stop()  // 停止计时器
    }
    
    // MARK: 超类&抽象类
    /// 布局
    open override func layoutSubviews() {
        super.layoutSubviews()
        axc_reloadData()
    }
    
    // MARK: - 懒加载
    // MARK: 基础控件
    /// 外部约束视图
    open lazy var axc_contentView: AxcBaseView = {
        let view = AxcBaseView()
        view.backgroundColor = UIColor.clear
        addSubview(view)
        return view
    }()
    // MARK: 协议控件
    open func axc_settingBtn(direction: AxcDirection) -> AxcButton {
        let button = AxcButton()
        button.backgroundColor = UIColor.clear
        button.axc_titleLabel.font = UIFont.systemFont(ofSize: 12)
        button.axc_titleLabel.textColor = AxcBadrock.shared.themeFillContentColor
        button.axc_contentInset = UIEdgeInsets.zero
        axc_contentView.addSubview(button)
        return button
    }
    // MARK: 私有控件
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        axc_contentView.addSubview(scrollView)
        return scrollView
    }()
}
