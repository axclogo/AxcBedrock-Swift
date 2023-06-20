//
//  AxcUIScrollViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/21.
//

import UIKit

// MARK: - 数据转换
public extension UIScrollView {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 类方法/属性
public extension UIScrollView {
    // MARK: 协议
    // MARK: 扩展
}

// MARK: - 属性 & Api
public extension UIScrollView {
    /// 滑动
    /// - Parameters:
    ///   - direction: 滑动方位
    ///   - animated: 是否动画
    func axc_scroll(_ direction: AxcDirection, animated: Bool = true) {
        var scrollPoint = CGPoint.zero
        if direction == .top    { scrollPoint = CGPoint(( contentOffset.x, 0)) }
        if direction == .left   { scrollPoint = CGPoint(( 0, contentOffset.y)) }
        if direction == .bottom { scrollPoint = CGPoint(( 0, contentSize.height - axc_height)) }
        if direction == .right  { scrollPoint = CGPoint(( contentSize.width - axc_width, 0)) }
        if direction == .center  { scrollPoint = CGPoint(( (contentSize.width - axc_width) / 2, (contentSize.height - axc_height) / 2)) }
        setContentOffset(scrollPoint, animated: animated)
    }
}

// MARK: - 决策判断
public extension UIScrollView {
    /// 是否在顶部
    var axc_isScrollTop: Bool { return contentOffset.y == 0 }
    /// 是否在左边
    var axc_isScrollLeft: Bool { return contentOffset.x == 0 }
    /// 是否在下部
    var axc_isScrollBottom: Bool { return contentOffset.y == (contentSize.height - axc_height) }
    /// 是否在右边
    var axc_isScrollRight: Bool { return contentOffset.x == (contentSize.width - axc_width) }
    /// 是否在中间
    var axc_isScrollCenter: Bool { return (contentOffset.x == ((contentSize.width - axc_width) / 2) &&
                                            contentOffset.y == ((contentSize.height - axc_height) / 2)) }
}


// MARK: - 代理转Block
private var kaxc_scrollDelegate = "kaxc_scrollDelegate"
public extension UIScrollView {
    /// 返回UIScrollView的Block声明
    typealias AxcBlock<T> = (UIScrollView) -> T
    /// 返回UIScrollView,Bool的Block声明
    typealias AxcBoolBlock<T> = (UIScrollView,Bool) -> T
    /// 返回UIScrollView,CGPoint,UnsafeMutablePointer<CGPoint>的Block声明
    typealias AxcPointPointerPointBlock<T> = (UIScrollView,CGPoint,UnsafeMutablePointer<CGPoint>) -> T
    /// 返回UIScrollView,UIView的Block声明
    typealias AxcViewBlock<T> = (UIScrollView,UIView?) -> T
    /// 返回UIScrollView,UIView,CGFloat的Block声明
    typealias AxcViewFloatBlock<T> = (UIScrollView,UIView?,CGFloat) -> T
    
