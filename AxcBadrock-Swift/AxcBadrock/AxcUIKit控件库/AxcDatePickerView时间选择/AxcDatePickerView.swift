//
//  AxcDatePickerView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/28.
//

import UIKit

// MARK: - AxcDatePickerView
/// Axc时间选择
@IBDesignable
open class AxcDatePickerView: AxcChooseView {
    // MARK: - Api
    // MARK: UI
    /// 显示选择时间类型
    open var axc_datePickerMode: UIDatePicker.Mode = .date { didSet { datePicker.datePickerMode = axc_datePickerMode } }
    
    /// 最小选择时间
    open var axc_minimumDate: Date? = nil { didSet { datePicker.minimumDate = axc_minimumDate } }
    
    /// 最大选择时间
    open var axc_maximumDate: Date? = nil { didSet { datePicker.maximumDate = axc_maximumDate } }
    
    // MARK: 其他属性
    /// 选中的时间
    open var axc_date: Date = Date() { didSet { datePicker.date = axc_date } }
    
    // MARK: - 回调
    // MARK: Block回调
    /// 选中的回调
    open var axc_selectedBlock: ((_ pickerView: AxcDatePickerView,
                                    _ date: Date) -> Void)
        = { (picker,date) in
            let className = AxcClassFromString(self)
            AxcLog("[可选]未设置\(className)的点击回调\n\(className): \(picker)\nDate:\(date)", level: .action)
        }
    
    // MARK: - 父类重写
    // MARK: 视图父类
    /// 配置
    open override func config() {
        super.config()
        // 日期变化
        datePicker.axc_addEvent(.valueChanged) { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.axc_date = weakSelf.datePicker.date
            weakSelf.axc_selectedBlock(weakSelf, weakSelf.axc_date)
        }
    }
    /// 设置UI
    open override func makeUI() {
        super.makeUI()
        
        reloadLayout()
    }
    /// 刷新布局
    open override func reloadLayout() {
        super.reloadLayout()
        datePicker.axc.remakeConstraints { (make) in
            make.top.equalTo(axc_titleView.axc.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
    /// 重写父类回调
    override open func btnAction(_ direction: AxcDirection, sender: AxcButton) {
        if direction == .right { // 右边按钮
            axc_selectedBlock(self, axc_date)
        }
    }
    
    // MARK: - 懒加载
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        if AxcLanguageManager.localeLanguage() == .zh_Hans {
            datePicker.locale = Locale(identifier: "zh_CN")
        }else{
            datePicker.locale = .current
        }
        datePicker.timeZone = TimeZone(secondsFromGMT: 8)
        datePicker.date = axc_date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        addSubview(datePicker)
        return datePicker
    }()
}
