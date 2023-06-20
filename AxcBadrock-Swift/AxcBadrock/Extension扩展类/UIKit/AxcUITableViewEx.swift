//
//  AxcUITableViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 类方法/属性
public extension UITableView {
    /// 快速实例化
    /// - Parameters:
    ///   - frame: frame
    ///   - style: 样式
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    convenience init(frame: CGRect = CGRect.zero,
                     style: UITableView.Style = .plain,
                     delegate: UITableViewDelegate? = nil,
                     dataSource: UITableViewDataSource? = nil,
                     registers: [AxcRegisterStruct] = []) {
        self.init(frame: frame, style: style)
        self.delegate = delegate
        self.dataSource = dataSource
        backgroundColor = UIColor.clear
        tableFooterView = UIView()
        estimatedRowHeight = 0.01;
        estimatedSectionHeaderHeight = 0.01;
        estimatedSectionFooterHeight = 0.01;
        separatorStyle = .none;   //让tableview不显示分割线
        delaysContentTouches = false    // 关闭按钮延时
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never // 就算超出了安全边距，系统不会对你的scrollView做任何事情，即不作任何调整
        }
        let className = "UITableViewCell"
        register(AxcStringFromClass(className), forCellReuseIdentifier: className)
        axc_registers(registers)
    }
    /// 头视图注册ID
    class var axc_elementKindSectionHeader: String {
        return "UITableView_ElementKindSectionHeader"
    }
    /// 头视图注册ID
    var axc_elementKindSectionHeader: String {
        return Self.axc_elementKindSectionHeader
    }
    /// 尾视图注册ID
    class var axc_elementKindSectionFooter: String {
        return "UITableView_ElementKindSectionFooter"
    }
    /// 尾视图注册ID
    var axc_elementKindSectionFooter: String {
        return Self.axc_elementKindSectionFooter
    }
    
}

// MARK: - 属性 & Api
public extension UITableView {
    /// 设置头视图
    /// - Parameters:
    ///   - view: 视图
    ///   - height: 高度
    ///   - edge: 边距
    func axc_setTableHeaderView(_ view: UIView, height: CGFloat, inset: UIEdgeInsets = .zero) {
        let headerView = UIView(CGRect((0,0,axc_width,height)))
        headerView.addSubview(view)
        view.axc_remakeConstraintsInset(inset)
        tableHeaderView = headerView
    }
    /// 设置尾视图
    /// - Parameters:
    ///   - view: 视图
    ///   - height: 高度
    ///   - edge: 边距
    func axc_setTableFooterView(_ view: UIView, height: CGFloat, inset: UIEdgeInsets = .zero) {
        let footerView = UIView(CGRect((0,0,axc_width,height)))
        footerView.addSubview(view)
        view.axc_remakeConstraintsInset(inset)
        tableFooterView = footerView
    }
    
    /// 移除TableFooterView
    func axc_removeTableFooterView() {
        tableFooterView = nil
    }
    /// 刷新，重新赋值TableFooterView
    func axc_reloadTableFooterView() {
        let _tableFooterView = tableFooterView
        tableFooterView = _tableFooterView
    }
    
    /// 移除TableHeaderView
    func axc_removeTableHeaderView() {
        tableHeaderView = nil
    }
    /// 刷新，重新赋值TableHeaderView
    func axc_reloadTableHeaderView() {
        let _tableHeaderView = tableHeaderView
        tableHeaderView = _tableHeaderView
    }
    /// 注册一组视图
    func axc_registers(_ registers: [AxcRegisterStruct]) {
        registers.forEach{
            if $0.style == .cell { axc_registerCell($0) }
            else{ axc_registerHeaderFooter($0) }
        }
    }
    /// 注册一个cell
    func axc_registerCell(_ registerStruct: AxcRegisterStruct ) {
        guard registerStruct.style == .cell else { return }
        let type = "\(registerStruct.classType)"
        if registerStruct.useNib {   // 使用Nib加载
            register(UINib(nibName: type, bundle: nil), forCellReuseIdentifier: registerStruct.identifier)
        }else{
            register(registerStruct.classType, forCellReuseIdentifier: registerStruct.identifier)
        }
    }
    /// 注册一组cell
    func axc_registerCells(_ cells: [AxcRegisterStruct]) {
        for cell in cells { axc_registerCell(cell) }
    }
    
    /// 注册头尾视图
    /// - Parameter registerStruct: 注册结构体
    func axc_registerHeaderFooter(_ registerStruct: AxcRegisterStruct ) {
        guard registerStruct.style == .header || registerStruct.style == .footer
        else { return }
        let type = "\(registerStruct.classType)"
        if registerStruct.useNib {   // 使用Nib加载
            register(UINib(nibName: type, bundle: nil),
                     forHeaderFooterViewReuseIdentifier: registerStruct.identifier)
        }else{
            register(registerStruct.classType,
                     forHeaderFooterViewReuseIdentifier: registerStruct.identifier)
        }
    }
    
