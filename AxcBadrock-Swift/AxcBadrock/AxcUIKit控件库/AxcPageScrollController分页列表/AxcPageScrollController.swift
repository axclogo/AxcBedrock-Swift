//
//  AxcPageScrollView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

// MARK: - 样式扩展带参枚举
public extension AxcPageScrollController {
    /// 样式设置
    enum Style {
        /// 普通样式
        case `default`
    }
}

// MARK: - AxcPageScrollController
/// 页面滑动带选中的PageScrollController
@IBDesignable
open class AxcPageScrollController: AxcBaseVC {
    // MARK: - 初始化
    public convenience init(_ vcs: [AxcPageItemVC]) {
        self.init()
        axc_setPages(vcs)
        reloadData()
    }
    // MARK: - Api
    // MARK: UI属性
    /// 设置样式
    open var axc_style: AxcPageScrollController.Style = .default { didSet { reloadLayout() } }
    
    /// 是否要支持纵横滑动 默认true
    open var axc_horizonVerticalScroll = true
    
    // MARK: 其他属性
    // MARK: 方法
    ///  设置Header
    open func axc_setHeader(_ view: UIView? = nil, height: CGFloat) {
        if let headerView = view {
            let contentView = UIView()
            contentView.axc_height = height
            contentView.addSubview(headerView)
            headerView.axc.remakeConstraints { (make) in make.edges.equalTo(0) }
            mainTableView.tableHeaderView = contentView
        }
        let headerView = mainTableView.tableHeaderView
        headerView?.axc_height = height
        mainTableView.tableHeaderView = headerView
    }
    
    /// 设置预设title
    open func axc_setSegmentedControlTitle(_ titles: [AxcTitleImageTuples], height: CGFloat) {
        isUsePresetTitle = true // 判定使用预设
        axc_segmentedTitleControl.axc_titleList = titles
        pageView.axc_setTitle(axc_segmentedTitleControl, height: height)
    }
    
    /// 设置自定义Title
    open func axc_setTitle(_ view: UIView? = nil, height: CGFloat) {
        pageView.axc_setTitle(view, height: height)
    }
    
    /// 设置页面组
    open func axc_setPages(_ vcList: [AxcPageItemVC]) {
        self.vcList = vcList
        pageView.axc_setPages( vcList )
        vcList.forEach{ // 设置关联性滑动
            addChild($0)    // 加入组
            $0.axc_didScrollBlock = { [weak self] (scorllView) in
                guard let weakSelf = self else { return }
                weakSelf.listScrollViewDidScroll(scrollView: scorllView)
            }
        }
    }
    
    /// 刷新
    open func reloadData() { mainTableView.reloadData() }
    
    // MARK: - 回调
    // MARK: Block回调
    /// page页面滑动的偏移
    open var axc_scrollOffset: ((_ pageScrollView: AxcPageScrollController,
                                   _ scrollView: UIScrollView) -> Void)?
    /// page页面滑动的偏移百分比
    open var axc_scrollIndex: ((_ pageScrollView: AxcPageScrollController,
                                  _ idxOffset: CGFloat) -> Void)?
    /// mainTableView开始滑动
    open var axc_scrollWillBeginDragging: ((_ pageScrollView: AxcPageScrollController,
                                              _ scrollView: UIScrollView) -> Void)?
    /// mainTableView滑动，用于实现导航栏渐变、头图缩放等
    open var axc_scrollDidScroll: ((_ pageScrollView: AxcPageScrollController,
                                      _ scrollView: UIScrollView,
                                      _ isMainCanScroll: Bool) -> Void)?
    /// mainTableView结束滑动
    open var axc_scrollDidEndDragging: ((_ pageScrollView: AxcPageScrollController,
                                           _ scrollView: UIScrollView,
                                           _ decelerate: Bool) -> Void)?
    /// mainTableView结束滑动
    open var axc_scrollEndDecelerating: ((_ pageScrollView: AxcPageScrollController,
                                            _ scrollView: UIScrollView) -> Void)?
    // MARK: func回调
    
    // MARK: - 私有
    /// 是否使用的预设title
    private var isUsePresetTitle : Bool = false
    /// 视图组
    private var vcList: [AxcPageItemVC] = []
    /// 是否滑到临界点
    private var isCriticalPoint : Bool = false
    /// mainTableView 是否可以滑动
    private var isMainCanScroll : Bool = true
    /// listScrollView 是否可以滑动
    private var isListCanScroll : Bool = false
    /// 当前滑动的listView
    private var currentListView = UIScrollView()
    /// 横向滑动触发关闭
    private func horizonScrollViewWillBeginScroll() {
        if !axc_horizonVerticalScroll { mainTableView.isScrollEnabled = false }
    }
    /// 滑动结束开启
    private func horizonScrollViewDidEndedScroll() {
        if !axc_horizonVerticalScroll { mainTableView.isScrollEnabled = true }
    }
    /// 刷新布局
    private func reloadLayout() {
        reloadStyle()
    }
    
    // MARK: 私有
    /// 刷新样式
    private func reloadStyle(){
        switch axc_style {
        case .default: break
        }
    }
    
