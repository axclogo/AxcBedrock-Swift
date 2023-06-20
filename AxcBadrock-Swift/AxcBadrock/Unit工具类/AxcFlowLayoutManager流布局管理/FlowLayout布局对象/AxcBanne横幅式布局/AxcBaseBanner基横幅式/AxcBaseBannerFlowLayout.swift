//
//  AxcBaseBannerFowLayout.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/10.
//

import UIKit
/**
 布局架构说明：
┌────────────┬──────────────────────────────────┐
│ headerView │           Horizontal             │
├────────────┼┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┬┈┈┈┈┈┈┈┈┈┈┈┈┤
│            ┊         top         ┊            │
│            ┊     ┌─────────┐     ┊            │
│  Vertical  ┊left │  items  │right┊  Vertical  │
│            ┊     └─────────┘     ┊            │
│            ┊        bottom       ┊            │
├────────────┴┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┼────────────┤
│              Horizontal          │ footerView │
└──────────────────────────────────┴────────────┘
 
 items 框内是每组的item，继承该布局的子类只需要关注item的绝对坐标即可
 本基类会自动计算footer header 以及距离四周边距的距离
 每组items的起始坐标是0，0，并不需要关心滑动偏移量是多少，本基类也会自动计算进行平铺
 
 */

/**
 横幅式定位为：
 仅有一组
 一页中展示一组中的一个元素
 */
class AxcBaseBannerFlowLayout: AxcBaseFlowLayout {

}
