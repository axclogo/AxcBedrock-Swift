//
//  AxcUIViewEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/8.
//

#if canImport(UIKit)

import UIKit

// MARK: - 数据转换

public extension AxcSpace where Base: UIView {
    /// 截图，生成UIImage
    /// - Parameters:
    ///   - opaque: 是否透明，不透明可以优化处理速度
    ///   - scale: 缩放
    func screenshot(opaque: Bool = false,
                    scale: CGFloat = UIScreen.main.scale,
                    useViewDrawing: Bool = false) -> UIImage? {
        let size = base.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        ctx.saveGState()
        ctx.scaleBy(x: 1, y: 1)
        if useViewDrawing, base.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
            // afterScreenUpdates true:包含最近的屏幕更新内容 false:不包含刚加入视图层次但未显示的内容
            base.drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)
        } else {
            base.layer.render(in: ctx)
        }
        ctx.restoreGState()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: - 类方法

public extension AxcSpace where Base: UIView { }

// MARK: - 属性 & Api

public extension AxcSpace where Base: UIView {
    /// 在主线程添加视图
    /// - Parameter view: 视图
    func addSubview(_ view: UIView) {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.addSubview(view)
        }
    }

    /// 在主线程从父视图移除自己
    func removeFromSuperview() {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.removeFromSuperview()
        }
    }

    /// 在主线程移除所有子视图
    func removeAllSubviews() {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.subviews.forEach {
                $0.removeFromSuperview()
            }
        }
    }

    /// 获取视图所在的控制器
    var parentVC: UIViewController? {
        weak var parentResponder: UIResponder? = base
        while parentResponder != nil {
            if let _parentResponder = parentResponder?.next,
               let vc = _parentResponder as? UIViewController {
                return vc
            }
        }
        return nil
    }
}

// MARK: - 手势相关