    /// 生成注册的HeaderFooter
    /// - Parameters:
    ///   - cell: HeaderFooterClass
    /// - Returns: HeaderFooter
    func axc_dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(_ identifier: String? = nil) -> T {
        let identifier = identifier ?? T.axc_className
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T
        else { AxcLog("获取注册的Header失败！\nIdentifier:\(identifier)", level: .fatal)
            return T()
        }
        return header
    }
    
    /// 生成注册的Cell
    /// - Parameters:
    ///   - cell: cellClass
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func axc_dequeueReusableCell<T: UITableViewCell>(_ identifier: String? = nil) -> T {
        let identifier = identifier ?? T.axc_className
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T
        else { AxcLog("获取注册的Cell失败！\nIdentifier:\(identifier)", level: .fatal)
            return T()
        }
        return cell
    }
    
    /// 刷新某一组
    /// - Parameters:
    ///   - section: 组索引
    ///   - animation: 动画模式
    func axc_reloadSection(section: Int, animation: RowAnimation) {
        let sections = self.numberOfSections
        if sections > section {
            let rang = Range(NSRange(location: section, length: 1))
            let set = IndexSet(integersIn: rang!)
            self.reloadSections(set, with: animation)
        }
    }
    
    /// 获取内容视图高度
    /// 但是对估算高度无法进行正确获取
    /// - Returns: CGFloat
    func axc_contentHeight() -> CGFloat {
        var listHeight: CGFloat = 0
        for section in 0..<numberOfSections {
            let headerHeight = delegate?.tableView?(self, heightForHeaderInSection: section)
            listHeight += headerHeight ?? 0
            for row in 0..<numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                let cellHeight = delegate?.tableView?(self, heightForRowAt: indexPath )
                listHeight += cellHeight ?? 0
            }
            let footerHeight = delegate?.tableView?(self, heightForFooterInSection: section)
            listHeight += footerHeight ?? 0
        }
        return listHeight
    }
}

// MARK: - 组动画协议
extension UITableView: AxcSubviewsAnimationProtocol {
    /// 返回所有需要动画的视图
    public func axc_animationViews(_ animation: CAAnimation) -> [UIView] {
        return visibleCells
    }
}

// MARK: - 代理数据源转Block
private var kaxc_tableDelegate = "kaxc_tableDelegate"
private var kaxc_dataSource = "kaxc_dataSource"
public extension UITableView {/// 返回UITableView,IndexPath,IndexPath的Block声明
    /// 返回UITableView,Int的Block声明
    typealias AxcIntBlock<T> = (UITableView,Int) -> T
    /// 返回UITableView的Block声明
    typealias AxcBlock<T> = (UITableView) -> T
    /// 返回UITableView,IndexPath的Block声明
    typealias AxcIndexPathBlock<T> = (UITableView,IndexPath) -> T
    /// 返回UITableView,String,Int的Block声明
    typealias AxcStringIntBlock<T> = (UITableView,String,Int) -> T
    /// 返回UITableView,UITableViewCell.EditingStyle,IndexPath的Block声明
    typealias AxcCellEditingStyleIndexPathBlock<T> = (UITableView,UITableViewCell.EditingStyle,IndexPath) -> T
    /// 返回UITableView,IndexPath,IndexPath的Block声明
    typealias AxcIndexPathIndexPathBlock<T> = (UITableView,IndexPath,IndexPath) -> T
    
    /// 数据源转Block桥接者
    var axc_dataSource: AxcTableDataSource {
        set { AxcRuntime.setObj(self, &kaxc_dataSource, newValue)
            self.dataSource = newValue
        }
        get { // runtime 懒加载
            guard let dataSource: AxcTableDataSource = AxcRuntime.getObj(self, &kaxc_dataSource) else {
                let dataSource = AxcTableDataSource()
                self.axc_dataSource = dataSource
                self.dataSource = dataSource
                return dataSource
            }
            self.dataSource = dataSource
            return dataSource
        }
    }
    /// 块设置数据源方法
    /// - Parameter block: block
    func axc_makeDataSource(_ block: (AxcTableDataSource) -> Void) {
        block(axc_dataSource)
    }
    
