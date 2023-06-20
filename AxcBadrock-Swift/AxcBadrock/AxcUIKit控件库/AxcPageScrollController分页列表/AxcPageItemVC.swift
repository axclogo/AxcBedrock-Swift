//
//  AxcPageItemVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

public typealias AxcPageItemControllerBlock = (UIScrollView) -> ()

open class AxcPageItemVC: AxcBaseVC {
    // MARK: - 初始化
    /// 唯一指定实例化方式
    public convenience init(_ tableViewStyle: UITableView.Style = .plain) {
        self.init()
        self.tableViewStyle = tableViewStyle
    }
    
    // MARK: - 父类重写
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    open override func config() {
    }
    open override func makeUI() {
        view.addSubview(tableView)
        tableView.axc.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }

    // MARK: - 私有
    private var tableViewStyle: UITableView.Style = .plain
    // MARK: - 非实现通信接口
    // Block回调
    open var axc_didScrollBlock: AxcPageItemControllerBlock?
    // 滑动列表
    open func axc_listScrollView() -> UIScrollView { return tableView }
    
    // MARK: - 懒加载
    open lazy var tableView: UITableView = {
        let tableView = UITableView(style: tableViewStyle, delegate: self, dataSource: self)
        return tableView
    }()
}

extension AxcPageItemVC: UITableViewDelegate, UITableViewDataSource {
    // 开始滑动 代理
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        axc_didScrollBlock?(scrollView)
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.axc_random
        return cell
    }
}
