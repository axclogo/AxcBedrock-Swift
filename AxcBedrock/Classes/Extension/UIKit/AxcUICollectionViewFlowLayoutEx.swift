//
//  AxcUICollectionViewFlowLayoutEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/3/4.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UICollectionViewFlowLayout {}

// MARK: - 类方法

public extension AxcSpace where Base: UICollectionViewFlowLayout {
    /// 创建一个网格布局
    /// - Parameters:
    ///   - scrollDirection: 滑动方向
    ///   - minimumLineSpacing: 滑动方向的item最小间距
    ///   - minimumInteritemSpacing: 垂直于滑动方向的item最小间距
    ///   - itemSize: item大小
    ///   - sectionInset: 每组item的边距
    /// - Returns: UICollectionViewFlowLayout
    static func CreateGridLayout(scrollDirection: UICollectionView.ScrollDirection,
                                 minimumLineSpacing: AxcUnifiedNumber,
                                 minimumInteritemSpacing: AxcUnifiedNumber,
                                 sectionInset: UIEdgeInsets = .zero,
                                 itemSize: CGSize = 1.axc.cgSize) -> UICollectionViewFlowLayout
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = scrollDirection
        flowLayout.minimumLineSpacing = CGFloat.Axc.Create(minimumLineSpacing)
        flowLayout.minimumInteritemSpacing = CGFloat.Axc.Create(minimumInteritemSpacing)
        flowLayout.sectionInset = sectionInset
        flowLayout.itemSize = itemSize
        return flowLayout
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: UICollectionViewFlowLayout {}

// MARK: - 决策判断

public extension AxcSpace where Base: UICollectionViewFlowLayout {}

#endif
