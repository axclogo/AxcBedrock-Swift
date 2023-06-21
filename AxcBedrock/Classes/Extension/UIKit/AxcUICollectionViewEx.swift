//
//  AxcUICollectionViewEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/3/4.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UICollectionView { }

// MARK: - 类方法

public extension AxcSpace where Base: UICollectionView {
    /// 创建一个CollectionView
    static func Create(frame: CGRect = .zero,
                       layout: UICollectionViewLayout? = nil,
                       delegate: UICollectionViewDelegate? = nil,
                       dataSource: UICollectionViewDataSource? = nil,
                       registers: [AxcRegister] = []) -> Base {
        var flowLayout = UICollectionViewLayout()
        if let _layout = layout { flowLayout = _layout }
        let collectionView = Base(frame: frame, collectionViewLayout: flowLayout)
        collectionView.axc.configCollectionView(delegate: delegate, dataSource: dataSource, registers: registers)
        return collectionView
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: UICollectionView {
    /// 配置CollectionView的默认
    func configCollectionView(delegate: UICollectionViewDelegate? = nil,
                              dataSource: UICollectionViewDataSource? = nil,
                              registers: [AxcRegister] = []) {
        base.delegate = delegate
        base.dataSource = dataSource
        // 滚动时收起键盘
        base.keyboardDismissMode = .onDrag
        base.backgroundColor = UIColor.clear
        base.showsVerticalScrollIndicator = false
        base.showsHorizontalScrollIndicator = false
        base.delaysContentTouches = false // 关闭按钮延时
        base.alwaysBounceVertical = false // 内容填充不满也具有弹性效果
        if #available(iOS 11.0, *) {
            base.contentInsetAdjustmentBehavior = .never // 就算超出了安全边距，系统不会对你的scrollView做任何事情，即不作任何调整
        }
        // 默认注册系统
        let className = NSStringFromClass(UICollectionViewCell.self)
        base.register(UICollectionViewCell.self, forCellWithReuseIdentifier: className)
        if !registers.isEmpty { // 优化运算量，否则还要执行forEach方法
            base.axc.registers(registers)
        }
    }

    /// 刷新后的回调
    /// - Parameter completeBlock: 回调闭包
    func reloadData(_ completeBlock: @escaping AxcBlock.TwoParam<Base, Bool>) {
        base.reloadData()
        base.performBatchUpdates(nil) { [weak base] isComplete in
            guard let weakBase = base else { return }
            completeBlock(weakBase, isComplete)
        }
    }

    /// 注册一组视图
    func registers(_ registers: [AxcRegister]) {
        registers.forEach {
            switch $0.style {
            case .cell: registerCell($0)
            case .header: registerHeader($0)
            case .footer: registerFooter($0)
            }
        }
    }

    /// 注册一组cell
    func registerCells(_ registers: [AxcRegister]) {
        for cell in registers { registerCell(cell) }
    }

    /// 注册一个cell
    func registerCell(_ register: AxcRegister) {
        guard register.style == .cell else { return }
        let type = "\(register.classType)"
        if register.useNib { // 使用Nib加载
            base.register(UINib(nibName: type, bundle: nil), forCellWithReuseIdentifier: register.identifier)
        } else {
            base.register(register.classType, forCellWithReuseIdentifier: register.identifier)
        }
    }

    /// 注册头部视图
    /// - Parameter registerStruct: 注册结构体
    func registerHeader(_ register: AxcRegister) {
        guard register.style == .header else { return }
        let type = "\(register.classType)"
        if register.useNib { // 使用Nib加载
            base.register(UINib(nibName: type, bundle: nil),
                          forSupplementaryViewOfKind: Base.elementKindSectionHeader,
                          withReuseIdentifier: register.identifier)
        } else {
            base.register(register.classType,
                          forSupplementaryViewOfKind: Base.elementKindSectionHeader,
                          withReuseIdentifier: register.identifier)
        }
    }

    /// 注册尾部视图
    /// - Parameter registerStruct: 注册结构体
    func registerFooter(_ register: AxcRegister) {
        guard register.style == .footer else { return }
        let type = "\(register.classType)"
        if register.useNib { // 使用Nib加载
            base.register(UINib(nibName: type, bundle: nil),
                          forSupplementaryViewOfKind: Base.elementKindSectionFooter,
                          withReuseIdentifier: register.identifier)
        } else {
            base.register(register.classType,
                          forSupplementaryViewOfKind: Base.elementKindSectionFooter,
                          withReuseIdentifier: register.identifier)
        }
    }

    /// 生成注册的Cell
    /// - Parameters:
    ///   - identifier: identifier
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func dequeueReusableCell<T: UICollectionViewCell>(_ identifier: String? = nil,
                                                      for indexPath: IndexPath) -> T {
        let identifier = identifier ?? NSStringFromClass(T.self)
        // 这里崩溃，请检查注册的cell和使用的cell类型是否一致哦~
        guard let cell = base.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            let log = "获取注册的Cell失败！Identifier:\(identifier)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log) // 终止程序抛出异常
            #else
            return T()
            #endif
        }
        return cell
    }

    /// 生成注册的视图
    /// - Parameters:
    ///   - register: AxcRegister
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func dequeueReusableView<T: UICollectionReusableView>(_ register: AxcRegister,
                                                          indexPath: IndexPath) -> T {
        var identifier = register.identifier
        if identifier.count == 0 {
            identifier = "\(register.classType)"
        }
        var view = T()
        switch register.style {
        case .cell:
            guard let cell = base.dequeueReusableCell(withReuseIdentifier: identifier,
                                                      for: indexPath) as? T else { return view }
            view = cell
        case .header:
            guard let header = base.dequeueReusableSupplementaryView(ofKind: Base.elementKindSectionHeader,
                                                                     withReuseIdentifier: identifier,
                                                                     for: indexPath) as? T else { return view }
            view = header
        case .footer:
            guard let footer = base.dequeueReusableSupplementaryView(ofKind: Base.elementKindSectionFooter,
                                                                     withReuseIdentifier: identifier,
                                                                     for: indexPath) as? T else { return view }
            view = footer
        }
        return view
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UICollectionView { }

#endif
