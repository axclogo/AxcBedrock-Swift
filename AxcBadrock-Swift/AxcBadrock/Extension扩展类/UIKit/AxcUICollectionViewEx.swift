//
//  AxcUICollectionViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 类方法/属性
public extension UICollectionView {
    /// 设置一个collectionView
    /// - Parameters:
    ///   - frame: frame
    ///   - layout: 布局
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    convenience init(frame: CGRect = CGRect.zero,
                     layout: UICollectionViewFlowLayout? = nil,
                     delegate: UICollectionViewDelegate? = nil,
                     dataSource: UICollectionViewDataSource? = nil,
                     registers: [AxcRegisterStruct] = []) {
        var flowLayout = UICollectionViewFlowLayout()
        if let _layout = layout { flowLayout = _layout }
        self.init(frame: frame, collectionViewLayout: flowLayout)
        self.delegate = delegate
        self.dataSource = dataSource
        backgroundColor = UIColor.clear
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        delaysContentTouches = false    // 关闭按钮延时
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never // 就算超出了安全边距，系统不会对你的scrollView做任何事情，即不作任何调整
        }
        // 默认注册系统
        let className = "UICollectionViewCell"
        register(AxcStringFromClass(className), forCellWithReuseIdentifier: className)
        axc_registers(registers)
    }
    /// 头视图注册ID
    class var axc_elementKindSectionHeader: String {
        return elementKindSectionHeader
    }
    /// 头视图注册ID
    var axc_elementKindSectionHeader: String {
        return Self.axc_elementKindSectionHeader
    }
    /// 尾视图注册ID
    class var axc_elementKindSectionFooter: String {
        return elementKindSectionFooter
    }
    /// 尾视图注册ID
    var axc_elementKindSectionFooter: String {
        return Self.axc_elementKindSectionFooter
    }
}


// MARK: - 属性 & Api
public extension UICollectionView {
    /// 注册一组视图
    func axc_registers(_ registers: [AxcRegisterStruct]) {
        registers.forEach{
            switch $0.style {
            case .cell:     axc_registerCell($0)
            case .header:   axc_registerHeader($0)
            case .footer:   axc_registerFooter($0)
            }
        }
    }
    /// 注册一组cell
    func axc_registerCells(_ cells: [AxcRegisterStruct]) {
        for cell in cells { axc_registerCell(cell) }
    }
    /// 注册一个cell
    func axc_registerCell(_ registerStruct: AxcRegisterStruct ) {
        guard registerStruct.style == .cell else { return }
        let type = "\(registerStruct.classType)"
        if registerStruct.useNib {   // 使用Nib加载
            register(UINib(nibName: type, bundle: nil), forCellWithReuseIdentifier: registerStruct.identifier)
        }else{
            register(registerStruct.classType, forCellWithReuseIdentifier: registerStruct.identifier)
        }
    }
    
    /// 注册头部视图
    /// - Parameter registerStruct: 注册结构体
    func axc_registerHeader(_ registerStruct: AxcRegisterStruct ) {
        guard registerStruct.style == .header else { return }
        let type = "\(registerStruct.classType)"
        if registerStruct.useNib {   // 使用Nib加载
            register(UINib(nibName: type, bundle: nil),
                     forSupplementaryViewOfKind: axc_elementKindSectionHeader,
                     withReuseIdentifier: registerStruct.identifier)
        }else{
            register(registerStruct.classType,
                     forSupplementaryViewOfKind: axc_elementKindSectionHeader,
                     withReuseIdentifier: registerStruct.identifier)
        }
    }
    /// 注册尾部视图
    /// - Parameter registerStruct: 注册结构体
    func axc_registerFooter(_ registerStruct: AxcRegisterStruct ) {
        guard registerStruct.style == .footer else { return }
        let type = "\(registerStruct.classType)"
        if registerStruct.useNib {   // 使用Nib加载
            register(UINib(nibName: type, bundle: nil),
                     forSupplementaryViewOfKind: axc_elementKindSectionFooter,
                     withReuseIdentifier: registerStruct.identifier)
        }else{
            register(registerStruct.classType,
                     forSupplementaryViewOfKind: axc_elementKindSectionFooter,
                     withReuseIdentifier: registerStruct.identifier)
        }
    }
    
