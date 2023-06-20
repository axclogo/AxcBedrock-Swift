//
//  AxcSegmentedControl.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/23.
//

import UIKit

// MARK: - 别名

// MARK: - 样式扩展带参枚举
public extension AxcSegmentedControl {
    /// 样式设置
    enum Style {
        /// 普通样式
        case `default`
        /// 指示器
        case indicator
    }
}

// MARK: - AxcSegmentedControl
/// Axc单选器
@IBDesignable
open class AxcSegmentedControl: AxcBaseView {
    // MARK: - 初始化
    public convenience init(_ dataList: [AxcTitleImageTuples],
                            selectedBlock: @escaping ((_ segmentedControl: AxcSegmentedControl,
                                                       _ index: Int) -> Void)) {
        self.init()
        axc_titleList = dataList
        createSelecteds()
        axc_segmentedActionBlock = selectedBlock
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 样式
    open var axc_style: AxcSegmentedControl.Style = .default {
        didSet { reloadLayout() }
    }
    
    /// 数据源
    open var axc_titleList: [AxcTitleImageTuples] = [] { didSet { createSelecteds() } }
    
    /// 设置内容间距
    open var axc_contentInset: UIEdgeInsets = .zero {
        didSet { layout.sectionInset = axc_contentInset
            reloadData(layout)
        }
    }
    
    /// 设置item最小间距
    open var axc_minSpacing: CGFloat = 0 {
        didSet { layout.minimumLineSpacing = axc_minSpacing
            reloadData(layout)
        }
    }
    
    /// 选中背景色
    open var axc_selectedBackgroundColor: UIColor = AxcBadrock.shared.themeColor { didSet { reloadData() } }
    
    /// 未选中背景色
    open var axc_nomalBackgroundColor: UIColor = UIColor.clear { didSet { reloadData() } }
    
    /// 选中字色
    open var axc_selectedTextColor: UIColor = AxcBadrock.shared.themeFillContentColor { didSet { reloadData() } }
    
    /// 未选中字色
    open var axc_nomalTextColor: UIColor = AxcBadrock.shared.themeColor { didSet { reloadData() } }
    
    // MARK: 其他属性
    /// 选中索引
    open var axc_selectedIdx: Int = 0 {
        didSet {
            guard selectedArray.count > axc_selectedIdx else { return }
            for idx in 0..<selectedArray.count { selectedArray[idx] = false }
            selectedArray[axc_selectedIdx] = true
            reloadData()
        }
    }
    // MARK: 指示器
    /// 指示器距离底部距离
    open var axc_indicatorBottomSpacing: CGFloat = 0
    /// 指示器宽度 默认item的1/3
    open var axc_indicatorWidth: CGFloat? = nil {
        didSet {
            guard let width = axc_indicatorWidth else { return }
            axc_indicator.axc_width = width
        }
    }
    /// 指示器高度 默认 2
    open var axc_indicatorHeight: CGFloat = 2 {
        didSet { axc_indicator.axc_height = axc_indicatorHeight }
    }
    /// 指示器圆角默认1
    open var axc_indicatorCornerRadius: CGFloat = 1 {
        didSet { axc_indicator.axc_cornerRadius = axc_indicatorCornerRadius }
    }
    /// 设置指示器滑动的百分比
    open var axc_indicatorRatio: CGFloat? = nil {
        didSet {
            guard let indicatorRatio = axc_indicatorRatio else { return }
            axc_indicator.axc_x = axc_width * indicatorRatio
        }
    }
    // MARK: 方法
    /// 刷新数据
    open func reloadData(_ layout: UICollectionViewFlowLayout? = nil) {
        if let _layout = layout {
            collectionView.setCollectionViewLayout(_layout, animated: true)
        }
        collectionView.reloadData()
    }
    
    // MARK: - 回调
    /// 样式设置
    open var axc_segmentedItemStyleBlock: ((_ segmentedControl: AxcSegmentedControl,
                                              _ button: AxcButton,
                                              _ index: Int) -> AxcButtonStyle)
        = { (_,btn,_) in
            return .text
        }
    /// 选中回调
    open var axc_segmentedActionBlock: ((_ segmentedControl: AxcSegmentedControl,
                                           _ index: Int) -> Void)
        = { (segmented,index) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(segmented)\nIndex:\(index)", level: .action)
        }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    open override func config() {
        backgroundColor = AxcBadrock.shared.backgroundColor
        axc_cornerRadius = 5
        axc_borderWidth = 0.5
        axc_borderColor = AxcBadrock.shared.lineColor
    }
    /// 设置UI
    open override func makeUI() {
        
        collectionView.axc.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        reloadLayout()
    }
    /// 刷新布局
    open override func reloadLayout() {
        let _axc_contentInset = axc_contentInset
        axc_contentInset = _axc_contentInset
        let _axc_minSpacing = axc_minSpacing
        axc_minSpacing = _axc_minSpacing
        
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新标题样式
    private func reloadStyle() {
        axc_indicator.isHidden = true
        switch axc_style {
        case .default:      // 普通一般
            break
        case .indicator:    // 指示器样式
            axc_indicator.isHidden = false
        }
    }
    
    // MARK: 超类&抽象类
    open override func layoutSubviews() {
        super.layoutSubviews()
        reloadData(layout)
    }
    
    // MARK: - 私有
    private var selectedArray: [Bool] = []
    private func createSelecteds() {
        for idx in 0..<axc_titleList.count { selectedArray.append(!idx.axc_bool) }
    }
    // MARK: - 懒加载
    // MARK: 预设控件
    /// 指示器
    open lazy var axc_indicator: AxcButton = {
        let button = AxcButton()
        button.isUserInteractionEnabled = false
        button.axc_style = .img
        button.axc_cornerRadius = axc_indicatorCornerRadius
        button.axc_contentInset = UIEdgeInsets.zero
        return button
    }()
    
    // MARK: 私有
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(layout: layout, delegate: self, dataSource: self,
                                              registers: [AxcRegisterStruct(AxcSegmentedItem.self, useNib: false )])
        collectionView.isScrollEnabled = false
        addSubview(collectionView)
        return collectionView
    }()
}

// MARK: - 代理&数据源
extension AxcSegmentedControl: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 回调
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        axc_selectedIdx = indexPath.row
        axc_segmentedActionBlock(self, indexPath.row)
    }
    // item大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = axc_titleList.count.axc_cgFloat
        let width = (collectionView.axc_width - layout.sectionInset.axc_horizontal - (layout.minimumLineSpacing * (count-1))) / count
        let height = (collectionView.axc_height - layout.sectionInset.axc_verticality)
        return CGSize(( width , height ))
    }
    // 数量
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return axc_titleList.count
    }
    // cell样式
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let original_cell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AxcClassFromString(AxcSegmentedItem.self), for: indexPath) as? AxcSegmentedItem
        else { return original_cell }
        let tuples = axc_titleList[indexPath.row]
        if let title = tuples.0 {
            cell.axc_button.axc_titleLabel.text = title
        }
        if let image = tuples.1 {
            cell.axc_button.axc_imageView.image = image
        }
        if let isSelected = selectedArray.axc_objAtIdx(indexPath.row) {
            cell.axc_button.backgroundColor = isSelected ? axc_selectedBackgroundColor : axc_nomalBackgroundColor
            cell.axc_button.axc_titleLabel.textColor = isSelected ? axc_selectedTextColor : axc_nomalTextColor
        }
        cell.axc_button.axc_style = axc_segmentedItemStyleBlock(self, cell.axc_button, indexPath.row)
        return cell
    }
}

// MARK: - cell
private class AxcSegmentedItem: AxcBaseCollectionCell {
    open override func makeUI() {
        backgroundColor = UIColor.clear
        axc_button.isUserInteractionEnabled = false // 禁止响应
        axc_button.axc.makeConstraints { (make) in make.edges.equalTo(0) }
    }
}
