//
//  SampleExtensionVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/20.
//

import UIKit

struct GroupStruct {
    var groupName: String
    var group: [ItemStruct]
}
struct ItemStruct {
    var title: String
    var vCName: String
}

class SampleExtensionVC: AxcBaseVC {
    // 搭建UI
    override func makeUI() {
        title = "类扩展示例"
        tableView.axc.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.loadData()
        
//        let sss = 100.axc_string
//        let sss = 100.axc_cgRect.axc_string

    }
    
    // 数据
    var dataList: [GroupStruct] = []
    
    // MARK: - 懒加载
    lazy var tableView: UITableView = {
        let tableView = UITableView(delegate: self, dataSource: self)
        axc_addSubView(tableView)
        return tableView
    }()
}

extension SampleExtensionVC {
    func loadData() {
        // 字符串扩展示例
        var group_0: [ItemStruct] = []
        group_0.append(ItemStruct(title: "String", vCName: "StringExSampleVC"))
        group_0.append(ItemStruct(title: "CreateBlockVC", vCName: "CreateBlockVC"))
        group_0.append(ItemStruct(title: "AxcUrlConfigVC", vCName: "AxcUrlConfigVC"))
        
        dataList.append(GroupStruct(groupName: "SwiftLib", group: group_0))
        tableView.reloadData()
    }
}

// MARK: - 协议
extension SampleExtensionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let group = dataList.axc_objAtIdx(indexPath.section) else { return }
        guard let item = group.group.axc_objAtIdx(indexPath.row) else { return }
        guard let vc_class = item.vCName.axc_class as? UIViewController.Type else { return }
        let vc = vc_class.init()
        vc.title = item.title
        axc_pushViewController(vc)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = dataList.axc_objAtIdx(section)
        return group?.group.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let group = dataList.axc_objAtIdx(indexPath.section) else { return cell }
        guard let item = group.group.axc_objAtIdx(indexPath.row) else { return cell }
        cell.textLabel?.text = item.title
        return cell
    }
}
