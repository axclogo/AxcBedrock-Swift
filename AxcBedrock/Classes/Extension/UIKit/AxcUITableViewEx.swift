//
//  AxcTableViewEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/21.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UITableView { }

// MARK: - 类方法

public extension AxcSpace where Base: UITableView {
    /// 创建一个TableView
    static func Create(frame: CGRect = .zero,
                       style: UITableView.Style,
                       delegate: UITableViewDelegate? = nil,
                       dataSource: UITableViewDataSource? = nil,
                       registers: [AxcRegister] = []) -> Base {
        let tableView = Base(frame: frame, style: style)
        tableView.axc.configTableView(delegate: delegate, dataSource: dataSource, registers: registers)
        return tableView
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: UITableView {
    /// 配置列表视图
    func configTableView(delegate: UITableViewDelegate? = nil,
                         dataSource: UITableViewDataSource? = nil,
                         registers: [AxcRegister] = []) {
        base.delegate = delegate
        base.dataSource = dataSource
        // 滚动时收起键盘
        base.keyboardDismissMode = .onDrag
        base.separatorStyle = .none
        base.backgroundColor = .white
        base.estimatedRowHeight = 0.01
        base.estimatedSectionHeaderHeight = 0.01
        base.estimatedSectionFooterHeight = 0.01
        base.delaysContentTouches = false // 关闭按钮延时
        base.rowHeight = 44 // 标准高度
        if #available(iOS 11.0, *) {
            // 就算超出了安全边距，系统不会对你的scrollView做任何事情，即不作任何调整
            base.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 15.0, *) {
            // iOS15 新增的参数，不设置的情况下，组头会有默认距离
            base.sectionHeaderTopPadding = 0
            base.fillerRowHeight = 0
        }
        // 注册视图
        if !registers.isEmpty { // 优化运算量，否则还要执行forEach方法
            base.axc.registers(registers)
        }
    }

    /// 刷新后的回调
    /// - Parameter completeBlock: 回调闭包
    @available(iOS 11.0, *)
    func reloadData(_ completeBlock: @escaping AxcBlock.TwoParam<Base, Bool>) {
        base.reloadData()
        base.performBatchUpdates(nil) { [weak base] isComplete in
            guard let weakBase = base else { return }
            completeBlock(weakBase, isComplete)
        }
    }

    /// 注册一组视图
    /// - Parameter registers: 注册结构体集合
    func registers(_ registers: [AxcRegister]) {
        registers.forEach {
            if $0.style == .cell { registerCell($0) }
            else { registerHeaderFooter($0) }
        }
    }

    /// 注册一个cell
    /// - Parameter registerStruct: 注册结构体
    func registerCell(_ registerStruct: AxcRegister) {
        guard registerStruct.style == .cell else { return }
        let type = "\(registerStruct.classType)"
        if registerStruct.useNib { // 使用Nib加载
            base.register(UINib(nibName: type, bundle: nil),
                          forCellReuseIdentifier: registerStruct.identifier)
        } else {
            base.register(registerStruct.classType,
                          forCellReuseIdentifier: registerStruct.identifier)
        }
    }

    /// 注册头尾视图
    /// - Parameter registerStruct: 注册结构体
    func registerHeaderFooter(_ registerStruct: AxcRegister) {
        guard registerStruct.style == .header || registerStruct.style == .footer else { return }
        let type = "\(registerStruct.classType)"
        if registerStruct.useNib { // 使用Nib加载
            base.register(UINib(nibName: type, bundle: nil),
                          forHeaderFooterViewReuseIdentifier: registerStruct.identifier)
        } else {
            base.register(registerStruct.classType,
                          forHeaderFooterViewReuseIdentifier: registerStruct.identifier)
        }
    }

    /// 生成注册的Cell
    /// - Parameters:
    ///   - cell: cellClass
    ///   - indexPath: indexPath
    /// - Returns: Cell
    func dequeueReusableCell<T: UITableViewCell>(_ identifier: String? = nil) -> T {
        let identifier = identifier ?? NSStringFromClass(T.self)
        guard let cell = base.dequeueReusableCell(withIdentifier: identifier) as? T else {
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
}

// MARK: - 决策判断

public extension AxcSpace where Base: UITableView { }

// MARK: - 实例化方法

public extension UITableView { }

// MARK: - 运算符/操作符

public extension UITableView { }

#endif
