//
//  AxcUIViewEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/16.
//

import UIKit

// MARK: - 数据转换
public extension UIView {
    /// 对视图进行截图，转换成Image
    var axc_screenshot: UIImage? {
        return axc_screenshot(layer.frame)
    }
    /// 对视图部分区域进行截图，转换成Image
    func axc_screenshot(_ rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.axc_size, false, Axc_screen.scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        UIRectClip(layer.frame)
        layer.render(in: context)
        let uiImage = UIGraphicsGetImageFromCurrentImageContext()
        if rect == layer.frame { return uiImage } // 如果是全大小，则直接输出
        guard let cgImage = uiImage?.axc_cgImage?.axc_cropping(rect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

// MARK: - 类方法/属性
public extension UIView {
    /// 实例化一个比superView小的边距
    /// - Parameters:
    ///   - superView: superView
    ///   - spacing: 边距
    convenience init(superView: UIView, spacing: CGFloat = 0) {
        self.init(CGRect(x: superView.axc_x + spacing,
                         y: superView.axc_y + spacing,
                         width: superView.axc_width - spacing*2,
                         height: superView.axc_height - spacing*2))
    }
    
    /// 直接rect(CGFloat)实例化
    convenience init(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        self.init(CGRect(x,y,w,h))
    }
    /// 直接rect(Float)实例化
    convenience init(_ x: Float, _ y: Float, _ w: Float, _ h: Float) {
        self.init(CGRect(x,y,w,h))
    }
    /// 直接rect(Double)实例化
    convenience init(_ x: Double, _ y: Double, _ w: Double, _ h: Double) {
        self.init(CGRect(x,y,w,h))
    }
    /// 直接rect(Int)实例化
    convenience init(_ x: Int, _ y: Int, _ w: Int, _ h: Int) {
        self.init(CGRect(x,y,w,h))
    }
    
    /// 直接rect实例化
    convenience init(_ rect: CGRect) {
        self.init(frame: rect)
    }
    /// 直接size实例化
    convenience init(_ size: CGSize) {
        self.init(frame: size.axc_cgRect)
    }
    /// 直接tuples实例化
    convenience init(_ tuples: (CGFloat,CGFloat,CGFloat,CGFloat)) {
        self.init(frame: CGRect(x: tuples.0, y: tuples.1, width: tuples.2, height: tuples.3))
    }
    
    /// 调整这个视图的大小，使它适合最大的子视图
    static func axc_resizeToFitSubviews(view: UIView, ignoreTags: [Int] = []) -> CGRect {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in view.subviews {
            let aView = someView
            if !ignoreTags.contains(someView.tag) {
                let newWidth = aView.axc_x + aView.axc_width
                let newHeight = aView.axc_y + aView.axc_height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        return CGRect(x: view.axc_x, y: view.axc_y, width: width, height: height)
    }
    
    /// 背景色实例化
    convenience init(backgroundColor: AxcUnifiedColorTarget) {
        self.init()
        self.backgroundColor = backgroundColor.axc_color
    }
}

public typealias AxcCountdownBlock = (_ sender: UIView, _ countdown: Int) -> Void
public typealias AxcCountdownEndBlock = (_ sender: UIView) -> Void
// MARK: - 属性 & Api
public extension UIView {
    /// 递归，直到找到根视图
    func axc_rootView() -> UIView {
        guard let parentView = superview else { return self }
        return parentView.axc_rootView()
    }
    
    /// 获取相对于window的坐标
    var axc_convertWindowRect: CGRect {
        return axc_convertRect(window)
    }
    /// 获取相对于某视图的坐标
    func axc_convertRect(_ view: UIView?) -> CGRect {
        return convert(bounds, to: view)
    }
    
    /// 调整自己的大小，使它适合最大的子视图
    func axc_resizeToFitSubviews() {
        frame = UIView.axc_resizeToFitSubviews(view: self)
    }
    /// 调整自己的大小，使它适合最宽的子视图
    func axc_resizeToFitWidth() {
        let currentHeight = self.axc_height
        self.sizeToFit()
        self.axc_height = currentHeight
    }
    /// 调整自己的大小，使它适合最高的子视图
    func axc_resizeToFitHeight() {
        let currentWidth = self.axc_width
        self.sizeToFit()
        self.axc_width = currentWidth
    }
    
    /// 开启抗锯齿
    func axc_antialias(_ antialias: Bool = true) {
        layer.shouldRasterize = antialias
        layer.allowsEdgeAntialiasing = antialias
    }
    
    /// 添加一组视图
    func axc_addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    /// 移除所有子视图
    func axc_removeAllSubviews() {
        for subview in subviews { subview.removeFromSuperview() }
    }
    /// 隐藏所有子视图
    func axc_hiddenAllSubviews() {
        for subview in subviews { subview.isHidden = true }
    }
    /// 移除自己和子视图的第一响应
    func axc_cancleFirstResponder() {
        if isFirstResponder { resignFirstResponder() }
        subviews.forEach{ $0.resignFirstResponder() }
    }
    
    /// 设置毛玻璃背景
    /// - Parameter blurEffectStyle: 模糊样式
    /// - Returns: UIVisualEffectView
    func axc_setVisualEffect(_ blurEffectStyle: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: blurEffectStyle)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        addSubview(visualEffectView)
        visualEffectView.axc_makeConstraintsFill()
        sendSubviewToBack(visualEffectView)
    }
    
    /// 深度递归遍历所有子视图
    /// - Parameter block: 返回遍历的视图
    func axc_depthTraversalSubviews(_ block: (UIView) -> Void ) {
        subviews.forEach{
            block($0)
            $0.axc_depthTraversalSubviews(block)
        }
    }
    
    /// 打印视图所有的子视图层级
    func axc_printSubviewsLevel() {
        showSubview(self, level: 1)
    }
    private func showSubview(_ view: UIView, level: Int) {
        view.subviews.forEach{
            var blank = "|"
            for _ in 0..<level { blank += "--" }
            print("\(blank)-> 类名：\(AxcClassFromString($0)) 层级：[\(level)]")
            showSubview($0, level: level + 1)
        }
    }
    
    /// 设置倒计时
    /// - Parameters:
    ///   - duration: 倒计时长
    ///   - countdownBlock: 倒计时中回调
    ///   - endBlock: 倒计时结束
    @objc func axc_startCountdown(duration: Int,
                                  countdownBlock: AxcCountdownBlock? = nil,
                                  endBlock:AxcCountdownEndBlock? = nil) {
        var countdown = duration
        AxcGCD.timer(duration) { [weak self] in
            guard let weakSelf = self else { return }
            countdown -= 1
            countdownBlock?(weakSelf, countdown)
        } _: { [weak self] in
            guard let weakSelf = self else { return }
            endBlock?(weakSelf)
        }
    }
}

// MARK: - 动态绑定参数
/// 可读写视图对象的键
private var kaxc_vc = "kaxc_vc"
public extension UIView {
    /// 可读写视图对象
    weak var axc_vc: UIViewController? {
        get { guard let vc: UIViewController = AxcRuntime.getObj(self, &kaxc_vc) else { return nil }; return vc }
        set { AxcRuntime.setObj(self, &kaxc_vc, newValue) }
    }
    /// 生命周期自动获取最佳释放器
    var axc_autoCycle: AxcObserveCycle {
        if let _cycle = axc_currentVC?.axc_observerCycle { return _cycle }
        return axc_observerCycle
    }
}

// MARK: - 监听相关
public extension UIView {
    /// 添加Frame监听回调
    /// - Parameters:
    ///   - block: 回调
    ///   - cycle: 生命周期管理器 默认当前控制器的生命周期
    func axc_setObserverFrame(firstTrigger: Bool = false,
                              block: @escaping AxcViewBlock) -> AxcObserver {
        return axc_observer.axc_setKeyPath(.frame, firstTrigger: firstTrigger)
        { [weak self] (_, _, _, _) in
            guard let weakSelf = self else { return }
            block(weakSelf)
        }
    }
    /// 主动移除Frame监听回调
    func axc_removeObserverFrame() {
        axc_observer.axc_removeKeyPath(.frame)
    }
    
    /// 添加Subviews监听回调
    /// - Parameters:
    ///   - block: 回调
    ///   - cycle: 生命周期管理器 默认当前控制器的生命周期
    func axc_setObserverSubviews(firstTrigger: Bool = false,
                                 block: @escaping AxcViewBlock) -> AxcObserver {
        return axc_observer.axc_setKeyPath(.subviews, firstTrigger: firstTrigger)
        { [weak self] (_, _, _, _) in
            guard let weakSelf = self else { return }
            block(weakSelf)
        }
    }
    /// 主动移除Subviews监听回调
    func axc_removeObserverSubviews() {
        axc_observer.axc_removeKeyPath(.subviews)
    }
}

// MARK: 快速设置圆角阴影
public extension UIView {
    /// 快速设置阴影 支持圆角阴影
    /// - Parameters:
    ///   - offset: 阴影偏移量
    ///   - radius: 阴影圆角
    ///   - color: 阴影颜色
    ///   - opacity: 阴影透明
    ///   - cornerRadius: 圆角
    ///   - autoAdapt: 自适应状态类型
    @discardableResult
    func axc_setShadow(offset: CGSize = CGSize(width: 5, height: 5),
                       radius: CGFloat = 5,
                       color: AxcUnifiedColorTarget = UIColor.black,
                       opacity: CGFloat = 0.7,
                       cornerRadius: CGFloat? = nil,
                       autoAdapt: AxcAutoAdaptType = .none) -> UIView {
        self.axc_shadowOffset = offset
        self.axc_shadowRadius = radius
        self.axc_shadowOpacity = opacity
        self.axc_shadowColor = color.axc_color
        if let r = cornerRadius {
            switch autoAdapt {
            case .none:
                self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
            case .auto(cycle: let cycle):
                let _cycle = cycle ?? axc_autoCycle
                axc_setObserverFrame(firstTrigger: true) { (view) in
                    self.layer.shadowPath = UIBezierPath(roundedRect: view.bounds,
                                                         cornerRadius: r).cgPath
                }.axc_setCycle(_cycle)
            }
        }
        return self
    }
    
    /// 设置部分圆角，支持适配
    /// - Parameters:
    ///   - corner: 需要设置的方位
    ///   - radius: 半径
    ///   - autoAdapt: 自适应状态类型
    func axc_setCornerRadius(_ corner: UIRectCorner,
                             frame: CGRect? = nil,
                             radius: CGFloat,
                             autoAdapt: AxcAutoAdaptType = .none) {
        let maskLayer = CAShapeLayer() // 避免每次创建消耗性能
        layer.mask = maskLayer // 优化计算量
        switch autoAdapt {
        case .none:
            let maskPath = UIBezierPath(roundedRect: frame ?? bounds,
                                        byRoundingCorners: corner,
                                        cornerRadii: radius.axc_cgSize)
            maskLayer.frame = axc_size.axc_cgRect
            maskLayer.path = maskPath.cgPath
        case .auto(cycle: let cycle):
            let _cycle = cycle ?? axc_autoCycle
            axc_setObserverFrame(firstTrigger: true) { (view) in
                let maskPath = UIBezierPath(roundedRect: frame ?? view.bounds,
                                            byRoundingCorners: corner,
                                            cornerRadii: radius.axc_cgSize)
                maskLayer.frame = view.axc_size.axc_cgRect
                maskLayer.path = maskPath.cgPath
            }.axc_setCycle(_cycle)
        }
    }
    
    /// 设置最小边长为圆角，支持适配
    /// - Parameters:
    ///   - autoAdapt: 自适应状态类型
    func axc_setCornerRadiusSmaller(autoAdapt: AxcAutoAdaptType = .none) {
        switch autoAdapt {
        case .none:
            axc_cornerRadius = axc_size.axc_smaller/2.0
        case .auto(cycle: let cycle):
            let _cycle = cycle ?? axc_autoCycle
            axc_setObserverFrame(firstTrigger: true) { (view) in
                view.axc_cornerRadius = view.axc_size.axc_smaller/2.0
            }.axc_setCycle(_cycle)
        }
    }
    
    /// 设置背景色渐变 与协议方法实现不同
    /// 因部分组件，如 UILabel UIButton的layer层不同，
    /// - Parameters:
    ///   - colors: 渐变色组 默认主题渐变
    ///   - startDirection: 开始点位，支持按位或运算
    ///   - endDirection: 结束点位，支持按位或运算
    ///   - insertIndex: 渐变色图层插入索引
    ///   - locations: 比率
    ///   - type: type
    ///   - autoAdapt: 自适应状态类型
    func axc_addGradient(colors: [UIColor]? = nil,
                         startDirection: AxcDirection  = .left,
                         endDirection: AxcDirection    = .right,
                         insertIndex: UInt32 = 0,
                         locations: [CGFloat]? = nil,
                         type: CAGradientLayerType = .axial,
                         autoAdapt: AxcAutoAdaptType = .none) {
        backgroundColor = UIColor.clear // 清除背景色
        let _colors = colors ?? AxcBadrock.shared.themeGradientColors
        let gradientLayer = CAGradientLayer(colors: _colors,
                                            locations: locations,
                                            startDirection: startDirection,
                                            endDirection: endDirection,
                                            type: type)
        switch autoAdapt {
        case .none:
            layer.insertSublayer(gradientLayer, at: insertIndex)
        case .auto(cycle: let cycle):
            let _cycle = cycle ?? axc_autoCycle
            axc_setObserverFrame(firstTrigger: true) { (view) in // 监听frame
                CATransaction.begin()
                CATransaction.setAnimationDuration(0)
                gradientLayer.frame = view.axc_size.axc_cgRect
                CATransaction.commit()
            }.axc_setCycle(_cycle)
            layer.axc_setObserverSublayers(firstTrigger: true) { (layer) in // 监听layer组变化
                layer.insertSublayer(gradientLayer, at: insertIndex)
            }.axc_setCycle(_cycle)
        }
    }
}

// MARK: 背景图
public extension UIView {
    /// 设置背景图
    func axc_setBackgroundImage(_ image: UIImage) {
        layer.contents = image.cgImage
    }
}

// MARK: 徽标
private var kaxc_badgeLabel = "kaxc_badgeLabel"
public extension UIView {
    /// 徽标label控件对象
    var axc_badgeLabel: AxcBadgeLabel {
        set { AxcRuntime.setObj(self, &kaxc_badgeLabel, newValue) }
        get {   // runtime 懒加载
            guard let badgeLabel: AxcBadgeLabel = AxcRuntime.getObj(self, &kaxc_badgeLabel) else {
                let badge = AxcBadgeLabel()
                self.axc_badgeLabel = badge // set
                addSubview(badge)
                return badge
            }
            bringSubviewToFront(badgeLabel) // 每次get放置到最前
            return badgeLabel
        }
    }
    /// 设置徽标方位
    /// - Parameter direction: 方位，支持按位或运算 默认右上
    func axc_setBadgeDirection(_ direction: AxcDirection = [.top, .right]) {
        axc_badgeLabel.axc_direction = direction
    }
    /// 设置徽标的值
    func axc_setBadgeValue(_ value: String = "0" ) {
        axc_badgeLabel.text = value
    }
    /// 设置徽标的富文本值
    func axc_setBadgeValue(_ attributedStr: NSAttributedString? = nil ) {
        axc_badgeLabel.attributedText = attributedStr
    }
    /// 设置徽标的背景色
    func axc_setBadgeColor(_ color: AxcUnifiedColorTarget? = nil ) {
        let _color = color?.axc_color ?? AxcBadrock.shared.markedColor
        axc_badgeLabel.backgroundColor = _color
    }
    /// 设置徽标的渐变背景色
    func axc_setBadgeGradientColor(colors: [UIColor]? = nil,
                                   startDirection: AxcDirection = .left, endDirection: AxcDirection = .right,
                                   locations: [CGFloat]? = nil, type: CAGradientLayerType = .axial ){
        axc_badgeLabel.axc_setGradient(colors: colors,
                                       startDirection: startDirection, endDirection: endDirection,
                                       locations: locations, type: type)
    }
}

// MARK: 边框线
private var kaxc_borderLineViews = "kaxc_underLineViews"
public extension UIView {
    /// 边框线视图组
    /// 0 上，1左，2下，3右
    private var borderLineViews: [AxcBaseView] {
        set { AxcRuntime.setObj(self, &kaxc_borderLineViews, newValue) }
        get {   // runtime 懒加载
            guard let borderLine: [AxcBaseView] = AxcRuntime.getObj(self, &kaxc_borderLineViews) else {
                var _borderLine: [AxcBaseView] = []
                for idx in 0..<4 {
                    let view = AxcBaseView()
                    view.backgroundColor = AxcBadrock.shared.lineColor // 线色
                    view.tag = idx + Axc_TagStar
                    view.isHidden = true    // 默认隐藏
                    addSubview(view)
                    let lineWidth = 0.5
                    switch idx {
                    case 0: view.axc.makeConstraints { (make) in // 上
                        make.top.left.right.equalToSuperview()
                        make.height.equalTo(lineWidth)}
                    case 1: view.axc.makeConstraints { (make) in // 左
                        make.top.left.bottom.equalToSuperview()
                        make.width.equalTo(lineWidth)}
                    case 2: view.axc.makeConstraints { (make) in // 下
                        make.left.bottom.right.equalToSuperview()
                        make.height.equalTo(lineWidth)}
                    case 3: view.axc.makeConstraints { (make) in // 右
                        make.top.bottom.right.equalToSuperview()
                        make.width.equalTo(lineWidth)}
                    default: break}
                    _borderLine.append(view)
                }
                self.borderLineViews = _borderLine // set
                return _borderLine
            }
            return borderLine
        }
    }
    
    /// 获取边框线视图
    /// - Parameter direction: 选择要获取的方位
    /// - Returns: 边线视图
    func axc_getBorderLineView(_ direction: AxcDirection) -> [AxcBaseView] {
        var returnArray: [AxcBaseView] = []
        if direction.contains(.top)    { if let topView = borderLineViews.first           { returnArray.append(topView) } }
        if direction.contains(.left)   { if let leftView = borderLineViews.axc_secondObj  { returnArray.append(leftView) } }
        if direction.contains(.bottom) { if let bottomView = borderLineViews.axc_thirdObj { returnArray.append(bottomView) } }
        if direction.contains(.right)  { if let rightView = borderLineViews.axc_fourthObj { returnArray.append(rightView) } }
        return returnArray
    }
    
    /// 设置下划线的边距
    /// - Parameters:
    ///   - edge: 边距
    ///   - direction: 设置的方位
    func axc_setBorderLineInset(_ direction: AxcDirection, edge: UIEdgeInsets ){
        for idx in 0..<borderLineViews.count {
            let currentView = borderLineViews[idx]
            currentView.axc.updateConstraints { (make) in // 更新约束
                if (idx == 0) && (direction.contains(.top))    {    // 上
                    make.top.equalToSuperview().offset(edge.top)
                    make.left.equalToSuperview().offset(edge.left)
                    make.right.equalToSuperview().offset(-edge.right)
                }
                if (idx == 1) && (direction.contains(.left))   {    // 左
                    make.top.equalToSuperview().offset(edge.top)
                    make.left.equalToSuperview().offset(edge.left)
                    make.bottom.equalToSuperview().offset(-edge.bottom)
                }
                if (idx == 2) && (direction.contains(.bottom)) {    // 下
                    make.left.equalToSuperview().offset(edge.left)
                    make.bottom.equalToSuperview().offset(-edge.bottom)
                    make.right.equalToSuperview().offset(-edge.right)
                }
                if (idx == 3) && (direction.contains(.right))  {    // 右
                    make.top.equalToSuperview().offset(edge.top)
                    make.bottom.equalToSuperview().offset(-edge.bottom)
                    make.right.equalToSuperview().offset(-edge.right)
                }
            }
        }
    }
    
    /// 设置边框线
    /// - Parameter direction: 方位，默认下，支持按位或运算
    func axc_setBorderLineDirection(_ direction: AxcDirection ) {
        for idx in 0..<borderLineViews.count {
            let currentView = borderLineViews[idx]
            currentView.isHidden = true // 先默认隐藏，再根据多选的显示
            if (idx == 0) && (direction.contains(.top))    { currentView.isHidden = false } // 要显示上
            if (idx == 1) && (direction.contains(.left))   { currentView.isHidden = false } // 要显示左
            if (idx == 2) && (direction.contains(.bottom)) { currentView.isHidden = false } // 要显示下
            if (idx == 3) && (direction.contains(.right))  { currentView.isHidden = false } // 要显示右
        }
    }
    /// 隐藏全部边线
    func axc_setBorderLineHidden() {
        borderLineViews.forEach{ $0.isHidden = true }
    }
    
    /// 设置边框线的线宽
    /// - Parameters:
    ///   - width: 线宽
    ///   - direction: 方位，默认全部，支持按位或运算
    func axc_setBorderLineWidth(_ direction: AxcDirection? = nil, width: AxcUnifiedNumberTarget) {
        let width = width.axc_cgFloat
        for idx in 0..<borderLineViews.count {
            let currentView = borderLineViews[idx]
            currentView.axc.updateConstraints { (make) in // 更新约束
                if let _direction = direction { // 选择方位进行设置
                    if (idx == 0) && (_direction.contains(.top)) ||
                        (idx == 2) && (_direction.contains(.bottom)) {
                        make.height.equalTo(width)
                    }
                    if (idx == 1) && (_direction.contains(.left)) ||
                        (idx == 3) && (_direction.contains(.right)) {
                        make.width.equalTo(width)
                    }
                }else{ // 默认全部
                    let currentTag = currentView.tag - Axc_TagStar
                    if (currentTag == 0) || (currentTag == 2) {
                        make.height.equalTo(width)
                    }
                    if (currentTag == 1) || (currentTag == 3) {
                        make.width.equalTo(width)
                    }
                }
            }
        }
    }
    /// 设置线色
    /// - Parameters:
    ///   - color: 线色
    ///   - direction: 方位，默认全部，支持按位或运算
    func axc_setBorderLineColor(_ direction: AxcDirection? = nil, color: AxcUnifiedColorTarget) {
        let color = color.axc_color
        for idx in 0..<borderLineViews.count {
            let currentView = borderLineViews[idx]
            if let _direction = direction { // 选择方位进行设置
                if (idx == 0) && (_direction.contains(.top))    { currentView.backgroundColor = color } // 要设置上
                if (idx == 1) && (_direction.contains(.left))   { currentView.backgroundColor = color } // 要设置左
                if (idx == 2) && (_direction.contains(.bottom)) { currentView.backgroundColor = color } // 要设置下
                if (idx == 3) && (_direction.contains(.right))  { currentView.backgroundColor = color } // 要设置右
            }else{ // 默认全部
                currentView.backgroundColor = color
            }
        }
    }
}

// MARK: Hud显示
private var kaxc_hudView = "kaxc_hudView"
private var khudWorkItem = "kaxc_hudWorkItem"
private var kaxc_hudState = "kaxc_hudState"
private var kaxc_hudDirection = "kaxc_hudDirection"

public extension UIView {
    /// 显示HUD的视图
    var axc_hudView: AxcHudView {
        set { AxcRuntime.setObj(self, &kaxc_hudView, newValue) }
        get {
            guard let hudView: AxcHudView  = AxcRuntime.getObj(self, &kaxc_hudView)
            else {
                let hudView = AxcHudView()
                addSubview(hudView)
                self.axc_hudView = hudView
                return hudView
            }
            return hudView
        }
    }
    //    /// 使用的计时器对象
    //    private var axc_hudWorkItem: DispatchWorkItem? {
    //        set { AxcRuntime.setObj(self, &khudWorkItem, newValue) }
    //        get {
    //            guard let workItem: DispatchWorkItem  = AxcRuntime.getObj(self, &khudWorkItem) else { return nil }
    //            return workItem
    //        }
    //    }
    //
    //    func axc_hudShow(_ direction: AxcDirection = .center,
    //                     msg: String,
    //                     image: UIImage? = nil,
    //                     delay: Double = 2) {
    //        bringSubviewToFront(axc_hudView) // 提到最前
    //        axc_hudView.axc_size = getHudSize(msg, image: image) // 获取大小
    //
    //        axc_hudView.center = center
    //        // 状态检查
    //        switch axc_hudState {
    //        case .willShow,.didShow:
    //            if !axc_hudView.isHidden {
    //                axc_hudWorkItem?.cancel() // 取消计时操作
    //                axc_hudWorkItem = nil
    //                axc_hudDismissDelay(delay) // 重新计时
    //            }
    //        default:
    //            axc_hudState = .willShow    // 即将显示
    //            axc_hudView.axc_animateFade(isIn: true) { [weak self] (_,_) in
    //                guard let weakSelf = self else { return }
    //                weakSelf.axc_hudState = .didShow // 已经显示
    //            }
    //            axc_hudDismissDelay(delay)
    //        }
    //    }
    //    /// 强制消失Hud提示
    //    func axc_hudDismiss(_ duration: Double = Axc_duration,
    //                        completion: AxcEmptyBlock? = nil) {
    //        axc_hudState = .willHide    // 即将隐藏
    //        axc_hudView.axc_animateFade(isIn: false, duration) { [weak self] (_, _) in
    //            guard let weakSelf = self else { return }
    //            weakSelf.axc_hudState = .didHide    // 已经隐藏
    //            completion?()
    //        }
    //    }
    //
    //    /* ---私有--- */
    //    /// 延时消失并重置计时
    //    private func axc_hudDismissDelay(_ delay: Double) {
    //        guard axc_hudWorkItem == nil else { return }
    //        axc_hudWorkItem = AxcGCD.delay(delay) { [weak self] in // 延时消失
    //            guard let weakSelf = self else { return }
    //            weakSelf.axc_hudDismiss { [weak self] in
    //                guard let weakSelf = self else { return }
    //                weakSelf.axc_hudWorkItem = nil
    //            }
    //        }
    //    }
    //
    //
    //    /// 刷新布局
    //    private func reloadHudLayout() {
    //
    //    }
    //    /// 计算Hud的大小
    //    /// - Parameters:
    //    ///   - msg: 文字内容
    //    ///   - image: 图片
    //    /// - Returns: 计算后的大小
    //    private func getHudSize(_ msg: String, image: UIImage? = nil) -> CGSize {
    //        axc_hudView.axc_style = .text
    //        axc_hudView.axc_titleLabel.text = msg
    //        let maxWidth = Axc_screenWidth - axc_hudView.axc_contentInset.axc_horizontal - 30
    //        var textSize = axc_hudView.axc_titleLabel.axc_estimatedSize(width: maxWidth)
    //        textSize.height += axc_hudView.axc_titleLabel.axc_contentInset.axc_verticality + 10
    //        var imageSize = 0.axc_cgSize
    //        if let img = image {
    //            axc_hudView.axc_imageView.image = img
    //            axc_hudView.axc_style = .imgTop_textBottom
    //            axc_hudView.axc_imgSize = 30
    //            imageSize = axc_hudView.axc_imgSize.axc_cgSize
    //        }
    //        let hudWidth = max(textSize.width, imageSize.width) + axc_hudView.axc_contentInset.axc_horizontal
    //        let hudHeight = imageSize.height + textSize.height + axc_hudView.axc_contentInset.axc_verticality
    //        return CGSize(hudWidth,hudHeight)
    //    }
}

// MARK: 空视图
/// 给view添加空视图
private var kaxc_emptyView = "kaxc_emptyView"
public extension UIView {
    /// 空的占位视图
    var axc_emptyView: UIView? {
        set { AxcRuntime.setObj(self, &kaxc_emptyView, newValue) }
        get {   // runtime 懒加载
            guard let emptyView: UIView = AxcRuntime.getObj(self, &kaxc_emptyView) else { return nil }
            return emptyView
        }
    }
    /// 设置空占位视图
    /// - Parameters:
    ///   - emptyView: 视图
    ///   - inset: 边距
    func axc_setEmptyView(_ emptyView: UIView? = nil) {
        let defaultEmptyView = emptyView ?? AxcListEmptyView()
        if !subviews.contains(defaultEmptyView) { addSubview(defaultEmptyView) }
        axc_emptyView = defaultEmptyView
        defaultEmptyView.axc_remakeConstraintsFill()
    }
    /// 显示隐藏空占位视图
    func axc_setEmptyViewIsShow(_ isShow: Bool) {
        guard let emptyView = axc_emptyView else { return }
        AxcGCD.main {
            emptyView.isHidden = !isShow
            self.bringSubviewToFront(emptyView)
        }
    }
}

// MARK: 几何切割遮罩
public extension UIView {
    
}

// MARK: - 动画功能
public extension UIView {
    /// 添加CAAnimation动画
    func axc_addAnimation(_ animation: CAAnimation,
                          key: String? = nil,
                          completeBlock: CAAnimation.AxcBoolBlock<Void>? = nil) {
        layer.axc_addAnimation(animation, key: key, completeBlock: completeBlock)
    }
    
    // MARK: 链式语法
    /// 动画链式语法中继器
    /// - Parameters:
    ///   - makeBlock: 在这里设置动画顺序
    ///   - complete: block内动画执行完后会走这个回调
    func axc_makeCAAnimation(_ makeBlock: AxcAnimationMakerBlock, complete: AxcEmptyBlock? = nil) {
        layer.axc_makeCAAnimation(makeBlock, complete: complete)
    }
    
    // MARK: 出入场动画（带自动设置Hidden）
    /// 透明度渐入渐出
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    func axc_animationInoutFade(isIn: Bool,
                                _ duration: TimeInterval? = nil,
                                _ completion: CAAnimation.AxcBoolBlock<Void>? = nil) {
        isHidden = false
        if isIn {
            axc_addAnimation(AxcAnimationManager.axc_inoutFade(isIn: isIn, duration, completion))
        }else{
            axc_addAnimation(AxcAnimationManager.axc_inoutFade(isIn: isIn, duration, { [weak self] (animation, flag) in
                guard let weakSelf = self else { return }; weakSelf.isHidden = true; completion?(animation, flag)
            }))
        }
    }
    
    /// 缩放出入场
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - axle: 沿轴向量
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    func axc_animationInoutScale(isIn: Bool,
                                 axle: AxcAxleVector? = nil,
                                 _ duration: TimeInterval? = nil,
                                 _ completion: CAAnimation.AxcBoolBlock<Void>? = nil) {
        isHidden = false
        if isIn {
            axc_addAnimation(AxcAnimationManager.axc_inoutScale(isIn: isIn, axle: axle, duration, completion))
        }else{
            axc_addAnimation(AxcAnimationManager.axc_inoutScale(isIn: isIn, axle: axle, duration, { [weak self] (animation, flag) in
                guard let weakSelf = self else { return }; weakSelf.isHidden = true; completion?(animation, flag)
            }))
        }
    }
    
    /// 旋转出入场
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - axle: 沿轴向量
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    func axc_animationInoutRotation(isIn: Bool,
                                    axle: AxcAxleVector? = nil,
                                    _ duration: TimeInterval? = nil,
                                    _ completion: CAAnimation.AxcBoolBlock<Void>? = nil) {
        isHidden = false
        if isIn {
            axc_addAnimation(AxcAnimationManager.axc_inoutRotation(isIn: isIn, axle: axle, duration, completion))
        }else{
            axc_addAnimation(AxcAnimationManager.axc_inoutRotation(isIn: isIn, axle: axle, duration, { [weak self] (animation, flag) in
                guard let weakSelf = self else { return }; weakSelf.isHidden = true; completion?(animation, flag)
            }))
        }
    }
    
    /// 圆角变化出入场
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - minCornerRadius: 视图最小的圆角
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    func axc_animationInoutCornerRadius(isIn: Bool,
                                        _ duration: TimeInterval? = nil,
                                        _ completion: CAAnimation.AxcBoolBlock<Void>? = nil) {
        isHidden = false
        if isIn {
            axc_addAnimation(AxcAnimationManager.axc_inoutCornerRadius(isIn: isIn, size: axc_size, duration, completion))
        }else{
            axc_addAnimation(AxcAnimationManager.axc_inoutCornerRadius(isIn: isIn, size: axc_size, duration, { [weak self] (animation, flag) in
                guard let weakSelf = self else { return }; weakSelf.isHidden = true; completion?(animation, flag)
            }))
        }
    }
    
    /// 边框线渐变出入
    /// - Parameters:
    ///   - isIn: 是否是入场
    ///   - duration: 持续时间
    ///   - completion: 完成回调
    /// - Returns: CAAnimation
    func axc_animationInoutBorderWidth(isIn: Bool,
                                       _ duration: TimeInterval? = nil,
                                       _ completion: CAAnimation.AxcBoolBlock<Void>? = nil) {
        isHidden = false
        if isIn {
            axc_addAnimation(AxcAnimationManager.axc_inoutBorderWidth(isIn: isIn, size: axc_size, duration, completion))
        }else{
            axc_addAnimation(AxcAnimationManager.axc_inoutBorderWidth(isIn: isIn, size: axc_size, duration, { [weak self] (animation, flag) in
                guard let weakSelf = self else { return }; weakSelf.isHidden = true; completion?(animation, flag)
            }))
        }
    }
    
    // MARK: 转场动画（带自动设置Hidden）
//    func axc_animation(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
}

// MARK: - Xib扩展属性
public extension UIView {
    /// 边框颜色
    @IBInspectable var axc_borderColor: UIColor? {
        get { return layer.axc_borderColor }
        set { layer.axc_borderColor = newValue }
    }
    /// 边框宽度
    @IBInspectable var axc_borderWidth: CGFloat {
        get { return layer.axc_borderWidth }
        set { layer.axc_borderWidth = newValue }
    }
    /// 圆角
    @IBInspectable var axc_cornerRadius: CGFloat {
        get { return layer.axc_cornerRadius }
        set { layer.axc_cornerRadius = newValue }
    }
    /// 遮罩边缘
    @IBInspectable var axc_masksToBounds: Bool {
        get { return layer.axc_masksToBounds }
        set { layer.axc_masksToBounds = newValue }
    }
    /// 阴影颜色
    @IBInspectable var axc_shadowColor: UIColor? {
        get { layer.axc_shadowColor }
        set { layer.axc_shadowColor = newValue }
    }
    /// 阴影透明度
    @IBInspectable var axc_shadowOpacity: CGFloat {
        get { return layer.axc_shadowOpacity }
        set { layer.axc_shadowOpacity = newValue }
    }
    /// 阴影偏移
    @IBInspectable var axc_shadowOffset: CGSize {
        get { return layer.axc_shadowOffset }
        set { layer.axc_shadowOffset = newValue }
    }
    /// 阴影圆角
    @IBInspectable var axc_shadowRadius: CGFloat {
        get { return layer.axc_shadowRadius }
        set { layer.axc_shadowRadius = newValue }
    }
}

// MARK: - frame扩展属性
public extension UIView {
    /// 读写x
    var axc_x: CGFloat {
        set { frame = CGRect(x: newValue, y: frame.axc_y, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_x }
    }
    /// 读写y
    var axc_y: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: newValue, width: frame.axc_width, height: frame.axc_height) }
        get { return frame.axc_y }
    }
    /// 读写width
    var axc_width: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: newValue, height: frame.axc_height) }
        get { return frame.axc_width }
    }
    /// 读写height
    var axc_height: CGFloat {
        set { frame = CGRect(x: frame.axc_x , y: frame.axc_y, width: frame.axc_width, height: newValue) }
        get { return frame.axc_height }
    }
    /// 读写left
    var axc_left: CGFloat {
        set { axc_x = newValue }
        get { return frame.axc_left }
    }
    /// 读写right
    var axc_right: CGFloat {
        set { axc_x = newValue - axc_width }
        get { return frame.axc_right }
    }
    /// 读写top
    var axc_top: CGFloat {
        set { axc_y = newValue }
        get { return frame.axc_top }
    }
    /// 读写bottom
    var axc_bottom: CGFloat {
        set { axc_y = newValue - axc_height }
        get { return frame.axc_bottom }
    }
    /// 读写origin
    var axc_origin: CGPoint {
        set { frame = CGRect(origin: newValue, size: axc_size ) }
        get { return frame.axc_origin }
    }
    /// 读写size
    var axc_size: CGSize {
        set { frame = CGRect(origin: frame.axc_origin, size: newValue) }
        get { return frame.axc_size }
    }
    /// 读写centerX
    var axc_centerX: CGFloat {
        get { return center.x }
        set { center.x = newValue }
    }
    /// 读写centerY
    var axc_centerY: CGFloat {
        get { return center.y }
        set { center.y = newValue }
    }
    
    /// 约束代码块
    func axc_remakeConstraints(_ block: (AxcConstraintMaker) -> Void) {
        guard axc_checkSuperView() else { return }
        axc.remakeConstraints({ (make) in block(make) })
    }
    /// 约束代码块
    func axc_makeConstraints(_ block: (AxcConstraintMaker) -> Void) {
        guard axc_checkSuperView() else { return }
        axc.makeConstraints({ (make) in block(make) })
    }
    /// 约束代码块
    func axc_updateConstraints(_ block: (AxcConstraintMaker) -> Void) {
        guard axc_checkSuperView() else { return }
        axc.updateConstraints({ (make) in block(make) })
    }
    
    /// 全填充
    func axc_makeConstraintsFill() {
        axc_makeConstraints { (make) in
            make.center.size.equalToSuperview()
        }
    }
    /// 移除全填充
    func axc_remakeConstraintsFill() {
        axc_remakeConstraints { (make) in
            make.center.size.equalToSuperview()
        }
    }
    
    /// 直接按照Frame约束
    func axc_makeConstraintsFrame(_ rect: CGRect) {
        axc_remakeConstraints { (make) in
            make.top.equalTo(rect.axc_y)
            make.left.equalTo(rect.axc_x)
            make.width.equalTo(rect.width)
            make.height.equalTo(rect.height)
        }
    }
    /// 直接按照Frame约束
    func axc_remakeConstraintsFrame(_ rect: CGRect) {
        axc_remakeConstraints { (make) in
            make.top.equalTo(rect.axc_top)
            make.left.equalTo(rect.axc_left)
            make.bottom.equalTo(rect.axc_bottom)
            make.right.equalTo(rect.axc_right)
        }
    }
    
    /// 直接按照Edge约束
    /// - Parameter inset: Edge边距
    func axc_makeConstraintsInset(_ inset: UIEdgeInsets) {
        axc_makeConstraints { (make) in
            make.top.equalTo(inset.top)
            make.left.equalTo(inset.left)
            make.bottom.equalTo(-inset.bottom)
            make.right.equalTo(-inset.right)
        }
    }
    /// 直接按照Edge约束
    /// - Parameter inset: Edge边距
    func axc_remakeConstraintsInset(_ inset: UIEdgeInsets) {
        axc_remakeConstraints { (make) in
            make.top.equalTo(inset.top)
            make.left.equalTo(inset.left)
            make.bottom.equalTo(-inset.bottom)
            make.right.equalTo(-inset.right)
        }
    }
    /// 校验是否有父视图
    func axc_checkSuperView() -> Bool {
        guard let _ = superview else {
            let log = "未找到父视图，请先执行addSubview！"
            AxcLog(log, level: .fatal)
            if AxcBadrock.fatalError { fatalError(log) }
            return false
        }
        return true
    }
    
    /// 设置单个equal的NSLayoutConstraint
    /// - Parameters:
    ///   - attribute: 参数
    ///   - constant: 值
    /// - Returns: Self
    @discardableResult
    func axc_setEqualLayout(_ attribute: NSLayoutConstraint.Attribute,
                            constant: AxcUnifiedNumberTarget) -> NSLayoutConstraint {
        let layout = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier:0.0,
                                        constant:constant.axc_cgFloat)
        addConstraint(layout)
        return layout
    }
}

