//
//  AxcBaseVC.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/18.
//

import UIKit

// MARK: - AxcBaseVC
/// 基类ViewController
@IBDesignable
open class AxcBaseVC: UIViewController, AxcBaseClassConfigProtocol, AxcBaseClassMakeUIProtocol {
    // MARK: - 初始化
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        config()
    }
    public init() {
        super.init(nibName: nil, bundle: nil)
        config()
    }
    public  required convenience init?(coder: NSCoder) {
        self.init()
    }
    public convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    // MARK: - Api
    // MARK: UI属性
    /// 状态栏是否为黑色 默认true
    open var axc_stateBarIsBlack: Bool = true {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
    /// 获取 AxcBaseNavVC
    open var axc_navController: AxcBaseNavVC? {
        guard let nav = navigationController as? AxcBaseNavVC else { return nil }
        return nav
    }
    /// 是否为横屏
    open var axc_isScreenHorizontal: Bool {
        let orientation = Axc_device.orientation
        return ((orientation == .landscapeLeft)||(orientation == .landscapeRight))
    }
    /// 是否屏幕朝上
    open var axc_isScreenUp: Bool {
        let orientation = Axc_device.orientation
        return orientation == .faceUp
    }
    /// 设置支持的屏幕转向 nav会读取调用
    open var axc_screenOrientation: UIInterfaceOrientationMask = .all
    
    /// 背景图
    open var axc_backgroundImage: UIImage? = nil {
        didSet {
            axc_backgroundImageView.isHidden = (axc_backgroundImage == nil)
            axc_backgroundImageView.image = axc_backgroundImage
        }
    }
    
    // MARK: TableView列表
    /// 设置一个tableView
    /// - Parameters:
    ///   - style: 样式
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    /// - Returns: tableView
    open func axc_makeTableView(style: UITableView.Style = .plain,
                                delegate: UITableViewDelegate? = nil,
                                dataSource: UITableViewDataSource? = nil,
                                registers: [AxcRegisterStruct] = []) -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: style,
                                    delegate: delegate, dataSource: dataSource, registers: registers)
        return tableView
    }
    /// 设置一个collectionView
    /// - Parameters:
    ///   - layout: 布局
    ///   - delegate: 代理
    ///   - dataSource: 数据源
    ///   - registers: 注册元组
    /// - Returns: cillectionView
    open func axc_makeCollectionView(layout: UICollectionViewFlowLayout? = nil,
                                     delegate: UICollectionViewDelegate? = nil,
                                     dataSource: UICollectionViewDataSource? = nil,
                                     registers: [AxcRegisterStruct] = []) -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, layout: layout,
                                              delegate: delegate, dataSource: dataSource, registers: registers)
        return collectionView
    }
    
    // MARK: view包装
    /// 添加视图
    open func axc_addSubView(_ view: UIView) {
        if let _view = view as? AxcBaseView {
            _view.axc_vc = self;
        }
        self.view.addSubview(view)
    }

    // MARK: 导航条按钮
    /// 持有返回图片的Image，不需要每次push重新获取，节约性能
    private var backArrowImage: UIImage = AxcBadrockBundle.arrowLeftImage
    /// 渲染成返回色的返回Image，如果渲染失败，则返回原图
    private var themeBackArrowImage: UIImage {
        guard let _themeBackArrowImage = backArrowImage.axc_setTintColor(AxcBadrock.shared.backImageColor) else { return backArrowImage }
        return _themeBackArrowImage
    }
    /// 设置一个返回按钮
    open func axc_setBackNavBarItem(title: String? = nil, font: UIFont? = nil,
                                    image: UIImage? = nil, size: CGSize? = nil,
                                    contentLayout: AxcButtonStyle = .img,
                                    contentInset: UIEdgeInsets = .zero,
                                    actionBlock: AxcActionBlock? = nil) {
        var _image = themeBackArrowImage    // 判断图片
        if let itemImage = image { _image = itemImage }
        var _actionBlock: AxcActionBlock = { [weak self] (sender) in    // 判断回调
            guard let weakSelf = self else { return }
            weakSelf.axc_navBarBack(sender)
        }
        if let block = actionBlock { _actionBlock = block }
        axc_setNavBarItem(title: title, font: font,
                          image: _image, size: size,
                          contentLayout: contentLayout,
                          contentInset: contentInset,
                          direction: .left,
                          actionBlock: _actionBlock)
    }
    
    /// 返回按钮被触发时
    /// - Parameter sender: 触发对象
    open func axc_navBarBack(_ sender: Any? ) {
        axc_popViewController()
    }
    
    // MARK: 推出返回
    /// 推出一个VC
    /// - Parameters:
    ///   - vc: vc
    ///   - animation: 动画
    ///   - completion: 结束后回调
    func axc_pushViewController(_ vc: UIViewController, animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        navigationController?.axc_pushViewController(vc, animation: animation, completion: completion )
    }
    /// 返回本VC
    /// - Parameters:
    ///   - animation: 动画
    ///   - completion: 结束后回调
    func axc_popViewController(animation: Bool = true, completion: AxcEmptyBlock? = nil) {
        navigationController?.axc_popViewController(animated: animation, completion: completion)
    }
    
    
    // MARK: 预设控件设置相关
    /// 添加底部自定义工具栏
    open func axc_addCustomToolBar() {
        view.addSubview(axc_toolBarView)
        axc_toolBarView.axc.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(Axc_toolBarHeight)
        }
    }
    /// 添加顶部自定义导航栏
    open func axc_addCustomNavBar() {
        view.addSubview(axc_navBar)
        axc_navBar.axc.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(Axc_statusHeight + Axc_navBarHeight)
        }
    }
    
    
    // MARK: - 子类实现
    /// 配置 执行于makeUI()之前
    open func config() { }
    /// 设置UI布局
    open func makeUI() { }
    
    // MARK: - 父类重写
    /// 视图加载完成
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AxcBadrock.shared.backgroundColor
        if #available(iOS 11, *) { } else { // 低于11版本
            automaticallyAdjustsScrollViewInsets = false
        }
        makeUI()
    }
    /// 设置标题
    open override var title: String? {
        didSet { _axc_navBar?.axc_title = title }
    }
    /// 开始点击视图控制器
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(false)
    }
    
    // MARK: 生命周期
    /// 即将出现
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    /// 已经出现
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    /// 即将消失
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    /// 已经消失
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    /// 状态栏颜色
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        return axc_stateBarIsBlack ? .default : .lightContent
    }
    
    // MARK: - 懒加载
    // MARK: 预设控件
    /// 预设底部的工具栏
    open lazy var axc_toolBarView: AxcBaseView = {
        let toolBarView = AxcBaseView()
        toolBarView.backgroundColor = AxcBadrock.shared.backgroundColor
        toolBarView.axc_setBorderLineDirection(.top)
        toolBarView.axc_setBorderLineColor(color: AxcBadrock.shared.lineColor)
        toolBarView.axc_setBorderLineWidth(width: 0.5)
        toolBarView.axc_shadowOpacity = AxcBadrock.shared.shadowOpacity
        toolBarView.axc_shadowColor = AxcBadrock.shared.shadowColor
        toolBarView.axc_shadowOffset = CGSize((1, -1))
        axc_addSubView(toolBarView)
        return toolBarView
    }()
    
    // 不执行懒加载的对象指针
    private var _axc_navBar: AxcNavBar?
    /// 预设的自定义顶部导航条控件
    open lazy var axc_navBar: AxcNavBar = {
        let barView = AxcNavBar()
        barView.axc_shadowOpacity = AxcBadrock.shared.shadowOpacity
        barView.axc_shadowColor = AxcBadrock.shared.shadowColor
        barView.axc_shadowOffset = CGSize((1, 1))
        axc_stateBarIsBlack = false
        // 使navBar的颜色与状态栏颜色自动适配
        barView.axc_didSetBackgroundColorBlock = { [weak self] (_,color) in
            guard let weakSelf = self else { return }
            guard let isLight = color?.axc_isLight else { return }
            weakSelf.axc_stateBarIsBlack = isLight // 检查导航栏颜色是否为亮色或淡色
        }
        axc_addSubView(barView)
        _axc_navBar = barView
        return barView
    }()
    
    // 背景图
    open lazy var axc_backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        axc_addSubView(imageView)
        imageView.axc_remakeConstraintsFill()
        return imageView
    }()
    
    deinit { AxcLog("视图控制器VC已销毁：\(self)", level: .trace) }
}