    /// 返回UITableView,UIContextMenuConfiguration,UIContextMenuInteractionCommitAnimating的Block声明
    @available(iOS 13.0, *)
    typealias AxcContextMenuConfigurationContextMenuInteractionCommitAnimatingBlock<T> = (UITableView,UIContextMenuConfiguration,UIContextMenuInteractionCommitAnimating) -> T
    /// 返回UITableView,UITableViewFocusUpdateContext,UIFocusAnimationCoordinator的Block声明
    typealias AxcFocusUpdateContextFocusAnimationCoordinatorBlock<T> = (UITableView,UITableViewFocusUpdateContext,UIFocusAnimationCoordinator) -> T
    /// 返回UITableView,UIView,Int的Block声明
    typealias AxcViewIntBlock<T> = (UITableView,UIView,Int) -> T
    /// 返回UITableView,IndexPath,UISpringLoadedInteractionContext的Block声明
    @available(iOS 11.0, *)
    typealias AxcIndexPathSpringLoadedInteractionContextBlock<T> = (UITableView,IndexPath,UISpringLoadedInteractionContext) -> T
    /// 返回UITableView,Selector,IndexPath,Any?的Block声明
    typealias AxcSelectorIndexPathAnyBlock<T> = (UITableView,Selector,IndexPath,Any?) -> T
    /// 返回UITableView,UITableViewCell,IndexPath的Block声明
    typealias AxcCellIndexPathBlock<T> = (UITableView,UITableViewCell,IndexPath) -> T
    /// 返回UITableView,UITableViewFocusUpdateContext的Block声明
    typealias AxcFocusUpdateContextBlock<T> = (UITableView,UITableViewFocusUpdateContext) -> T
    /// 返回UITableView,UIContextMenuConfiguration的Block声明
    @available(iOS 13.0, *)
    typealias AxcContextMenuConfigurationBlock<T> = (UITableView,UIContextMenuConfiguration) -> T
    /// 返回UITableView,UIContextMenuConfiguration,UIContextMenuInteractionAnimating?的Block声明
    @available(iOS 13.0, *)
    typealias AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<T> = (UITableView,UIContextMenuConfiguration,UIContextMenuInteractionAnimating?) -> T
    /// 返回UITableView,IndexPath,CGPoint的Block声明
    typealias AxcIndexPathPointBlock<T> = (UITableView,IndexPath,CGPoint) -> T
    
    /// 代理转Block桥接者
    var axc_tableDelegate: AxcTableDelegate {
        set { AxcRuntime.setObj(self, &kaxc_tableDelegate, newValue)
            delegate = newValue
        }
        get {
            guard let delegate: AxcTableDelegate = AxcRuntime.getObj(self, &kaxc_tableDelegate) else {
                let delegate = AxcTableDelegate()
                self.axc_tableDelegate = delegate
                self.delegate = delegate
                return delegate
            }
            self.delegate = delegate
            return delegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeTableDelegate(_ block: (AxcTableDelegate) -> Void) {
        block(axc_tableDelegate)
    }
}

// MARK: 数据源桥接者
/// 数据源转Block桥接者
open class AxcTableDataSource: NSObject, UITableViewDataSource {
    /// func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    @discardableResult
    open func axc_setTableViewNumberOfRowsInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<Int>) -> Self {
        axc_tableViewNumberOfRowsInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewNumberOfRowsInSectionBlock: UITableView.AxcIntBlock<Int>
        = { _,_ in return 0 }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return axc_tableViewNumberOfRowsInSectionBlock(tableView,section)
    }
    
    
    ///  Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    @discardableResult
    open func axc_setTableViewCellForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<UITableViewCell>) -> Self {
        axc_tableViewCellForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewCellForRowAtBlock: UITableView.AxcIndexPathBlock<UITableViewCell>
        = { _,_ in return UITableViewCell() }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return axc_tableViewCellForRowAtBlock(tableView,indexPath)
    }
    
    
    ///  Default is 1 if not implemented
    @discardableResult
    open func axc_setNumberOfSectionsInBlock(_ block: @escaping UITableView.AxcBlock<Int>) -> Self {
        axc_numberOfSectionsInBlock = block
        return self
    }
    open var axc_numberOfSectionsInBlock: UITableView.AxcBlock<Int>
        = { _ in return 1 }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return axc_numberOfSectionsInBlock(tableView)
    }
    
    
    ///  fixed font style. use custom view (UILabel) if you want something different
    @discardableResult
    open func axc_setTableViewTitleForHeaderInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<String?>) -> Self {
        axc_tableViewTitleForHeaderInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewTitleForHeaderInSectionBlock: UITableView.AxcIntBlock<String?>
        = { _,_ in return nil }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return axc_tableViewTitleForHeaderInSectionBlock(tableView,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    @discardableResult
    open func axc_setTableViewTitleForFooterInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<String?>) -> Self {
        axc_tableViewTitleForFooterInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewTitleForFooterInSectionBlock: UITableView.AxcIntBlock<String?>
        = { _,_ in return nil }
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return axc_tableViewTitleForFooterInSectionBlock(tableView,section)
    }
    
    
    ///  Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    @discardableResult
    open func axc_setTableViewCanEditRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Bool>) -> Self {
        axc_tableViewCanEditRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewCanEditRowAtBlock: UITableView.AxcIndexPathBlock<Bool>
        = { _,_ in return false }
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return axc_tableViewCanEditRowAtBlock(tableView,indexPath)
    }
    
    
    ///  Moving/reordering ; Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    @discardableResult
    open func axc_setTableViewCanMoveRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Bool>) -> Self {
        axc_tableViewCanMoveRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewCanMoveRowAtBlock: UITableView.AxcIndexPathBlock<Bool>
        = { _,_ in return false }
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return axc_tableViewCanMoveRowAtBlock(tableView,indexPath)
    }
    
    
    ///  return list of section titles to display in section index view (e.g. "ABCD...Z#")
    @discardableResult
    open func axc_setSectionIndexTitlesForBlock(_ block: @escaping UITableView.AxcBlock<[String]?>) -> Self {
        axc_sectionIndexTitlesForBlock = block
        return self
    }
    open var axc_sectionIndexTitlesForBlock: UITableView.AxcBlock<[String]?>
        = { _ in return nil }
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return axc_sectionIndexTitlesForBlock(tableView)
    }
    
    
    ///  tell table which section corresponds to section title/index (e.g. "B",1))
    @discardableResult
    open func axc_setTableViewSectionForSectionIndexTitleAtBlock(_ block: @escaping UITableView.AxcStringIntBlock<Int>) -> Self {
        axc_tableViewSectionForSectionIndexTitleAtBlock = block
        return self
    }
    open lazy var axc_tableViewSectionForSectionIndexTitleAtBlock: UITableView.AxcStringIntBlock<Int>
        = { _,_,_ in return 0 }
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return axc_tableViewSectionForSectionIndexTitleAtBlock(tableView,title,index)
    }
    
    
    ///  After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change; Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    @discardableResult
    open func axc_setTableViewCommitForRowAtBlock(_ block: @escaping UITableView.AxcCellEditingStyleIndexPathBlock<Void>) -> Self {
        axc_tableViewCommitForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewCommitForRowAtBlock: UITableView.AxcCellEditingStyleIndexPathBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) -> Void {
        axc_tableViewCommitForRowAtBlock(tableView,editingStyle,indexPath)
    }
    
    
    ///  Data manipulation - reorder / moving support
    @discardableResult
    open func axc_setTableViewMoveRowAtToBlock(_ block: @escaping UITableView.AxcIndexPathIndexPathBlock<Void>) -> Self {
        axc_tableViewMoveRowAtToBlock = block
        return self
    }
    open lazy var axc_tableViewMoveRowAtToBlock: UITableView.AxcIndexPathIndexPathBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) -> Void {
        axc_tableViewMoveRowAtToBlock(tableView,sourceIndexPath,destinationIndexPath)
    }
}