    // MARK: - 父类重写
    open override func config() {
        
    }
    open override func makeUI() {// 设置主tableView
        view.addSubview(mainTableView)
        mainTableView.axc.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        reloadLayout()
    }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    open lazy var axc_segmentedTitleControl: AxcSegmentedControl = {
        let segmentedControl = AxcSegmentedControl()
        segmentedControl.axc_cornerRadius = 0
        segmentedControl.axc_borderWidth = 0
        segmentedControl.axc_borderColor = nil
        // 关联滑动
        segmentedControl.axc_segmentedActionBlock = { [weak self] (segmented,index) in
            guard let weakSelf = self else { return }
            weakSelf.pageView.axc_selectedIdx(index, animated: false)
        }
        return segmentedControl
    }()
    // MARK: 私有控件
    private lazy var pageView: AxcPageScrollView = {
        let view = AxcPageScrollView()
        view.backgroundColor = UIColor.clear
        view.axc_delegate = self
        view.isUserInteractionEnabled = true
        return view
    }()
    private lazy var mainTableView: AxcPageTableView = {
        let tableView = AxcPageTableView(delegate: self, dataSource: self,
                                         registers: [AxcRegisterStruct(AxcPageScrollCell.self, useNib: false )])
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = nil
        return tableView
    }()
}

// MARK: - 协议代理
// 需要实现手势穿透
class AxcPageTableView: UITableView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension AxcPageScrollController {
    // 次要子列表
    func listScrollViewDidScroll(scrollView: UIScrollView) {
        currentListView = scrollView
        let offsetY = scrollView.contentOffset.y // 获取listScrollView 的偏移量
        if offsetY <= 0 {   // listScrollView 下滑至offsetY 小于0，禁止其滑动，让mainTableView 可下滑
            isMainCanScroll = true
            isListCanScroll = false
            scrollView.contentOffset = .zero
            scrollView.showsVerticalScrollIndicator = false
        }else {
            if isListCanScroll {
                scrollView.showsVerticalScrollIndicator = false
                if mainTableView.contentOffset.y == 0 { // 如果此时mainTableView 并没有滑动，则禁止listView滑动
                    isMainCanScroll = true
                    isListCanScroll = false
                    scrollView.contentOffset = .zero
                    scrollView.showsHorizontalScrollIndicator = false
                }else{ // 矫正mainTableView 的位置
                    let criticalPoint = mainTableView.rect(forSection: 0).origin.y
                    mainTableView.contentOffset = CGPoint(x: 0, y: criticalPoint)
                }
            }else{
                scrollView.contentOffset = CGPoint.zero
            }
        }
    }
    // 主列表开始滑动
    func mainScrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y    // 获取mainScrollview 偏移量
        let criticalPoint = mainTableView.rect(forSection: 0).origin.y // 临界点
        isCriticalPoint = (offsetY >= criticalPoint) // 根据偏移量判断是否上滑到临界点
        if isCriticalPoint {   // 上滑到临界点后，固定其位置
            scrollView.contentOffset = CGPoint(x: 0, y: criticalPoint)
            isMainCanScroll = false
            isListCanScroll = true
        }else{      // 未到达临界点
            pageView.axc_getPages().forEach { (vc) in
                let listScrollView = vc.axc_listScrollView()
                if isMainCanScroll { // mainScrollview 可滑动，需要重置所有listScrollView 的位置
                    listScrollView.contentOffset = .zero
                    listScrollView.showsVerticalScrollIndicator = false
                }else{  // mainScrollview不可滑动
                    if listScrollView.contentOffset.y != 0 {
                        mainTableView.contentOffset = CGPoint(x: 0, y: criticalPoint)
                    }
                }
            }
        }
        axc_scrollDidScroll?(self, scrollView, isMainCanScroll)
    }
}

// MARK: - 页面横向滑动代理
extension AxcPageScrollController: AxcPageScrollViewDelegate {
    open func axc_pageScrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        horizonScrollViewWillBeginScroll()
    }
    open func axc_pageScrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        horizonScrollViewDidEndedScroll()
    }
    open func axc_pageScrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        horizonScrollViewDidEndedScroll()
    }
    open func axc_pageScrollViewDidScroll(_ scrollView: UIScrollView) {
        axc_scrollOffset?(self, scrollView)
        let idxOffset = scrollView.contentOffset.x / scrollView.axc_width
        axc_scrollIndex?(self, idxOffset)
        if isUsePresetTitle { // 使用了预设title
            axc_segmentedTitleControl.axc_selectedIdx = idxOffset.axc_int
        }
    }
}

// MARK: - 代理数据源
extension AxcPageScrollController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    // MARK: tableView代理数据源
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let original_cell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AxcPageScrollCell.axc_className) as? AxcPageScrollCell
        else { return original_cell }
        cell.pageView = pageView
        return cell
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.axc_height
    }
    // MARK: 滑动代理
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainScrollViewDidScroll(scrollView: scrollView)
    }
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        axc_scrollWillBeginDragging?(self, scrollView)
    }
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        axc_scrollDidEndDragging?(self, scrollView, decelerate)
    }
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        axc_scrollEndDecelerating?(self, scrollView)
    }
}

// MARK: - 内部类
private class AxcPageScrollCell: AxcBaseTableCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    // 内容视图
    var pageView: UIView? = nil {
        didSet {
            guard let pageView = pageView else { return }
            if !contentView.subviews.contains(pageView) { contentView.addSubview(pageView) }
            pageView.axc.remakeConstraints { (make) in make.edges.equalTo(0) }
        }
    }
}
