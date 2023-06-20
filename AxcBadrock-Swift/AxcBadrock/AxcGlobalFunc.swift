//
//  AxcGlobalFunc.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit

// MARK: - 颜色
// MARK: RGB颜色
/// RGB颜色
/// - Parameters:
///   - r: 红
///   - g: 绿
///   - b: 蓝
///   - a: 透明度 0-1
/// - Returns: UIColor
public func AxcColorRGB(_ r: AxcUnifiedNumberTarget,
                        _ g: AxcUnifiedNumberTarget,
                        _ b: AxcUnifiedNumberTarget,
                        a: AxcUnifiedNumberTarget = 1) -> UIColor {
    return UIColor(r, g, b, a: a)
}

// MARK: Hex颜色
/// 十六进制颜色
/// - Parameters:
///   - hex: 十六进制
///   - a: 透明度 0-1
/// - Returns: UIColor
public func AxcColorHex(_ hex: String, a: CGFloat = 1) -> UIColor? {
    return UIColor(hexStr: hex, alpha: a)
}

// MARK: - 获取Window
public func AxcAppWindow() -> UIWindow? {
    var window: UIWindow? = nil
    if #available(iOS 13.0, *) {
        for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as?  Set<UIWindowScene>)!) {
            if windowScene.activationState == .foregroundActive {
                windowScene.windows.forEach { _window in
                    if _window.axc_className == UIWindow.axc_className {
                        window = _window
                    }
                }
                break
            }
        }
        return window
    }else{
        return  UIApplication.shared.keyWindow
    }
}
// MARK: - 获取Window的RootViewController
public func AxcAppRootViewController() -> UIViewController? {
    return AxcAppWindow()?.rootViewController
}
// MARK: - 当前显示的VC
/// 当前显示的VC
public func AxcCurrentVC<T: UIViewController>() -> T?{
    guard let vc = UIApplication.axc_currentVC as? T else { return nil }
    return vc
}

// MARK: - 类名&Class互转
/// 类名转Class
public func AxcStringFromClass(_ className: String) -> AnyClass? {
    let projectName = Axc_projectName.replacingOccurrences(of: "-", with: "_")
    let name = "\(projectName).\(className)"
    return NSClassFromString(name)
}
/// 获取对象的类名
public func AxcClassFromString(_ _class: Any) -> String {
    return "\(type(of: _class))".components(separatedBy: ".").first!
}
/// 获取类的类名
public func AxcClassFromString(_ type: AnyClass) -> String {
    return "\(type)".components(separatedBy: ".").first!
}

// MARK: - 框架日志
/// 日志打印
/// 性能会有损耗 AxcBadrock.shared.openLog 可以直接关闭
public func AxcLog(_ format: String,
                   _ args: CVarArg? = nil,
                   level: AxcBadrocklogLevel = .info ) {
    guard AxcBadrock.shared.openLog else { return } // 直接 return
    var isShowLog = true // 等级过滤
    var levelStr = "无"
    switch level {
    case .none:     isShowLog = AxcBadrock.logNone      ; levelStr = "None"
    case .warning:  isShowLog = AxcBadrock.logWarning   ; levelStr = "Warning"
    case .fatal:    isShowLog = AxcBadrock.logFatal     ; levelStr = "Fatal"
    case .info:     isShowLog = AxcBadrock.logInfo      ; levelStr = "Info"
    case .action:   isShowLog = AxcBadrock.logAction    ; levelStr = "action"
    case .debug:    isShowLog = AxcBadrock.logDebug     ; levelStr = "Debug"
    case .trace:    isShowLog = AxcBadrock.logTrace     ; levelStr = "Trace"
    case .all:      isShowLog = AxcBadrock.logAll       ; levelStr = "All"
    default:        isShowLog = false  }
    guard isShowLog else { return } // 判断是否继续
    var logStr = "|------ AxcBadRock日志 ------Start\n|"
    logStr += "日志等级：-[ \(levelStr) ]-\n|"
    logStr += "时间：\(Date().axc_string())\n\n"
    logStr += "|内容：\n"
    if let _args = args { logStr += String(format: format, _args) + "\n" }
    else{ logStr += format + "\n" }
    logStr += "\n|------ AxcBadRock日志 ------End\n"
    print(logStr)
}


// MARK: - 语言适配
/// 框架内部语言适配
public func AxcBadrockLanguage(_ key: String, _ value: String? = nil) -> String {
    guard let bundle = AxcLanguageManager.languageBundle else { return key }
    let string = bundle.localizedString(forKey: key, value: value, table: nil)
    return string
}

// MARK: - CF类判断
/// CF类转换判断
/// - Parameters:
///   - value: 对象
///   - cfType: 类型
/// - Returns: 值
func AxcCFType<T, U: AxcCFTypeIDProtocol>(_ value: T, as cfType: U.Type) -> U? {
    guard CFGetTypeID(value as CFTypeRef) == cfType.typeID
    else { return nil }
    return (value as? U)
}

// MARK: - 全局枚举
// MARK: 文件数据枚举
/// 沙盒目录枚举
public enum AxcSandboxDir: String {
    /// 保存应用程序的重要数据文件和用户数据文件等。iTunes 同步时会备份该目录。
    case documents      = "/Documents"
    /// Library
    case library        = "/Library"
    /// 二级目录，保存应用程序相关的文件的目录
    enum Library: String {
        /// 保存应用程序使用时产生的支持文件和缓存文件，还有日志文件最好也放在这个目录。iTunes 同步时不会备份该目录。
        case caches         = "/Library/Caches"
        /// 保存应用程序的偏好设置文件（使用 NSUserDefaults 类设置时创建，不应该手动创建）。
        case preferences    = "/Library/Preferences"
    }
    /// 保存应用运行时所需要的临时数据，iphone 重启时，会清除该目录下所有文件。
    case tmp            = "/tmp"
}

// MARK: 网络请求枚举
/// 网络请求格式
public enum AxcNetWorkContentType: String {
    /// 作为请求头告诉服务端消息主体是序列化的JSON字符串。除低版本的IE，基本都支持
    case json               = "application/json"
    /// 不对字符编码。在使用包含文件上传控件的表单时，必须使用该值
    case form_data          = "multipart/form-data"
    /// 在发送前编码所有字符
    case form_urlencoded    = "application/x-www-form-urlencoded"
    /// 空格转换为 “+” 加号，但不对特殊字符编码
    case text_plain         = "text/plain"
    /// XML 作为编码方式的远程调用规范
    case text_xml           = "text/xml"
}

// MARK: 矢量枚举
/// 轴矢量枚举
public enum AxcAxleVector {
    /// x轴水平
    case horizontal
    /// y轴垂直
    case vertical
    /// z轴竖直
    case upright
}

// MARK: - 定义
// MARK: Block定义
/// 无参无返回Block定义
public typealias AxcEmptyBlock = () -> Void
/// 带View无返回Block定义
public typealias AxcViewBlock = (UIView) -> Void
/// 带Layer无返回Block定义
public typealias AxcLayerBlock = (CALayer) -> Void
/// 带Bool无返回Block定义
public typealias AxcBoolBlock = (Bool) -> Void
/// 带String无返回Block定义
public typealias AxcStringBlock = (String) -> Void
/// 带IndexPath无返回Block定义
public typealias AxcIndexPathBlock = (IndexPath) -> Void

// MARK: Tuples定义
/// 标题图片元组定义
public typealias AxcTitleImageTuples = (title: String?, image: UIImage?)