// MARK: - 手势相关
public extension UIView {
    // MARK: 操作
    /// 添加一组手势
    @discardableResult
    func axc_addGestureRecs(_ gestureRecognizers: [UIGestureRecognizer]) -> UIView {
        for recognizer in gestureRecognizers {
            addGestureRecognizer(recognizer)
        }
        return self
    }
    /// 移除一组手势
    @discardableResult
    func axc_removeGestureRecs(_ gestureRecognizers: [UIGestureRecognizer]) -> UIView {
        for recognizer in gestureRecognizers {
            removeGestureRecognizer(recognizer)
        }
        return self
    }
    /// 移除所有手势
    @discardableResult
    func axc_removeAllGestureRecs() -> UIView {
        gestureRecognizers?.forEach(removeGestureRecognizer)
        return self
    }
    // MARK: 快速添加
    /// 添加任意一种手势
    @discardableResult
    func axc_addGesture<T>(_ gestureRec: T) -> T {
        if gestureRec is UIGestureRecognizer {
            isUserInteractionEnabled = true
            addGestureRecognizer(gestureRec as! UIGestureRecognizer)
        }
        return gestureRec
    }
    /// 点击手势
    @discardableResult
    func axc_addTapGesture(_ actionBlock: @escaping AxcGestureActionBlock) -> UITapGestureRecognizer {
        return axc_addGesture(UITapGestureRecognizer(actionBlock))
    }
    /// 长按手势
    @discardableResult
    func axc_addLongPressGesture(_ actionBlock: @escaping AxcGestureActionBlock) -> UILongPressGestureRecognizer {
        return axc_addGesture(UILongPressGestureRecognizer(actionBlock))
    }
    /// 滑动手势 默认添加右滑手势
    @discardableResult
    func axc_addSwipeGesture(_ direction: UISwipeGestureRecognizer.Direction = .right,
                             _ actionBlock: @escaping AxcGestureActionBlock) -> UISwipeGestureRecognizer {
        let left = UISwipeGestureRecognizer(actionBlock) // 同一个手势只能指定一个方向
        left.direction = direction
        return axc_addGesture(left)
    }
    /// 拖动手势 可不传Block，默认实现拖动功能
    @discardableResult
    func axc_addPanGesture(_ actionBlock: AxcGestureActionBlock? = nil) -> UIPanGestureRecognizer {
        guard let block = actionBlock else {
            return axc_addGesture(UIPanGestureRecognizer { [weak self] (p) in
                guard let weakSelf = self else { return }
                if let pan = p as? UIPanGestureRecognizer {
                    let translation = pan.translation(in: weakSelf)
                    guard let panView = pan.view else { return }
                    weakSelf.center = CGPoint(x: panView.axc_centerX + translation.x, y: panView.axc_centerY + translation.y)
                    pan.setTranslation(CGPoint.zero, in: weakSelf)  // 归零
                }
            })
        }
        return axc_addGesture(UIPanGestureRecognizer(block))
    }
    /// 长按手势
    /// - Parameters:
    ///   - actionBlock: 触发回调
    ///   - minScale: 最小缩放临界比
    ///   - maxScale: 最大缩放临界比
    /// - Returns: UIPinchGestureRecognizer
    @discardableResult
    func axc_addPinchGesture(_ actionBlock: AxcGestureActionBlock? = nil,
                             minScale: CGFloat = 0.5,
                             maxScale: CGFloat = 2) -> UIPinchGestureRecognizer {
        guard let block = actionBlock else {
            return axc_addGesture(UIPinchGestureRecognizer{ [weak self] (p) in
                guard let weakSelf = self else { return }
                if let pinch = p as? UIPinchGestureRecognizer {
                    if pinch.state == .changed {
                        guard let pinchView = pinch.view else { return }
                        weakSelf.transform = pinchView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
                        pinch.scale = 1
                    }else if pinch.state == .ended {
                        UIView.animate(withDuration: Axc_duration) {
                            if weakSelf.transform.a < minScale || weakSelf.transform.d < minScale { // 最小缩放临界
                                weakSelf.transform = CGAffineTransform(scaleX: minScale, y: minScale)
                            }
                            if weakSelf.transform.a > maxScale || weakSelf.transform.d > maxScale { // 最大缩放临界
                                weakSelf.transform = CGAffineTransform(scaleX: maxScale, y: maxScale)
                            }
                        }
                    }
                }
            })
        }
        return axc_addGesture(UIPinchGestureRecognizer(block))
    }
    