    /// 生成注册的Cell
    /// - Parameters:
    ///   - cell: cellClass
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func axc_dequeueReusableCell<T: UICollectionViewCell>(_ identifier: String? = nil, for indexPath: IndexPath) -> T {
        let identifier = identifier ?? T.axc_className
        // 这里崩溃，请检查注册的cell和使用的cell类型是否一致哦~
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            AxcLog("获取注册的Cell失败！\nIdentifier:\(identifier)", level: .fatal)
            return T()
        }
        return cell
    }
    
    /// 生成注册的视图
    /// - Parameters:
    ///   - cell: cellClass
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func axc_dequeueReusableView<T: UICollectionReusableView>(_ registerStruct: AxcRegisterStruct,
                                                              indexPath: IndexPath) -> T {
        var identifier = registerStruct.identifier
        if  identifier.count == 0 {
            identifier = "\(registerStruct.classType)"
        }
        var view = T()
        switch registerStruct.style {
        case .cell:
            guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                    as? T else { return view }
            view = cell
        case .header:
            guard let header = dequeueReusableSupplementaryView(ofKind: axc_elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath)
                    as? T else { return view }
            view = header
        case .footer:
            guard let footer = dequeueReusableSupplementaryView(ofKind: axc_elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath)
                    as? T else { return view }
            view = footer
        }
        return view
    }
    
    
}

// MARK: - 组动画协议
extension UICollectionView: AxcSubviewsAnimationProtocol {
    /// 返回所有需要动画的视图
    public func axc_animationViews(_ animation: CAAnimation) -> [UIView] {
        return visibleCells
    }
}

// MARK: - 决策判断
public extension UICollectionView {
}