    /// 代理桥接者
    var axc_scrollDelegate: AxcScrollDelegate {
        set { AxcRuntime.setObj(self, &kaxc_scrollDelegate, newValue) }
        get {
            guard let scrollDelegate: AxcScrollDelegate  = AxcRuntime.getObj(self, &kaxc_scrollDelegate)
            else {
                let scrollDelegate = AxcScrollDelegate()
                self.axc_scrollDelegate = scrollDelegate
                delegate = scrollDelegate
                return scrollDelegate
            }
            return scrollDelegate
        }
    }
    /// 块设置代理方法
    /// - Parameter block: block
    func axc_makeScrollDelegate(_ block: (AxcScrollDelegate) -> Void) {
        block(axc_scrollDelegate)
    }
}

// MARK: 桥接者
/// 代理转Block桥接者
open class AxcScrollDelegate: NSObject, UIScrollViewDelegate {
    ///  any offset changes
    @discardableResult
    open func axc_setScrollViewDidScrollBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewDidScrollBlock = block
        return self
    }
    open lazy var axc_scrollViewDidScrollBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewDidScrollBlock(scrollView)
    }
    
    
    ///  any zoom scale changes
    @discardableResult
    open func axc_setScrollViewDidZoomBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewDidZoomBlock = block
        return self
    }
    open lazy var axc_scrollViewDidZoomBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewDidZoom(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewDidZoomBlock(scrollView)
    }
    
    
    /// optional func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    @discardableResult
    open func axc_setScrollViewWillBeginDraggingBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewWillBeginDraggingBlock = block
        return self
    }
    open lazy var axc_scrollViewWillBeginDraggingBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewWillBeginDraggingBlock(scrollView)
    }
    
    
    /// optional func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    @discardableResult
    open func axc_setScrollViewWillEndDraggingWithVelocityTargetContentOffsetBlock(_ block: @escaping UIScrollView.AxcPointPointerPointBlock<Void>) -> Self {
        axc_scrollViewWillEndDraggingWithVelocityTargetContentOffsetBlock = block
        return self
    }
    open lazy var axc_scrollViewWillEndDraggingWithVelocityTargetContentOffsetBlock: UIScrollView.AxcPointPointerPointBlock<Void>
        = { _,_,_ in  }
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Void {
         axc_scrollViewWillEndDraggingWithVelocityTargetContentOffsetBlock(scrollView,velocity,targetContentOffset)
    }
    
    
    /// optional func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    @discardableResult
    open func axc_setScrollViewDidEndDraggingWillDecelerateBlock(_ block: @escaping UIScrollView.AxcBoolBlock<Void>) -> Self {
        axc_scrollViewDidEndDraggingWillDecelerateBlock = block
        return self
    }
    open lazy var axc_scrollViewDidEndDraggingWillDecelerateBlock: UIScrollView.AxcBoolBlock<Void>
        = { _,_ in  }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) -> Void {
         axc_scrollViewDidEndDraggingWillDecelerateBlock(scrollView,decelerate)
    }
    
    
    ///  called on finger up as we are moving
    @discardableResult
    open func axc_setScrollViewWillBeginDeceleratingBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewWillBeginDeceleratingBlock = block
        return self
    }
    open lazy var axc_scrollViewWillBeginDeceleratingBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewWillBeginDeceleratingBlock(scrollView)
    }
    
    
    ///  called when scroll view grinds to a halt
    @discardableResult
    open func axc_setScrollViewDidEndDeceleratingBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewDidEndDeceleratingBlock = block
        return self
    }
    open lazy var axc_scrollViewDidEndDeceleratingBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewDidEndDeceleratingBlock(scrollView)
    }
    
    
    ///  called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    @discardableResult
    open func axc_setScrollViewDidEndScrollingAnimationBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewDidEndScrollingAnimationBlock = block
        return self
    }
    open lazy var axc_scrollViewDidEndScrollingAnimationBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewDidEndScrollingAnimationBlock(scrollView)
    }
    
    
    ///  return a view that will be scaled. if delegate returns nil, nothing happens
    @discardableResult
    open func axc_setViewForZoomingInBlock(_ block: @escaping UIScrollView.AxcBlock<UIView?>) -> Self {
        axc_viewForZoomingInBlock = block
        return self
    }
    open var axc_viewForZoomingInBlock: UIScrollView.AxcBlock<UIView?>
        = { _ in return nil }
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return axc_viewForZoomingInBlock(scrollView)
    }
    
    
    ///  called before the scroll view begins zooming its content
    @discardableResult
    open func axc_setScrollViewWillBeginZoomingWithBlock(_ block: @escaping UIScrollView.AxcViewBlock<Void>) -> Self {
        axc_scrollViewWillBeginZoomingWithBlock = block
        return self
    }
    open lazy var axc_scrollViewWillBeginZoomingWithBlock: UIScrollView.AxcViewBlock<Void>
        = { _,_ in  }
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) -> Void {
         axc_scrollViewWillBeginZoomingWithBlock(scrollView,view)
    }
    
    
    ///  scale between minimum and maximum. called after any 'bounce' animations
    @discardableResult
    open func axc_setScrollViewDidEndZoomingWithAtScaleBlock(_ block: @escaping UIScrollView.AxcViewFloatBlock<Void>) -> Self {
        axc_scrollViewDidEndZoomingWithAtScaleBlock = block
        return self
    }
    open lazy var axc_scrollViewDidEndZoomingWithAtScaleBlock: UIScrollView.AxcViewFloatBlock<Void>
        = { _,_,_ in  }
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) -> Void {
         axc_scrollViewDidEndZoomingWithAtScaleBlock(scrollView,view,scale)
    }
    
    
    ///  return a yes if you want to scroll to the top. if not defined, assumes YES
    @discardableResult
    open func axc_setScrollViewShouldScrollToTopBlock(_ block: @escaping UIScrollView.AxcBlock<Bool>) -> Self {
        axc_scrollViewShouldScrollToTopBlock = block
        return self
    }
    open lazy var axc_scrollViewShouldScrollToTopBlock: UIScrollView.AxcBlock<Bool>
        = { _ in return true }
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return axc_scrollViewShouldScrollToTopBlock(scrollView)
    }
    
    
    ///  called when scrolling animation finished. may be called immediately if already at top
    @discardableResult
    open func axc_setScrollViewDidScrollToTopBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewDidScrollToTopBlock = block
        return self
    }
    open lazy var axc_scrollViewDidScrollToTopBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewDidScrollToTopBlock(scrollView)
    }
    
    
    /// optional func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView)
    @available(iOS 11.0, *)
    @discardableResult
    open func axc_setScrollViewDidChangeAdjustedContentInsetBlock(_ block: @escaping UIScrollView.AxcBlock<Void>) -> Self {
        axc_scrollViewDidChangeAdjustedContentInsetBlock = block
        return self
    }
    open lazy var axc_scrollViewDidChangeAdjustedContentInsetBlock: UIScrollView.AxcBlock<Void>
        = { _ in  }
    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) -> Void {
         axc_scrollViewDidChangeAdjustedContentInsetBlock(scrollView)
    }
}