// MARK: 代理桥接者
open class AxcTableDelegate: AxcScrollDelegate, UITableViewDelegate {
    /// optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewWillDisplayForRowAtBlock(_ block: @escaping UITableView.AxcCellIndexPathBlock<Void>) -> Self {
        axc_tableViewWillDisplayForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewWillDisplayForRowAtBlock: UITableView.AxcCellIndexPathBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) -> Void {
        axc_tableViewWillDisplayForRowAtBlock(tableView,cell,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    @discardableResult
    open func axc_setTableViewWillDisplayHeaderViewForSectionBlock(_ block: @escaping UITableView.AxcViewIntBlock<Void>) -> Self {
        axc_tableViewWillDisplayHeaderViewForSectionBlock = block
        return self
    }
    open lazy var axc_tableViewWillDisplayHeaderViewForSectionBlock: UITableView.AxcViewIntBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) -> Void {
        axc_tableViewWillDisplayHeaderViewForSectionBlock(tableView,view,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    @discardableResult
    open func axc_setTableViewWillDisplayFooterViewForSectionBlock(_ block: @escaping UITableView.AxcViewIntBlock<Void>) -> Self {
        axc_tableViewWillDisplayFooterViewForSectionBlock = block
        return self
    }
    open lazy var axc_tableViewWillDisplayFooterViewForSectionBlock: UITableView.AxcViewIntBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) -> Void {
        axc_tableViewWillDisplayFooterViewForSectionBlock(tableView,view,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewDidEndDisplayingForRowAtBlock(_ block: @escaping UITableView.AxcCellIndexPathBlock<Void>) -> Self {
        axc_tableViewDidEndDisplayingForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewDidEndDisplayingForRowAtBlock: UITableView.AxcCellIndexPathBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) -> Void {
        axc_tableViewDidEndDisplayingForRowAtBlock(tableView,cell,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    @discardableResult
    open func axc_setTableViewDidEndDisplayingHeaderViewForSectionBlock(_ block: @escaping UITableView.AxcViewIntBlock<Void>) -> Self {
        axc_tableViewDidEndDisplayingHeaderViewForSectionBlock = block
        return self
    }
    open lazy var axc_tableViewDidEndDisplayingHeaderViewForSectionBlock: UITableView.AxcViewIntBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) -> Void {
        axc_tableViewDidEndDisplayingHeaderViewForSectionBlock(tableView,view,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    @discardableResult
    open func axc_setTableViewDidEndDisplayingFooterViewForSectionBlock(_ block: @escaping UITableView.AxcViewIntBlock<Void>) -> Self {
        axc_tableViewDidEndDisplayingFooterViewForSectionBlock = block
        return self
    }
    open lazy var axc_tableViewDidEndDisplayingFooterViewForSectionBlock: UITableView.AxcViewIntBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) -> Void {
        axc_tableViewDidEndDisplayingFooterViewForSectionBlock(tableView,view,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @discardableResult
    open func axc_setTableViewHeightForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<CGFloat>) -> Self {
        axc_tableViewHeightForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewHeightForRowAtBlock: UITableView.AxcIndexPathBlock<CGFloat>
        = { _,_ in return 44 }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return axc_tableViewHeightForRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @discardableResult
    open func axc_setTableViewHeightForHeaderInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<CGFloat>) -> Self {
        axc_tableViewHeightForHeaderInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewHeightForHeaderInSectionBlock: UITableView.AxcIntBlock<CGFloat>
        = { tableView,_ in return tableView.sectionHeaderHeight }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return axc_tableViewHeightForHeaderInSectionBlock(tableView,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    @discardableResult
    open func axc_setTableViewHeightForFooterInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<CGFloat>) -> Self {
        axc_tableViewHeightForFooterInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewHeightForFooterInSectionBlock: UITableView.AxcIntBlock<CGFloat>
        = { _,_ in return 0 }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return axc_tableViewHeightForFooterInSectionBlock(tableView,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    @discardableResult
    open func axc_setTableViewEstimatedHeightForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<CGFloat>) -> Self {
        axc_tableViewEstimatedHeightForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewEstimatedHeightForRowAtBlock: UITableView.AxcIndexPathBlock<CGFloat>
        = { tableView,_ in return tableView.estimatedRowHeight }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return axc_tableViewEstimatedHeightForRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    @discardableResult
    open func axc_setTableViewEstimatedHeightForHeaderInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<CGFloat>) -> Self {
        axc_tableViewEstimatedHeightForHeaderInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewEstimatedHeightForHeaderInSectionBlock: UITableView.AxcIntBlock<CGFloat>
        = { tableView,_ in return tableView.estimatedSectionHeaderHeight }
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return axc_tableViewEstimatedHeightForHeaderInSectionBlock(tableView,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    @discardableResult
    open func axc_setTableViewEstimatedHeightForFooterInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<CGFloat>) -> Self {
        axc_tableViewEstimatedHeightForFooterInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewEstimatedHeightForFooterInSectionBlock: UITableView.AxcIntBlock<CGFloat>
        = { tableView,_ in return tableView.estimatedSectionFooterHeight }
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return axc_tableViewEstimatedHeightForFooterInSectionBlock(tableView,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @discardableResult
    open func axc_setTableViewViewForHeaderInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<UIView?>) -> Self {
        axc_tableViewViewForHeaderInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewViewForHeaderInSectionBlock: UITableView.AxcIntBlock<UIView?>
        = { _,_ in return nil }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return axc_tableViewViewForHeaderInSectionBlock(tableView,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    @discardableResult
    open func axc_setTableViewViewForFooterInSectionBlock(_ block: @escaping UITableView.AxcIntBlock<UIView?>) -> Self {
        axc_tableViewViewForFooterInSectionBlock = block
        return self
    }
    open lazy var axc_tableViewViewForFooterInSectionBlock: UITableView.AxcIntBlock<UIView?>
        = { _,_ in return nil }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return axc_tableViewViewForFooterInSectionBlock(tableView,section)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewAccessoryButtonTappedForRowWithBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewAccessoryButtonTappedForRowWithBlock = block
        return self
    }
    open lazy var axc_tableViewAccessoryButtonTappedForRowWithBlock: UITableView.AxcIndexPathBlock<Void>
        = { _,_ in  }
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) -> Void {
        axc_tableViewAccessoryButtonTappedForRowWithBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    @discardableResult
    open func axc_setTableViewShouldHighlightRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Bool>) -> Self {
        axc_tableViewShouldHighlightRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewShouldHighlightRowAtBlock: UITableView.AxcIndexPathBlock<Bool>
        = { _,_ in return true }
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return axc_tableViewShouldHighlightRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewDidHighlightRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewDidHighlightRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewDidHighlightRowAtBlock: UITableView.AxcIndexPathBlock<Void>
        = { _,_ in  }
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> Void {
        axc_tableViewDidHighlightRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewDidUnhighlightRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewDidUnhighlightRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewDidUnhighlightRowAtBlock: UITableView.AxcIndexPathBlock<Void>
        = { _,_ in  }
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) -> Void {
        axc_tableViewDidUnhighlightRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    @discardableResult
    open func axc_setTableViewWillSelectRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<IndexPath?>) -> Self {
        axc_tableViewWillSelectRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewWillSelectRowAtBlock: UITableView.AxcIndexPathBlock<IndexPath?>
        = { _,indexPath in return indexPath }
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return axc_tableViewWillSelectRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    @discardableResult
    open func axc_setTableViewWillDeselectRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<IndexPath?>) -> Self {
        axc_tableViewWillDeselectRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewWillDeselectRowAtBlock: UITableView.AxcIndexPathBlock<IndexPath?>
        = { _,indexPath in return indexPath }
    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return axc_tableViewWillDeselectRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewDidSelectRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewDidSelectRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewDidSelectRowAtBlock: UITableView.AxcIndexPathBlock<Void>
        = { tableView,indexPath in tableView.deselectRow(at: indexPath, animated: true) }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        axc_tableViewDidSelectRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewDidDeselectRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewDidDeselectRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewDidDeselectRowAtBlock: UITableView.AxcIndexPathBlock<Void>
        = { _,_ in  }
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) -> Void {
        axc_tableViewDidDeselectRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    @discardableResult
    open func axc_setTableViewEditingStyleForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<UITableViewCell.EditingStyle>) -> Self {
        axc_tableViewEditingStyleForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewEditingStyleForRowAtBlock: UITableView.AxcIndexPathBlock<UITableViewCell.EditingStyle>
        = { _,_ in return .none }
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return axc_tableViewEditingStyleForRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    @discardableResult
    open func axc_setTableViewTitleForDeleteConfirmationButtonForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<String?>) -> Self {
        axc_tableViewTitleForDeleteConfirmationButtonForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewTitleForDeleteConfirmationButtonForRowAtBlock: UITableView.AxcIndexPathBlock<String?>
        = { _,_ in return nil }
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return axc_tableViewTitleForDeleteConfirmationButtonForRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    @discardableResult
    open func axc_setTableViewEditActionsForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<[UITableViewRowAction]?>) -> Self {
        axc_tableViewEditActionsForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewEditActionsForRowAtBlock: UITableView.AxcIndexPathBlock<[UITableViewRowAction]?>
        = { _,_ in return nil }
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return axc_tableViewEditActionsForRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    @available(iOS 11.0, *)
//    @discardableResult
//    open func axc_setTableViewLeadingSwipeActionsConfigurationForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<UISwipeActionsConfiguration?>) -> Self {
//        axc_tableViewLeadingSwipeActionsConfigurationForRowAtBlock = block
//        return self
//    }
//    open lazy var axc_tableViewLeadingSwipeActionsConfigurationForRowAtBlock: UITableView.AxcIndexPathBlock<UISwipeActionsConfiguration?>
//        = { _,_ in return nil }
//    @available(iOS 11.0, *)
//    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        return axc_tableViewLeadingSwipeActionsConfigurationForRowAtBlock(tableView,indexPath)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    @available(iOS 11.0, *)
//    @discardableResult
//    open func axc_setTableViewTrailingSwipeActionsConfigurationForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<UISwipeActionsConfiguration?>) -> Self {
//        axc_tableViewTrailingSwipeActionsConfigurationForRowAtBlock = block
//        return self
//    }
//    open lazy var axc_tableViewTrailingSwipeActionsConfigurationForRowAtBlock: UITableView.AxcIndexPathBlock<UISwipeActionsConfiguration?>
//        = { _,_ in return nil }
//    @available(iOS 11.0, *)
//    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        return axc_tableViewTrailingSwipeActionsConfigurationForRowAtBlock(tableView,indexPath)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    @discardableResult
    open func axc_setTableViewShouldIndentWhileEditingRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Bool>) -> Self {
        axc_tableViewShouldIndentWhileEditingRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewShouldIndentWhileEditingRowAtBlock: UITableView.AxcIndexPathBlock<Bool>
        = { _,_ in return false }
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return axc_tableViewShouldIndentWhileEditingRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    @discardableResult
    open func axc_setTableViewWillBeginEditingRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewWillBeginEditingRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewWillBeginEditingRowAtBlock: UITableView.AxcIndexPathBlock<Void>
        = { _,_ in  }
    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) -> Void {
        axc_tableViewWillBeginEditingRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    @discardableResult
    open func axc_setTableViewDidEndEditingRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewDidEndEditingRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewDidEndEditingRowAtBlock: UITableView.AxcIndexPathBlock<Void>
        = { _,_ in  }
    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) -> Void {
        axc_tableViewDidEndEditingRowAtBlock(tableView,indexPath ?? 0.axc_row)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    @discardableResult
    open func axc_setTableViewTargetIndexPathForMoveFromRowAtToProposedIndexPathBlock(_ block: @escaping UITableView.AxcIndexPathIndexPathBlock<IndexPath>) -> Self {
        axc_tableViewTargetIndexPathForMoveFromRowAtToProposedIndexPathBlock = block
        return self
    }
    open lazy var axc_tableViewTargetIndexPathForMoveFromRowAtToProposedIndexPathBlock: UITableView.AxcIndexPathIndexPathBlock<IndexPath>
        = { _,_,_ in return 0.axc_row }
    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return axc_tableViewTargetIndexPathForMoveFromRowAtToProposedIndexPathBlock(tableView,sourceIndexPath,proposedDestinationIndexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
    @discardableResult
    open func axc_setTableViewIndentationLevelForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Int>) -> Self {
        axc_tableViewIndentationLevelForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewIndentationLevelForRowAtBlock: UITableView.AxcIndexPathBlock<Int>
        = { _,_ in return 0 }
    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return axc_tableViewIndentationLevelForRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    @discardableResult
    open func axc_setTableViewShouldShowMenuForRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Bool>) -> Self {
        axc_tableViewShouldShowMenuForRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewShouldShowMenuForRowAtBlock: UITableView.AxcIndexPathBlock<Bool>
        = { _,_ in return true }
    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return axc_tableViewShouldShowMenuForRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    @discardableResult
    open func axc_setTableViewCanPerformActionForRowAtWithSenderBlock(_ block: @escaping UITableView.AxcSelectorIndexPathAnyBlock<Bool>) -> Self {
        axc_tableViewCanPerformActionForRowAtWithSenderBlock = block
        return self
    }
    open lazy var axc_tableViewCanPerformActionForRowAtWithSenderBlock: UITableView.AxcSelectorIndexPathAnyBlock<Bool>
        = { _,_,_,_ in return false }
    public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return axc_tableViewCanPerformActionForRowAtWithSenderBlock(tableView,action,indexPath,sender)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
    @discardableResult
    open func axc_setTableViewPerformActionForRowAtWithSenderBlock(_ block: @escaping UITableView.AxcSelectorIndexPathAnyBlock<Void>) -> Self {
        axc_tableViewPerformActionForRowAtWithSenderBlock = block
        return self
    }
    open lazy var axc_tableViewPerformActionForRowAtWithSenderBlock: UITableView.AxcSelectorIndexPathAnyBlock<Void>
        = { _,_,_,_ in  }
    public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Void {
        axc_tableViewPerformActionForRowAtWithSenderBlock(tableView,action,indexPath,sender)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
    @discardableResult
    open func axc_setTableViewCanFocusRowAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Bool>) -> Self {
        axc_tableViewCanFocusRowAtBlock = block
        return self
    }
    open lazy var axc_tableViewCanFocusRowAtBlock: UITableView.AxcIndexPathBlock<Bool>
        = { _,_ in return true }
    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return axc_tableViewCanFocusRowAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
    @discardableResult
    open func axc_setTableViewShouldUpdateFocusInBlock(_ block: @escaping UITableView.AxcFocusUpdateContextBlock<Bool>) -> Self {
        axc_tableViewShouldUpdateFocusInBlock = block
        return self
    }
    open lazy var axc_tableViewShouldUpdateFocusInBlock: UITableView.AxcFocusUpdateContextBlock<Bool>
        = { _,_ in return true }
    public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        return axc_tableViewShouldUpdateFocusInBlock(tableView,context)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    @discardableResult
    open func axc_setTableViewDidUpdateFocusInWithBlock(_ block: @escaping UITableView.AxcFocusUpdateContextFocusAnimationCoordinatorBlock<Void>) -> Self {
        axc_tableViewDidUpdateFocusInWithBlock = block
        return self
    }
    open lazy var axc_tableViewDidUpdateFocusInWithBlock: UITableView.AxcFocusUpdateContextFocusAnimationCoordinatorBlock<Void>
        = { _,_,_ in  }
    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) -> Void {
        axc_tableViewDidUpdateFocusInWithBlock(tableView,context,coordinator)
    }
    
    
    /// optional func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
    @discardableResult
    open func axc_setIndexPathForPreferredFocusedViewInBlock(_ block: @escaping UITableView.AxcBlock<IndexPath?>) -> Self {
        axc_indexPathForPreferredFocusedViewInBlock = block
        return self
    }
    open lazy var axc_indexPathForPreferredFocusedViewInBlock: UITableView.AxcBlock<IndexPath?>
        = { _ in return nil }
    public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return axc_indexPathForPreferredFocusedViewInBlock(tableView)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
//    @available(iOS 11.0, *)
//    @discardableResult
//    open func axc_setTableViewShouldSpringLoadRowAtWithBlock(_ block: @escaping UITableView.AxcIndexPathSpringLoadedInteractionContextBlock<Bool>) -> Self {
//        axc_tableViewShouldSpringLoadRowAtWithBlock = block
//        return self
//    }
//    open lazy var axc_tableViewShouldSpringLoadRowAtWithBlock: UITableView.AxcIndexPathSpringLoadedInteractionContextBlock<Bool>
//        = { _,_,_ in return true }
//    @available(iOS 11.0, *)
//    public func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
//        return axc_tableViewShouldSpringLoadRowAtWithBlock(tableView,indexPath,context)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool
    /// 是否允许多指选中
    @available(iOS 13.0, *)
    @discardableResult
    open func axc_setTableViewShouldBeginMultipleSelectionInteractionAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Bool>) -> Self {
        axc_tableViewShouldBeginMultipleSelectionInteractionAtBlock = block
        return self
    }
    open lazy var axc_tableViewShouldBeginMultipleSelectionInteractionAtBlock: UITableView.AxcIndexPathBlock<Bool>
        = { _,_ in return true }
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return axc_tableViewShouldBeginMultipleSelectionInteractionAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath)
    ///多指选中开始，这里可以做一些UI修改，比如修改导航栏上按钮的文本
    @available(iOS 13.0, *)
    @discardableResult
    open func axc_setTableViewDidBeginMultipleSelectionInteractionAtBlock(_ block: @escaping UITableView.AxcIndexPathBlock<Void>) -> Self {
        axc_tableViewDidBeginMultipleSelectionInteractionAtBlock = block
        return self
    }
    open lazy var axc_tableViewDidBeginMultipleSelectionInteractionAtBlock: UITableView.AxcIndexPathBlock<Void>
        = { _,_ in  }
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Void {
        axc_tableViewDidBeginMultipleSelectionInteractionAtBlock(tableView,indexPath)
    }
    
    
    /// optional func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView)
    @available(iOS 13.0, *)
    @discardableResult
    open func axc_setTableViewDidEndMultipleSelectionInteractionBlock(_ block: @escaping UITableView.AxcBlock<Void>) -> Self {
        axc_tableViewDidEndMultipleSelectionInteractionBlock = block
        return self
    }
    open lazy var axc_tableViewDidEndMultipleSelectionInteractionBlock: UITableView.AxcBlock<Void>
        = { _ in  }
    @available(iOS 13.0, *)
    public func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) -> Void {
        axc_tableViewDidEndMultipleSelectionInteractionBlock(tableView)
    }
    
    
    /// optional func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setTableViewContextMenuConfigurationForRowAtPointBlock(_ block: @escaping UITableView.AxcIndexPathPointBlock<UIContextMenuConfiguration?>) -> Self {
//        axc_tableViewContextMenuConfigurationForRowAtPointBlock = block
//        return self
//    }
//    open lazy var axc_tableViewContextMenuConfigurationForRowAtPointBlock: UITableView.AxcIndexPathPointBlock<UIContextMenuConfiguration?>
//        = { _,_,_ in return nil }
//    @available(iOS 13.0, *)
//    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        return axc_tableViewContextMenuConfigurationForRowAtPointBlock(tableView,indexPath,point)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setTableViewPreviewForHighlightingContextMenuWithConfigurationBlock(_ block: @escaping UITableView.AxcContextMenuConfigurationBlock<UITargetedPreview?>) -> Self {
//        axc_tableViewPreviewForHighlightingContextMenuWithConfigurationBlock = block
//        return self
//    }
//    open lazy var axc_tableViewPreviewForHighlightingContextMenuWithConfigurationBlock: UITableView.AxcContextMenuConfigurationBlock<UITargetedPreview?>
//        = { _,_ in return nil }
//    @available(iOS 13.0, *)
//    public func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//        return axc_tableViewPreviewForHighlightingContextMenuWithConfigurationBlock(tableView,configuration)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setTableViewPreviewForDismissingContextMenuWithConfigurationBlock(_ block: @escaping UITableView.AxcContextMenuConfigurationBlock<UITargetedPreview?>) -> Self {
//        axc_tableViewPreviewForDismissingContextMenuWithConfigurationBlock = block
//        return self
//    }
//    open lazy var axc_tableViewPreviewForDismissingContextMenuWithConfigurationBlock: UITableView.AxcContextMenuConfigurationBlock<UITargetedPreview?>
//        = { _,_ in return nil }
//    @available(iOS 13.0, *)
//    public func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//        return axc_tableViewPreviewForDismissingContextMenuWithConfigurationBlock(tableView,configuration)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setTableViewWillPerformPreviewActionForMenuWithAnimatorBlock(_ block: @escaping UITableView.AxcContextMenuConfigurationContextMenuInteractionCommitAnimatingBlock<Void>) -> Self {
//        axc_tableViewWillPerformPreviewActionForMenuWithAnimatorBlock = block
//        return self
//    }
//    open lazy var axc_tableViewWillPerformPreviewActionForMenuWithAnimatorBlock: UITableView.AxcContextMenuConfigurationContextMenuInteractionCommitAnimatingBlock<Void>
//        = { _,_,_ in  }
//    @available(iOS 13.0, *)
//    public func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) -> Void {
//        axc_tableViewWillPerformPreviewActionForMenuWithAnimatorBlock(tableView,configuration,animator)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?)
//    @available(iOS 14.0, *)
//    @discardableResult
//    open func axc_setTableViewWillDisplayContextMenuAnimatorBlock(_ block: @escaping UITableView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>) -> Self {
//        axc_tableViewWillDisplayContextMenuAnimatorBlock = block
//        return self
//    }
//    open lazy var axc_tableViewWillDisplayContextMenuAnimatorBlock: UITableView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>
//        = { _,_,_ in  }
//    @available(iOS 14.0, *)
//    public func tableView(_ tableView: UITableView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) -> Void {
//        axc_tableViewWillDisplayContextMenuAnimatorBlock(tableView,configuration,animator)
//    }
    
    
    /// optional func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?)
//    @available(iOS 14.0, *)
//    @discardableResult
//    open func axc_setTableViewWillEndContextMenuInteractionAnimatorBlock(_ block: @escaping UITableView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>) -> Self {
//        axc_tableViewWillEndContextMenuInteractionAnimatorBlock = block
//        return self
//    }
//    open lazy var axc_tableViewWillEndContextMenuInteractionAnimatorBlock: UITableView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>
//        = { _,_,_ in  }
//    @available(iOS 14.0, *)
//    public func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) -> Void {
//        axc_tableViewWillEndContextMenuInteractionAnimatorBlock(tableView,configuration,animator)
//    }
}