//// MARK: - 代理转Block
//private var kaxc_collectionDelegate = "kaxc_collectionDelegate"
//private var kaxc_dataSource = "kaxc_dataSource"
//private var kaxc_delegateFlowLayout = "kaxc_delegateFlowLayout"
//public extension UICollectionView {/// 返回UICollectionView,Int的Block声明
//    typealias AxcCollectionViewIntBlock<T> = (UICollectionView,Int) -> T
//    /// 返回UICollectionView,String,IndexPath的Block声明
//    typealias AxcCollectionViewStringIndexPathBlock<T> = (UICollectionView,String,IndexPath) -> T
//    /// 返回UICollectionView,String,Int的Block声明
//    typealias AxcCollectionViewStringIntBlock<T> = (UICollectionView,String,Int) -> T
//    /// 返回UICollectionView,IndexPath的Block声明
//    typealias AxcCollectionViewIndexPathBlock<T> = (UICollectionView,IndexPath) -> T
//    /// 返回UICollectionView的Block声明
//    typealias AxcCollectionViewBlock<T> = (UICollectionView) -> T
//    /// 返回UICollectionView,IndexPath,IndexPath的Block声明
//    typealias AxcCollectionViewIndexPathIndexPathBlock<T> = (UICollectionView,IndexPath,IndexPath) -> T
//
//    /// 数据源转Block桥接者
//    var axc_dataSource: AxcCollectionDataSource {
//        set { AxcRuntime.setObj(self, &kaxc_dataSource, newValue)
//            self.dataSource = newValue
//        }
//        get { // runtime 懒加载
//            guard let dataSourceObj: AxcCollectionDataSource = AxcRuntime.getObj(self, &kaxc_dataSource) else {
//                let dat = AxcCollectionDataSource()
//                self.axc_dataSource = dat
//                dataSource = dat
//                return dat
//            }
//            dataSource = dataSourceObj
//            return dataSourceObj
//        }
//    }
//    /// 块设置数据源方法
//    /// - Parameter block: block
//    func axc_makeDataSource(_ block: (AxcCollectionDataSource) -> Void) {
//        block(axc_dataSource)
//    }
//
//    /// 返回UICollectionView,CGPoint的Block声明
//    typealias AxcPointBlock<T> = (UICollectionView,CGPoint) -> T
//    /// 返回UICollectionView,UIContextMenuConfiguration,UIContextMenuInteractionCommitAnimating的Block声明
//    @available(iOS 13.0, *)
//    typealias AxcContextMenuConfigurationContextMenuInteractionCommitAnimatingBlock<T> = (UICollectionView,UIContextMenuConfiguration,UIContextMenuInteractionCommitAnimating) -> T
//    /// 返回UICollectionView,IndexPath,UISpringLoadedInteractionContext的Block声明
//    @available(iOS 11.0, *)
//    typealias AxcIndexPathSpringLoadedInteractionContextBlock<T> = (UICollectionView,IndexPath,UISpringLoadedInteractionContext) -> T
//    /// 返回UICollectionView,UICollectionReusableView,String,IndexPath的Block声明
//    typealias AxcCollectionReusableViewStringIndexPathBlock<T> = (UICollectionView,UICollectionReusableView,String,IndexPath) -> T
//    /// 返回UICollectionView,UICollectionViewCell,IndexPath的Block声明
//    typealias AxcCellIndexPathBlock<T> = (UICollectionView,UICollectionViewCell,IndexPath) -> T
//    /// 返回UICollectionView的Block声明
//    typealias AxcBlock<T> = (UICollectionView) -> T
//    /// 返回UICollectionView,IndexPath,IndexPath的Block声明
//    typealias AxcIndexPathIndexPathBlock<T> = (UICollectionView,IndexPath,IndexPath) -> T
//    /// 返回UICollectionView,UIContextMenuConfiguration,UIContextMenuInteractionAnimating?的Block声明
//    @available(iOS 13.0, *)
//    typealias AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<T> = (UICollectionView,UIContextMenuConfiguration,UIContextMenuInteractionAnimating?) -> T
//    /// 返回UICollectionView,IndexPath,CGPoint的Block声明
//    typealias AxcIndexPathPointBlock<T> = (UICollectionView,IndexPath,CGPoint) -> T
//    /// 返回UICollectionView,IndexPath的Block声明
//    typealias AxcIndexPathBlock<T> = (UICollectionView,IndexPath) -> T
//    /// 返回UICollectionView,UIContextMenuConfiguration的Block声明
//    @available(iOS 13.0, *)
//    typealias AxcContextMenuConfigurationBlock<T> = (UICollectionView,UIContextMenuConfiguration) -> T
//    /// 返回UICollectionView,UICollectionViewFocusUpdateContext的Block声明
//    typealias AxcFocusUpdateContextBlock<T> = (UICollectionView,UICollectionViewFocusUpdateContext) -> T
//    /// 返回UICollectionView,Selector,IndexPath,Any?的Block声明
//    typealias AxcSelectorIndexPathAnyBlock<T> = (UICollectionView,Selector,IndexPath,Any?) -> T
//    /// 返回UICollectionView,UICollectionViewLayout,UICollectionViewLayout的Block声明
//    typealias AxcLayoutLayoutBlock<T> = (UICollectionView,UICollectionViewLayout,UICollectionViewLayout) -> T
//    /// 返回UICollectionView,UICollectionViewFocusUpdateContext,UIFocusAnimationCoordinator的Block声明
//    typealias AxcFocusUpdateContextFocusAnimationCoordinatorBlock<T> = (UICollectionView,UICollectionViewFocusUpdateContext,UIFocusAnimationCoordinator) -> T
//
//    /// 返回UICollectionView,UICollectionViewLayout,Int的Block声明
//    typealias AxcLayoutIntBlock<T> = (UICollectionView,UICollectionViewLayout,Int) -> T
//    /// 返回UICollectionView,UICollectionViewLayout,IndexPath的Block声明
//    typealias AxcLayoutIndexPathBlock<T> = (UICollectionView,UICollectionViewLayout,IndexPath) -> T
//
//    /// 代理转Block桥接者
//    var axc_collectionDelegate: AxcCollectionDelegate {
//        set { AxcRuntime.setObj(self, &kaxc_collectionDelegate, newValue)
//            self.delegate = newValue
//        }
//        get { // runtime 懒加载
//            guard let delegate: AxcCollectionDelegate = AxcRuntime.getObj(self, &kaxc_collectionDelegate) else {
//                let delegate = AxcCollectionDelegate()
//                self.axc_collectionDelegate = delegate
//                self.delegate = delegate
//                return delegate
//            }
//            self.delegate = delegate
//            return delegate
//        }
//    }
//    /// 块设置代理方法
//    /// - Parameter block: block
//    func axc_makeCollectionDelegate(_ block: (AxcCollectionDelegate) -> Void) {
//        block(axc_collectionDelegate)
//    }
//}
//
//// MARK: 数据源桥接者
///// 代理转Block桥接者
//open class AxcCollectionDataSource: NSObject, UICollectionViewDataSource {
//    /// func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    @discardableResult
//    open func axc_setCollectionViewNumberOfItemsInSectionBlock(_ block: @escaping UICollectionView.AxcCollectionViewIntBlock<Int>) -> Self {
//        axc_collectionViewNumberOfItemsInSectionBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewNumberOfItemsInSectionBlock: UICollectionView.AxcCollectionViewIntBlock<Int>
//        = { _,_ in return 0 }
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return axc_collectionViewNumberOfItemsInSectionBlock(collectionView,section)
//    }
//
//
//    /// func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
//    @discardableResult
//    open func axc_setCollectionViewCellForItemAtBlock(_ block: @escaping UICollectionView.AxcCollectionViewIndexPathBlock<UICollectionViewCell>) -> Self {
//        axc_collectionViewCellForItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewCellForItemAtBlock: UICollectionView.AxcCollectionViewIndexPathBlock<UICollectionViewCell>
//        = { _,_ in return UICollectionViewCell() }
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return axc_collectionViewCellForItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func numberOfSections(in collectionView: UICollectionView) -> Int
//    @discardableResult
//    open func axc_setNumberOfSectionsInBlock(_ block: @escaping UICollectionView.AxcCollectionViewBlock<Int>) -> Self {
//        axc_numberOfSectionsInBlock = block
//        return self
//    }
//    open lazy var axc_numberOfSectionsInBlock: UICollectionView.AxcCollectionViewBlock<Int>
//        = { _ in return 1 }
//    public func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return axc_numberOfSectionsInBlock(collectionView)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
//    @discardableResult
//    open func axc_setCollectionViewViewForSupplementaryElementOfKindAtBlock(_ block: @escaping UICollectionView.AxcCollectionViewStringIndexPathBlock<UICollectionReusableView>) -> Self {
//        axc_collectionViewViewForSupplementaryElementOfKindAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewViewForSupplementaryElementOfKindAtBlock: UICollectionView.AxcCollectionViewStringIndexPathBlock<UICollectionReusableView>
//        = { _,_,_ in return UICollectionReusableView() }
//    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        return axc_collectionViewViewForSupplementaryElementOfKindAtBlock(collectionView,kind,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool
//    @discardableResult
//    open func axc_setCollectionViewCanMoveItemAtBlock(_ block: @escaping UICollectionView.AxcCollectionViewIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewCanMoveItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewCanMoveItemAtBlock: UICollectionView.AxcCollectionViewIndexPathBlock<Bool>
//        = { _,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewCanMoveItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewMoveItemAtToBlock(_ block: @escaping UICollectionView.AxcCollectionViewIndexPathIndexPathBlock<Void>) -> Self {
//        axc_collectionViewMoveItemAtToBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewMoveItemAtToBlock: UICollectionView.AxcCollectionViewIndexPathIndexPathBlock<Void>
//        = { _,_,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) -> Void {
//        axc_collectionViewMoveItemAtToBlock(collectionView,sourceIndexPath,destinationIndexPath)
//    }
//
//
//    /// optional func indexTitles(for collectionView: UICollectionView) -> [String]?
//    @discardableResult
//    open func axc_setIndexTitlesForBlock(_ block: @escaping UICollectionView.AxcCollectionViewBlock<[String]?>) -> Self {
//        axc_indexTitlesForBlock = block
//        return self
//    }
//    open lazy var axc_indexTitlesForBlock: UICollectionView.AxcCollectionViewBlock<[String]?>
//        = { _ in return nil }
//    public func indexTitles(for collectionView: UICollectionView) -> [String]? {
//        return axc_indexTitlesForBlock(collectionView)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath
//    @discardableResult
//    open func axc_setCollectionViewIndexPathForIndexTitleAtBlock(_ block: @escaping UICollectionView.AxcCollectionViewStringIntBlock<IndexPath>) -> Self {
//        axc_collectionViewIndexPathForIndexTitleAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewIndexPathForIndexTitleAtBlock: UICollectionView.AxcCollectionViewStringIntBlock<IndexPath>
//        = { _,_,_ in return 0.axc_row }
//    public func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
//        return axc_collectionViewIndexPathForIndexTitleAtBlock(collectionView,title,index)
//    }
//}
//
//// MARK: 代理桥接者
///// 代理转Block桥接者
//open class AxcCollectionDelegate: AxcScrollDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    /// optional func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
//    @discardableResult
//    open func axc_setCollectionViewShouldHighlightItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewShouldHighlightItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewShouldHighlightItemAtBlock: UICollectionView.AxcIndexPathBlock<Bool>
//        = { _,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewShouldHighlightItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewDidHighlightItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Void>) -> Self {
//        axc_collectionViewDidHighlightItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidHighlightItemAtBlock: UICollectionView.AxcIndexPathBlock<Void>
//        = { _,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) -> Void {
//        axc_collectionViewDidHighlightItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewDidUnhighlightItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Void>) -> Self {
//        axc_collectionViewDidUnhighlightItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidUnhighlightItemAtBlock: UICollectionView.AxcIndexPathBlock<Void>
//        = { _,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) -> Void {
//        axc_collectionViewDidUnhighlightItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
//    @discardableResult
//    open func axc_setCollectionViewShouldSelectItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewShouldSelectItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewShouldSelectItemAtBlock: UICollectionView.AxcIndexPathBlock<Bool>
//        = { _,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewShouldSelectItemAtBlock(collectionView,indexPath)
//    }
//
//
//    ///  called when the user taps on an already-selected item in multi-select mode
//    @discardableResult
//    open func axc_setCollectionViewShouldDeselectItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewShouldDeselectItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewShouldDeselectItemAtBlock: UICollectionView.AxcIndexPathBlock<Bool>
//        = { _,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewShouldDeselectItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewDidSelectItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Void>) -> Self {
//        axc_collectionViewDidSelectItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidSelectItemAtBlock: UICollectionView.AxcIndexPathBlock<Void>
//        = { _,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
//        axc_collectionViewDidSelectItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewDidDeselectItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Void>) -> Self {
//        axc_collectionViewDidDeselectItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidDeselectItemAtBlock: UICollectionView.AxcIndexPathBlock<Void>
//        = { _,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) -> Void {
//        axc_collectionViewDidDeselectItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewWillDisplayForItemAtBlock(_ block: @escaping UICollectionView.AxcCellIndexPathBlock<Void>) -> Self {
//        axc_collectionViewWillDisplayForItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewWillDisplayForItemAtBlock: UICollectionView.AxcCellIndexPathBlock<Void>
//        = { _,_,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) -> Void {
//        axc_collectionViewWillDisplayForItemAtBlock(collectionView,cell,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewWillDisplaySupplementaryViewForElementKindAtBlock(_ block: @escaping UICollectionView.AxcCollectionReusableViewStringIndexPathBlock<Void>) -> Self {
//        axc_collectionViewWillDisplaySupplementaryViewForElementKindAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewWillDisplaySupplementaryViewForElementKindAtBlock: UICollectionView.AxcCollectionReusableViewStringIndexPathBlock<Void>
//        = { _,_,_,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) -> Void {
//        axc_collectionViewWillDisplaySupplementaryViewForElementKindAtBlock(collectionView,view,elementKind,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewDidEndDisplayingForItemAtBlock(_ block: @escaping UICollectionView.AxcCellIndexPathBlock<Void>) -> Self {
//        axc_collectionViewDidEndDisplayingForItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidEndDisplayingForItemAtBlock: UICollectionView.AxcCellIndexPathBlock<Void>
//        = { _,_,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) -> Void {
//        axc_collectionViewDidEndDisplayingForItemAtBlock(collectionView,cell,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath)
//    @discardableResult
//    open func axc_setCollectionViewDidEndDisplayingSupplementaryViewForElementOfKindAtBlock(_ block: @escaping UICollectionView.AxcCollectionReusableViewStringIndexPathBlock<Void>) -> Self {
//        axc_collectionViewDidEndDisplayingSupplementaryViewForElementOfKindAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidEndDisplayingSupplementaryViewForElementOfKindAtBlock: UICollectionView.AxcCollectionReusableViewStringIndexPathBlock<Void>
//        = { _,_,_,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) -> Void {
//        axc_collectionViewDidEndDisplayingSupplementaryViewForElementOfKindAtBlock(collectionView,view,elementKind,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool
//    @discardableResult
//    open func axc_setCollectionViewShouldShowMenuForItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewShouldShowMenuForItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewShouldShowMenuForItemAtBlock: UICollectionView.AxcIndexPathBlock<Bool>
//        = { _,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewShouldShowMenuForItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool
//    @discardableResult
//    open func axc_setCollectionViewCanPerformActionForItemAtWithSenderBlock(_ block: @escaping UICollectionView.AxcSelectorIndexPathAnyBlock<Bool>) -> Self {
//        axc_collectionViewCanPerformActionForItemAtWithSenderBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewCanPerformActionForItemAtWithSenderBlock: UICollectionView.AxcSelectorIndexPathAnyBlock<Bool>
//        = { _,_,_,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        return axc_collectionViewCanPerformActionForItemAtWithSenderBlock(collectionView,action,indexPath,sender)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?)
//    @discardableResult
//    open func axc_setCollectionViewPerformActionForItemAtWithSenderBlock(_ block: @escaping UICollectionView.AxcSelectorIndexPathAnyBlock<Void>) -> Self {
//        axc_collectionViewPerformActionForItemAtWithSenderBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewPerformActionForItemAtWithSenderBlock: UICollectionView.AxcSelectorIndexPathAnyBlock<Void>
//        = { _,_,_,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Void {
//        axc_collectionViewPerformActionForItemAtWithSenderBlock(collectionView,action,indexPath,sender)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout
//    @discardableResult
//    open func axc_setCollectionViewTransitionLayoutForOldLayoutNewLayoutBlock(_ block: @escaping UICollectionView.AxcLayoutLayoutBlock<UICollectionViewTransitionLayout>) -> Self {
//        axc_collectionViewTransitionLayoutForOldLayoutNewLayoutBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewTransitionLayoutForOldLayoutNewLayoutBlock: UICollectionView.AxcLayoutLayoutBlock<UICollectionViewTransitionLayout>
//        = { c,_,_ in return UICollectionViewTransitionLayout(currentLayout: c.collectionViewLayout, nextLayout: c.collectionViewLayout) }
//    public func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//        return axc_collectionViewTransitionLayoutForOldLayoutNewLayoutBlock(collectionView,fromLayout,toLayout)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool
//    @discardableResult
//    open func axc_setCollectionViewCanFocusItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewCanFocusItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewCanFocusItemAtBlock: UICollectionView.AxcIndexPathBlock<Bool>
//        = { _,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewCanFocusItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool
//    @discardableResult
//    open func axc_setCollectionViewShouldUpdateFocusInBlock(_ block: @escaping UICollectionView.AxcFocusUpdateContextBlock<Bool>) -> Self {
//        axc_collectionViewShouldUpdateFocusInBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewShouldUpdateFocusInBlock: UICollectionView.AxcFocusUpdateContextBlock<Bool>
//        = { _,_ in return true }
//    public func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
//        return axc_collectionViewShouldUpdateFocusInBlock(collectionView,context)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
//    @discardableResult
//    open func axc_setCollectionViewDidUpdateFocusInWithBlock(_ block: @escaping UICollectionView.AxcFocusUpdateContextFocusAnimationCoordinatorBlock<Void>) -> Self {
//        axc_collectionViewDidUpdateFocusInWithBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidUpdateFocusInWithBlock: UICollectionView.AxcFocusUpdateContextFocusAnimationCoordinatorBlock<Void>
//        = { _,_,_ in  }
//    public func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) -> Void {
//        axc_collectionViewDidUpdateFocusInWithBlock(collectionView,context,coordinator)
//    }
//
//
//    /// optional func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath?
//    @discardableResult
//    open func axc_setIndexPathForPreferredFocusedViewInBlock(_ block: @escaping UICollectionView.AxcBlock<IndexPath?>) -> Self {
//        axc_indexPathForPreferredFocusedViewInBlock = block
//        return self
//    }
//    open lazy var axc_indexPathForPreferredFocusedViewInBlock: UICollectionView.AxcBlock<IndexPath?>
//        = { _ in return nil }
//    public func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
//        return axc_indexPathForPreferredFocusedViewInBlock(collectionView)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath
//    @discardableResult
//    open func axc_setCollectionViewTargetIndexPathForMoveFromItemAtToProposedIndexPathBlock(_ block: @escaping UICollectionView.AxcIndexPathIndexPathBlock<IndexPath>) -> Self {
//        axc_collectionViewTargetIndexPathForMoveFromItemAtToProposedIndexPathBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewTargetIndexPathForMoveFromItemAtToProposedIndexPathBlock: UICollectionView.AxcIndexPathIndexPathBlock<IndexPath>
//        = { _,_,_ in return 0.axc_row }
//    public func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
//        return axc_collectionViewTargetIndexPathForMoveFromItemAtToProposedIndexPathBlock(collectionView,originalIndexPath,proposedIndexPath)
//    }
//
//
//    ///  customize the content offset to be applied during transition or update animations
//    @discardableResult
//    open func axc_setCollectionViewTargetContentOffsetForProposedContentOffsetBlock(_ block: @escaping UICollectionView.AxcPointBlock<CGPoint>) -> Self {
//        axc_collectionViewTargetContentOffsetForProposedContentOffsetBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewTargetContentOffsetForProposedContentOffsetBlock: UICollectionView.AxcPointBlock<CGPoint>
//        = { _,_ in return CGPoint() }
//    public func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        return axc_collectionViewTargetContentOffsetForProposedContentOffsetBlock(collectionView,proposedContentOffset)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool
//    @available(iOS 14.0, *)
//    @discardableResult
//    open func axc_setCollectionViewCanEditItemAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewCanEditItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewCanEditItemAtBlock: UICollectionView.AxcIndexPathBlock<Bool>
//        = { _,_ in return true }
//    @available(iOS 14.0, *)
//    public func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewCanEditItemAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
//    @available(iOS 11.0, *)
//    @discardableResult
//    open func axc_setCollectionViewShouldSpringLoadItemAtWithBlock(_ block: @escaping UICollectionView.AxcIndexPathSpringLoadedInteractionContextBlock<Bool>) -> Self {
//        axc_collectionViewShouldSpringLoadItemAtWithBlock = block
//        return self
//    }
//    @available(iOS 11.0, *)
//    open lazy var axc_collectionViewShouldSpringLoadItemAtWithBlock: UICollectionView.AxcIndexPathSpringLoadedInteractionContextBlock<Bool>
//        = { _,_,_ in return true }
//    @available(iOS 11.0, *)
//    public func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
//        return axc_collectionViewShouldSpringLoadItemAtWithBlock(collectionView,indexPath,context)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setCollectionViewShouldBeginMultipleSelectionInteractionAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Bool>) -> Self {
//        axc_collectionViewShouldBeginMultipleSelectionInteractionAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewShouldBeginMultipleSelectionInteractionAtBlock: UICollectionView.AxcIndexPathBlock<Bool>
//        = { _,_ in return true }
//    @available(iOS 13.0, *)
//    public func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
//        return axc_collectionViewShouldBeginMultipleSelectionInteractionAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setCollectionViewDidBeginMultipleSelectionInteractionAtBlock(_ block: @escaping UICollectionView.AxcIndexPathBlock<Void>) -> Self {
//        axc_collectionViewDidBeginMultipleSelectionInteractionAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidBeginMultipleSelectionInteractionAtBlock: UICollectionView.AxcIndexPathBlock<Void>
//        = { _,_ in  }
//    @available(iOS 13.0, *)
//    public func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Void {
//        axc_collectionViewDidBeginMultipleSelectionInteractionAtBlock(collectionView,indexPath)
//    }
//
//
//    /// optional func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView)
//    @available(iOS 13.0, *)
//    @discardableResult
//    open func axc_setCollectionViewDidEndMultipleSelectionInteractionBlock(_ block: @escaping UICollectionView.AxcBlock<Void>) -> Self {
//        axc_collectionViewDidEndMultipleSelectionInteractionBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewDidEndMultipleSelectionInteractionBlock: UICollectionView.AxcBlock<Void>
//        = { _ in  }
//    @available(iOS 13.0, *)
//    public func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) -> Void {
//        axc_collectionViewDidEndMultipleSelectionInteractionBlock(collectionView)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
////    @available(iOS 13.0, *)
////    @discardableResult
////    open func axc_setCollectionViewContextMenuConfigurationForItemAtPointBlock(_ block: @escaping UICollectionView.AxcIndexPathPointBlock<UIContextMenuConfiguration?>) -> Self {
////        axc_collectionViewContextMenuConfigurationForItemAtPointBlock = block
////        return self
////    }
////    open lazy var axc_collectionViewContextMenuConfigurationForItemAtPointBlock: UICollectionView.AxcIndexPathPointBlock<UIContextMenuConfiguration?>
////        = { _,_,_ in return nil }
////    @available(iOS 13.0, *)
////    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
////        return axc_collectionViewContextMenuConfigurationForItemAtPointBlock(collectionView,indexPath,point)
////    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
////    @available(iOS 13.0, *)
////    @discardableResult
////    open func axc_setCollectionViewPreviewForHighlightingContextMenuWithConfigurationBlock(_ block: @escaping UICollectionView.AxcContextMenuConfigurationBlock<UITargetedPreview?>) -> Self {
////        axc_collectionViewPreviewForHighlightingContextMenuWithConfigurationBlock = block
////        return self
////    }
////    open lazy var axc_collectionViewPreviewForHighlightingContextMenuWithConfigurationBlock: UICollectionView.AxcContextMenuConfigurationBlock<UITargetedPreview?>
////        = { _,_ in return nil }
////    @available(iOS 13.0, *)
////    public func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
////        return axc_collectionViewPreviewForHighlightingContextMenuWithConfigurationBlock(collectionView,configuration)
////    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
////    @available(iOS 13.0, *)
////    @discardableResult
////    open func axc_setCollectionViewPreviewForDismissingContextMenuWithConfigurationBlock(_ block: @escaping UICollectionView.AxcContextMenuConfigurationBlock<UITargetedPreview?>) -> Self {
////        axc_collectionViewPreviewForDismissingContextMenuWithConfigurationBlock = block
////        return self
////    }
////    open lazy var axc_collectionViewPreviewForDismissingContextMenuWithConfigurationBlock: UICollectionView.AxcContextMenuConfigurationBlock<UITargetedPreview?>
////        = { _,_ in return nil }
////    @available(iOS 13.0, *)
////    public func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
////        return axc_collectionViewPreviewForDismissingContextMenuWithConfigurationBlock(collectionView,configuration)
////    }
////
////
////    /// optional func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating)
////    @available(iOS 13.0, *)
////    @discardableResult
////    open func axc_setCollectionViewWillPerformPreviewActionForMenuWithAnimatorBlock(_ block: @escaping UICollectionView.AxcContextMenuConfigurationContextMenuInteractionCommitAnimatingBlock<Void>) -> Self {
////        axc_collectionViewWillPerformPreviewActionForMenuWithAnimatorBlock = block
////        return self
////    }
////    open lazy var axc_collectionViewWillPerformPreviewActionForMenuWithAnimatorBlock: UICollectionView.AxcContextMenuConfigurationContextMenuInteractionCommitAnimatingBlock<Void>
////        = { _,_,_ in  }
////    @available(iOS 13.0, *)
////    public func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) -> Void {
////        axc_collectionViewWillPerformPreviewActionForMenuWithAnimatorBlock(collectionView,configuration,animator)
////    }
////
////
////    /// optional func collectionView(_ collectionView: UICollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?)
////    @available(iOS 13.2, *)
////    @discardableResult
////    open func axc_setCollectionViewWillDisplayContextMenuAnimatorBlock(_ block: @escaping UICollectionView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>) -> Self {
////        axc_collectionViewWillDisplayContextMenuAnimatorBlock = block
////        return self
////    }
////    open lazy var axc_collectionViewWillDisplayContextMenuAnimatorBlock: UICollectionView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>
////        = { _,_,_ in  }
////    @available(iOS 13.2, *)
////    public func collectionView(_ collectionView: UICollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) -> Void {
////        axc_collectionViewWillDisplayContextMenuAnimatorBlock(collectionView,configuration,animator)
////    }
////
////
////    /// optional func collectionView(_ collectionView: UICollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?)
////    @available(iOS 13.2, *)
////    @discardableResult
////    open func axc_setCollectionViewWillEndContextMenuInteractionAnimatorBlock(_ block: @escaping UICollectionView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>) -> Self {
////        axc_collectionViewWillEndContextMenuInteractionAnimatorBlock = block
////        return self
////    }
////    open lazy var axc_collectionViewWillEndContextMenuInteractionAnimatorBlock: UICollectionView.AxcContextMenuConfigurationContextMenuInteractionAnimatingBlock<Void>
////        = { _,_,_ in  }
////    @available(iOS 13.2, *)
////    public func collectionView(_ collectionView: UICollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) -> Void {
////        axc_collectionViewWillEndContextMenuInteractionAnimatorBlock(collectionView,configuration,animator)
////    }
//
//    // MARK: 布局
//
//    /// optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    @discardableResult
//    open func axc_setCollectionViewLayoutSizeForItemAtBlock(_ block: @escaping UICollectionView.AxcLayoutIndexPathBlock<CGSize>) -> Self {
//        axc_collectionViewLayoutSizeForItemAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewLayoutSizeForItemAtBlock: UICollectionView.AxcLayoutIndexPathBlock<CGSize>
//        = { _,layout,_ in
//            if let _layout = layout as? UICollectionViewFlowLayout { return _layout.itemSize }
//            return CGSize()
//        }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return axc_collectionViewLayoutSizeForItemAtBlock(collectionView,collectionViewLayout,indexPath)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
//    @discardableResult
//    open func axc_setCollectionViewLayoutInsetForSectionAtBlock(_ block: @escaping UICollectionView.AxcLayoutIntBlock<UIEdgeInsets>) -> Self {
//        axc_collectionViewLayoutInsetForSectionAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewLayoutInsetForSectionAtBlock: UICollectionView.AxcLayoutIntBlock<UIEdgeInsets>
//        = { _,layout,_ in
//            if let _layout = layout as? UICollectionViewFlowLayout { return _layout.sectionInset }
//            return UIEdgeInsets()
//        }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return axc_collectionViewLayoutInsetForSectionAtBlock(collectionView,collectionViewLayout,section)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
//    @discardableResult
//    open func axc_setCollectionViewLayoutMinimumLineSpacingForSectionAtBlock(_ block: @escaping UICollectionView.AxcLayoutIntBlock<CGFloat>) -> Self {
//        axc_collectionViewLayoutMinimumLineSpacingForSectionAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewLayoutMinimumLineSpacingForSectionAtBlock: UICollectionView.AxcLayoutIntBlock<CGFloat>
//        = { _,layout,_ in
//            if let _layout = layout as? UICollectionViewFlowLayout { return _layout.minimumLineSpacing }
//            return 0
//        }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return axc_collectionViewLayoutMinimumLineSpacingForSectionAtBlock(collectionView,collectionViewLayout,section)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
//    @discardableResult
//    open func axc_setCollectionViewLayoutMinimumInteritemSpacingForSectionAtBlock(_ block: @escaping UICollectionView.AxcLayoutIntBlock<CGFloat>) -> Self {
//        axc_collectionViewLayoutMinimumInteritemSpacingForSectionAtBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewLayoutMinimumInteritemSpacingForSectionAtBlock: UICollectionView.AxcLayoutIntBlock<CGFloat>
//        = { _,layout,_ in
//            if let _layout = layout as? UICollectionViewFlowLayout { return _layout.minimumInteritemSpacing }
//            return 0
//        }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return axc_collectionViewLayoutMinimumInteritemSpacingForSectionAtBlock(collectionView,collectionViewLayout,section)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
//    @discardableResult
//    open func axc_setCollectionViewLayoutReferenceSizeForHeaderInSectionBlock(_ block: @escaping UICollectionView.AxcLayoutIntBlock<CGSize>) -> Self {
//        axc_collectionViewLayoutReferenceSizeForHeaderInSectionBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewLayoutReferenceSizeForHeaderInSectionBlock: UICollectionView.AxcLayoutIntBlock<CGSize>
//        = { _,layout,_ in
//            if let _layout = layout as? UICollectionViewFlowLayout { return _layout.headerReferenceSize }
//            return CGSize()
//        }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return axc_collectionViewLayoutReferenceSizeForHeaderInSectionBlock(collectionView,collectionViewLayout,section)
//    }
//
//
//    /// optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
//    @discardableResult
//    open func axc_setCollectionViewLayoutReferenceSizeForFooterInSectionBlock(_ block: @escaping UICollectionView.AxcLayoutIntBlock<CGSize>) -> Self {
//        axc_collectionViewLayoutReferenceSizeForFooterInSectionBlock = block
//        return self
//    }
//    open lazy var axc_collectionViewLayoutReferenceSizeForFooterInSectionBlock: UICollectionView.AxcLayoutIntBlock<CGSize>
//        = { _,layout,_ in
//            if let _layout = layout as? UICollectionViewFlowLayout { return _layout.footerReferenceSize }
//            return CGSize()
//        }
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return axc_collectionViewLayoutReferenceSizeForFooterInSectionBlock(collectionView,collectionViewLayout,section)
//    }
//}
//
