//
//  AxcUrlConfigVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/15.
//
import UIKit
class AxcUrlConfigVC: AxcBaseVC {
    // 创建UI
    override func makeUI() {
        title = "环境切换"
        tableView.axc_remakeConstraintsFill() // 全填充
    }
    // 点击选择切换
    func didSelectRow(_ module: AxcUrlConfigModule, model: AxcEnvironmentType) {
        let msg = "请选择\(model.environmentKey)要切换的地址"
        let titles = model.standbyUrls.map{ "\($0.title): \($0.url)" }
        let alentVC = UIAlertController(title: module.name,
                                        msg: msg,
                                        actionTitles: titles,
                                        cancelTitle: AxcBadrockLanguage("取消"),
                                        style: .actionSheet)
        { [weak self] (sender) in
            guard let weakSelf = self,
                  let action = sender as? UIAlertAction
            else { return }
            weakSelf.urlConfig.axc_switchStandbyUrl(module.identifier,
                                                    environmentKey: model.environmentKey,
                                                    idx: action.axc_intTag)
            weakSelf.tableView.reloadData()
        }
        axc_presentViewController(alentVC)
    }
    
    // Url配置器
    var urlConfig = AxcUrlConfig.shared
    // MARK: - 懒加载
    lazy var tableDelegate: AxcTableDelegate = {
        let delegate = AxcTableDelegate()
            // 组标题
            .axc_setTableViewViewForHeaderInSectionBlock { [weak self] (tableView, section) -> UIView? in
                guard let weakSelf = self,
                      let module = weakSelf.urlConfig.axc_netModules.axc_objAtIdx(section),
                      let tuples = module.currentUrl
                else { return nil }
                var attTitle =
                    "\(module.name)".axc_attributedStr(color: UIColor.black, font: 16.axc_font(weight: .bold)) +
                    " -(\(tuples.title))".axc_attributedStr(color: UIColor.gray, font: 14.axc_font(weight: .medium)) +
                    "\n当前地址: ".axc_attributedStr(color: UIColor.gray, font: 14.axc_font) +
                    "\(tuples.url) ".axc_attributedStr(color: UIColor.systemBlue, font: 12.axc_font)
                attTitle = attTitle.axc_setParagraphStyle(NSMutableParagraphStyle().axc_setLineSpacing(5))
                let label = AxcBaseLabel(attTitle)
                label.axc_contentInset = 10.axc_uiEdgeLeft
                label.axc_contentAlignment = .left
                label.backgroundColor = .groupTableViewBackground
                return label
            }
            // 点击切换
            .axc_setTableViewDidSelectRowAtBlock { [weak self] (tableView, indexPath) in
                guard let weakSelf = self else { return }
                AxcVibrationManager.axc_playVibration(.light)
                tableView.deselectRow(at: indexPath, animated: true)
                guard let module = weakSelf.urlConfig.axc_netModules.axc_objAtIdx(indexPath.section),
                      let environment = module.environment.axc_objAtIdx(indexPath.row)
                else { return }
                weakSelf.didSelectRow(module, model: environment)
            }
        return delegate
    }()
    lazy var tableDataSource: AxcTableDataSource = {
        let dataSource = AxcTableDataSource()
            // 组数量
            .axc_setNumberOfSectionsInBlock { [weak self] (_) -> Int in
                guard let weakSelf = self else { return 0 }
                return weakSelf.urlConfig.axc_netModules.count
            }
            // 每组数量
            .axc_setTableViewNumberOfRowsInSectionBlock { [weak self] (_, section) -> Int in
                guard let weakSelf = self,
                      let module = weakSelf.urlConfig.axc_netModules.axc_objAtIdx(section)
                else { return 0 }
                return module.environment.count
            }
            // cell设置
            .axc_setTableViewCellForRowAtBlock { [weak self] (tableView, indexPath) -> UITableViewCell in
                let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.axc_className)
                guard let weakSelf = self,
                      let module = weakSelf.urlConfig.axc_netModules.axc_objAtIdx(indexPath.section),
                      let environment = module.environment.axc_objAtIdx(indexPath.row)
                else { return cell }
                var isSelected = false
                environment.standbyUrls.forEach{
                    if $0.url == module.currentUrl?.url {
                        isSelected = true; return
                    }
                }
                cell.textLabel?.text = "\(environment.environmentKey)  \(isSelected ? "✅" : "")"
                let detailText = "备用线路: \(environment.standbyUrls.count)"
                cell.detailTextLabel?.text = detailText
                cell.detailTextLabel?.font = 12.axc_font
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        return dataSource
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView(style: .plain)
        tableView.axc_dataSource = tableDataSource
        tableView.axc_tableDelegate = tableDelegate
        tableView.sectionHeaderHeight = 60
        axc_addSubView(tableView)
        return tableView
    }()
}
