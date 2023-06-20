//
//  AxcCameraView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/12.
//

import UIKit
import AVFoundation

public class AxcCameraView: AxcBaseView {
    // MARK: - 初始化
    // MARK: - Api
    // MARK: UI属性
    var axc_contentInset: UIEdgeInsets = UIEdgeInsets(5) { didSet { reloadLayout() } }
    
    
    // MARK: 其他属性
    // MARK: 方法
    func axc_start() {
//        manager.axc_start(axc_contentView)
    }
    func axc_stop() {
//        manager.axc_stop()
    }
    /// 拍摄
    /// - Parameter block: 返回图片
//    func axc_shooting(_ block: @escaping AxcCameraManager.AxcShootingBlock ) {
//        manager.axc_shooting(block)
//    }
    
    // MARK: - 回调
    // MARK: Block回调
    // MARK: func回调
    // MARK: - 私有
    // MARK: 复用
    // MARK: - 子类实现
    // MARK: - 父类重写
    // MARK: 视图父类
    open override func config() {
        super.config()
    }
    open override func makeUI() {
        super.makeUI()
    }
    open override func reloadLayout() {
        axc_contentView.axc.remakeConstraints { (make) in
            make.edges.equalTo(axc_contentInset)
        }
    }
    
    // MARK: 超类&抽象类
    
    // MARK: - 懒加载
    lazy var manager: AxcCameraManager = {
        let manager = AxcCameraManager()
        return manager
    }()
    // MARK: 预设控件
    // MARK: 基础控件
    lazy var axc_contentView: AxcBaseView = {
        let view = AxcBaseView()
        addSubview(view)
        return view
    }()
    // MARK: 私有控件
    
}