    /// 旋转手势
    @discardableResult
    func axc_addRotationGesture(_ actionBlock: AxcGestureActionBlock? = nil) -> UIRotationGestureRecognizer {
        guard let block = actionBlock else {
            return axc_addGesture(UIRotationGestureRecognizer{ [weak self] (r) in
                guard let weakSelf = self else { return }
                if let rotation = r as? UIRotationGestureRecognizer {
                    if rotation.state == .changed {
                        guard let rotationView = rotation.view else { return }
                        weakSelf.transform = rotationView.transform.rotated(by: rotation.rotation)
                        rotation.rotation = 0 // 归零
                    }
                }
            })
        }
        return axc_addGesture(UIRotationGestureRecognizer(block))
    }
}

// MARK: - 决策判断
public extension UIView {
    // MARK: 点
    /// 判断这个点是否包含在本视图范围内
    func axc_isContains(to point: CGPoint) -> Bool { return self.bounds.contains(point) }
    
    // MARK: 面
    /// 判断这个视图是否包含在本视图范围内
    func axc_isContains(to view: UIView) -> Bool { return self.bounds.contains(view.bounds) }
    /// 判断两个视图是否有交错
    func axc_isIntersects(to view: UIView) -> Bool { return bounds.intersects(view.bounds) }
    
    // MARK: 其他
    /// 是否包含其他视图
    func axc_isContains(_ anyClass: AnyClass) -> Bool {
        var isConstraints = false
        for view in subviews {
            if view.isKind(of: anyClass) { isConstraints = true; break }
        }
        return isConstraints
    }
}
