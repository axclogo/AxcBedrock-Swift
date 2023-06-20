//
//  AxcPageScrollView.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/25.
//

import UIKit

/// 代理回调
public protocol AxcPageScrollViewDelegate {
    /// 开始拖动
    func axc_pageScrollViewWillBeginDragging(_ scrollView: UIScrollView)
    /// 结束滑动
    func axc_pageScrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    /// 结束拖动
    func axc_pageScrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    /// 切面切换滑动
    func axc_pageScrollViewDidScroll(_ scrollView: UIScrollView)
}

open class AxcPageScrollView: AxcBaseView {
    open override func makeUI() {
        addSubview(collectionView)
    }
    
    // MARK: - 父类重写
    open override func layoutSubviews() {
        super.layoutSubviews()
        reloadData()
    }
    
    // MARK: - Api
    /// 代理
    open var axc_delegate: AxcPageScrollViewDelegate?
    /// 设置标题视图
    /// - Parameters:
    ///   - view: 标题视图
    ///   - height: 标题视图高度
    open func axc_setTitle(_ view: UIView? = nil, height: CGFloat) {
        if let titleView = view { // 有titleView
            titleView.removeFromSuperview()
            addSubview(titleView)
        }
        // 更新约束
        view?.axc.remakeConstraints({ (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(height)
        })
        collectionView.axc.remakeConstraints { (make) in
            make.top.equalTo(height)
            make.left.bottom.right.equalTo(0)
        }
    }
    /// 设置VC组
    /// - Parameter vcList: vc列表
    open func axc_setPages(_ vcList: [AxcPageItemVC]) {
        self.vcList = vcList
        reloadData()
    }
    /// 获取VC组
    open func axc_getPages() -> [AxcPageItemVC] {
        return vcList
    }
    /// 选中到指定索引
    open func axc_selectedIdx(_ idx: Int, animated: Bool = true) {
        let offset = idx.axc_cgFloat * collectionView.axc_width
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: animated)
    }
    /// 选中索引
    open var axc_selectedIdx: Int = 0 {
        didSet { axc_selectedIdx(axc_selectedIdx, animated: false) }
    }
    /// 刷新数据
    open func reloadData() {
        collectionView.reloadData()
    }
    
    // MARK: - 私有
    private var titleView: UIView?
    private var vcList: [AxcPageItemVC] = []
    
    // MARK: - 懒加载
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        return layout
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(layout: layout, delegate: self, dataSource: self,
                                              registers: [AxcRegisterStruct(AxcPageScrollViewControlerCell.self, useNib: false )])
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
}

extension AxcPageScrollView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 大小
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.axc_size
    }
    // 数量
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vcList.count
    }
    // cell
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let original_cell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AxcClassFromString(AxcPageScrollViewControlerCell.self), for: indexPath)
                as? AxcPageScrollViewControlerCell else { return original_cell }
        if let vc = vcList.axc_objAtIdx(indexPath.row) {    // 安全
            cell.axc_setPageVC( vc )
        }
        return cell
    }
    
    // MARK: - 代理
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        axc_delegate?.axc_pageScrollViewWillBeginDragging(scrollView)
    }
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        axc_delegate?.axc_pageScrollViewDidEndDecelerating(scrollView)
    }
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        axc_delegate?.axc_pageScrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        axc_delegate?.axc_pageScrollViewDidScroll(scrollView)
    }
}

class AxcPageScrollViewControlerCell: AxcBaseCollectionCell {
    // 内容视图
    func axc_setPageVC(_ vc: AxcPageItemVC) {
        if let _pageVC = pageVC { _pageVC.view.removeFromSuperview() }
        addSubview(vc.view)
        vc.view.axc.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        pageVC = vc
    }
    // 内容视图的指针
    var pageVC: AxcPageItemVC? = nil
}