public extension AxcSpace where Base: UIView {
    /// 添加一组手势
    func addGestureRecs(_ gestureRecognizers: [UIGestureRecognizer]) {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            for recognizer in gestureRecognizers {
                weakSelf.base.addGestureRecognizer(recognizer)
            }
        }
    }

    /// 移除一组手势
    func removeGestureRecs(_ gestureRecognizers: [UIGestureRecognizer]) {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            for recognizer in gestureRecognizers {
                weakSelf.base.removeGestureRecognizer(recognizer)
            }
        }
    }

    /// 移除所有手势
    func removeAllGestureRecognizers() {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.gestureRecognizers?.forEach {
                weakSelf.base.removeGestureRecognizer($0)
            }
        }
    }

    /// 添加任意一种手势
    func addGesture<T: UIGestureRecognizer>(_ gestureRec: T) -> T {
        AxcGCD.Main { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.base.isUserInteractionEnabled = true
            weakSelf.base.addGestureRecognizer(gestureRec)
        }
        return gestureRec
    }

    /// 点击手势
    /// - Parameters:
    ///   - numberOfTapsRequired: 点击次数，默认1
    ///   - actionBlock: 事件回调
    /// - Returns: UITapGestureRecognizer
    @discardableResult
    func addTapGesture(numberOfTapsRequired: Int = 1,
                       actionBlock: @escaping AxcBlock.Action<UITapGestureRecognizer>)
        -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer.Axc.Create(actionBlock)
        tap.numberOfTapsRequired = numberOfTapsRequired
        return addGesture(tap)
    }

    /// 长按手势
    /// - Parameters:
    ///   - minimumPressDuration: 长按时间，默认0.5
    ///   - actionBlock: 事件回调
    /// - Returns: UILongPressGestureRecognizer
    @discardableResult
    func addLongPressGesture(minimumPressDuration: AxcUnifiedNumber = 0.5,
                             actionBlock: @escaping AxcBlock.Action<UILongPressGestureRecognizer>)
        -> UILongPressGestureRecognizer {
        let long = UILongPressGestureRecognizer.Axc.Create(actionBlock)
        long.minimumPressDuration = assertTransformDouble(minimumPressDuration)
        return addGesture(long)
    }

    /// 滑动手势 默认添加右滑手势
    /// - Parameters:
    ///   - direction: 滑动方向，默认
    ///   - actionBlock: 事件回调
    /// - Returns: UISwipeGestureRecognizer
    @discardableResult
    func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction = .right,
                         actionBlock: @escaping AxcBlock.Action<UISwipeGestureRecognizer>)
        -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer.Axc.Create(actionBlock) // 同一个手势只能指定一个方向
        swipe.direction = direction
        return addGesture(swipe)
    }

    /// 拖动手势 可不传Block，默认实现拖动功能
    /// - Parameters:
    ///   - minimumNumberOfTouches: 最小触点数，默认1
    ///   - actionBlock: 事件回调
    /// - Returns: UISwipeGestureRecognizer
    @discardableResult
    func addPanGesture(minimumNumberOfTouches: Int = 1,
                       actionBlock: AxcBlock.Action<UIPanGestureRecognizer>? = nil)
        -> UIPanGestureRecognizer {
        var panGes: UIPanGestureRecognizer = .init()
        if let block = actionBlock {
            panGes = .Axc.Create(block)
        } else {
            panGes = .Axc.Create { [weak self] (pan) in
                guard let weakSelf = self else { return }
                let translation = pan.translation(in: weakSelf.base)
                guard let panView = pan.view else { return }
                weakSelf.base.center = CGPoint(x: panView.center.x + translation.x,
                                               y: panView.center.y + translation.y)
                pan.setTranslation(CGPoint.zero, in: weakSelf.base) // 归零
            }
        }
        panGes.minimumNumberOfTouches = minimumNumberOfTouches
        return addGesture(panGes)
    }

    /// 捏合手势 可不传Block，默认实现缩放功能
    /// - Parameters:
    ///   - minScale: 最小缩放临界比
    ///   - maxScale: 最大缩放临界比
    ///   - animtionDuration: 最大缩放临界比
    ///   - actionBlock: 触发回调
    /// - Returns: UIPinchGestureRecognizer
    @discardableResult
    func addPinchGesture(minScale: AxcUnifiedNumber = 0.5,
                         maxScale: AxcUnifiedNumber = 2,
                         animtionDuration: AxcUnifiedNumber = 0.3,
                         actionBlock: AxcBlock.Action<UIPinchGestureRecognizer>? = nil)
        -> UIPinchGestureRecognizer {
        let minScale = assertTransformDouble(minScale)
        let maxScale = assertTransformDouble(maxScale)
        let animtionDuration = assertTransformDouble(animtionDuration)
        var pinch: UIPinchGestureRecognizer = .init()
        if let block = actionBlock {
            pinch = .Axc.Create(block)
        } else {
            pinch = .Axc.Create() { [weak self] (pinch) in
                guard let weakSelf = self else { return }
                if pinch.state == .changed {
                    guard let pinchView = pinch.view else { return }
                    weakSelf.base.transform = pinchView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
                    pinch.scale = 1
                } else if pinch.state == .ended {
                    UIView.animate(withDuration: animtionDuration) {
                        if weakSelf.base.transform.a < minScale ||
                            weakSelf.base.transform.d < minScale { // 最小缩放临界
                            weakSelf.base.transform = CGAffineTransform(scaleX: minScale, y: minScale)
                        }
                        if weakSelf.base.transform.a > maxScale ||
                            weakSelf.base.transform.d > maxScale { // 最大缩放临界
                            weakSelf.base.transform = CGAffineTransform(scaleX: maxScale, y: maxScale)
                        }
                    }
                }
            }
        }
        return pinch
    }

    /// 旋转手势 可不传Block，默认实现旋转功能
    /// - Parameters:
    ///   - actionBlock: 触发回调
    /// - Returns: UIRotationGestureRecognizer
    @discardableResult
    func addRotationGesture(actionBlock: AxcBlock.Action<UIRotationGestureRecognizer>? = nil) -> UIRotationGestureRecognizer {
        var rota: UIRotationGestureRecognizer = .init()
        if let block = actionBlock {
            rota = .Axc.Create(block)
        } else {
            rota = .Axc.Create() { [weak self] (rotation) in
                guard let weakSelf = self else { return }
                if rotation.state == .changed {
                    guard let rotationView = rotation.view else { return }
                    weakSelf.base.transform = rotationView.transform.rotated(by: rotation.rotation)
                    rotation.rotation = 0 // 归零
                }
            }
        }
        return rota
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base: UIView { }

#endif

//#if canImport(Metal)
//
//import Metal
//import MetalKit
//
//public extension AxcSpace where Base: UIView {
//    /// 截图，生成UIImage
//    func screenshotUsingMetal() -> UIImage? {
//        // 创建一个Metal设备
//        guard let device = MTLCreateSystemDefaultDevice() else {
//            print("Metal is not supported on this device")
//            return nil
//        }
//
//        // 创建一个Metal渲染目标
//        let renderPassDescriptor = MTLRenderPassDescriptor()
//        guard let textureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .bgra8Unorm, width: Int(base.bounds.width), height: Int(base.bounds.height), mipmapped: false) else {
//            print("Failed to create texture descriptor")
//            return nil
//        }
//        guard let texture = device.makeTexture(descriptor: textureDescriptor) else {
//            print("Failed to create texture")
//            return nil
//        }
//        renderPassDescriptor.colorAttachments[0].texture = texture
//        renderPassDescriptor.colorAttachments[0].loadAction = .clear
//        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 0)
//
//        // 创建一个Metal渲染目标视图
//        guard let metalView = MTKView(frame: base.bounds, device: device) else {
//            print("Failed to create Metal view")
//            return nil
//        }
//        metalView.framebufferOnly = true
//        metalView.enableSetNeedsDisplay = false
//        metalView.device = device
//        metalView.delegate = self
//
//        // 将UIView添加到Metal渲染目标视图中
//        metalView.addSubview(base)
//
//        // 使用Metal渲染目标视图渲染
//        let commandQueue = device.makeCommandQueue()
//        let commandBuffer = commandQueue?.makeCommandBuffer()
//        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
//        renderEncoder?.endEncoding()
//        commandBuffer?.present(metalView.currentDrawable!)
//        commandBuffer?.commit()
//        commandBuffer?.waitUntilCompleted()
//
//        // 将Metal渲染目标转换为UIImage
//        let image = metalView.currentDrawable?.texture.toUIImage()
//
//        return image
//    }
//}
//#endif
