//
//  AxcBadrock.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

/*
 核心设计理念：
 提高组件使用体验，相关的代码尽可能的展现在一个屏幕范围内
 抛弃代理回调，全部使用Block回调模式
 尽可能多的链式语法模式，可读性强
 
 以自身基类为起点，以扩展为辅助
 以框架工具类优化，以控件库快速搭建
 达成链式语法完善性和属性回调的自由性
 构成光速开发的基础和模版
 
 框架要求优先级：
 1、稳定不易bug
 2、性能高
 3、使用便捷
 
 */
/*
 单词缩写规则
 Object     -> Obj
 String     -> Str
 Array      -> Arr
 Dictionary -> Dic
 Parameters -> Param
 ViewController -> vc
 Gesture Recognizers -> GestureRec
 Navigation -> nav
 
 指定名称命名
 临界 critical
 排列 permutation
 持续时间 duration
 估计 estimated
 忽略 ignore
 触发、行动 action
 相交 intersects
 方法 selector
 边框 border
 衰变 decay
 默认 default
 方向 direction
 翻转 flip
 旋转 rotate
 水平 horizontal
 垂直 vertical
 拉伸 tensile
 半径 radius
 圆角 cornerRadius
 压缩 compressed                  取值范围：(0-1)
 平均 average
 透明 opaque
 透明度 alpha
 元组 tuples
 距离 distance
 间距 spacing
 标量 scalar                      取值范围：(0-1)
 角度 angle                       取值范围 0 - 360
 弧度 radian                      取值范围 0 - 2pi
 比值 ratio                       取值范围：(0-1)
 比例缩放 scale                   取值范围：(0-1)
 极大值 max                        无需参考，指内存中能存下最大的极值
 极小值 min                        无需参考，指内存中能存下最小的极值
 自身属性相比下的最大值 bigger         具有参考对比性的描述词汇
 自身属性相比下的最小值 smaller        具有参考对比性的描述词汇
 唯一标识符命名 identifier
 
 private修饰的扩展参数需以_开头，无需前缀
 */


/*
 操作符参数命名规则
 左参数 leftValue
 右参数 rightValue
 中参数 centerValue
 驼峰式、首字母小写、不带前缀、根据方位+Value模式作为命名规范
 */

/*
 mutating命名规则
 能修改自身的函数方法，不得有命名歧义的其他方法
 修改自身函数方法必须唯一
 如有重复方法，须以set区分
 */

/*
 类方法函数命名规则
 axc_后的首字母要大写，采用驼峰式
 */

/*
 全局方法参数命名规则
 全局方法命名，Axc+方法名，驼峰式
 全局参数命名，Axc_+参数名，驼峰式
 */

/*
 struct结构体命名规则
 结构体本身开头大写，驼峰式
 结构体内部参数无需axc前缀
 参数方法均小写开头，驼峰式
 */

/*
 类的方法命名规则
 类本身若是以Axc开头，则无需axc前缀
 基类预设方法 除初始化方法外，全部统一以axc_开头
 基类预设参数也如上
 如果基类需要子类实现的方法以及参数，命名则无需任何前缀
 基类预设对象属性，无需前缀
 方法设置属性要加set
 */


import UIKit

/// 日志等级
public struct AxcBadrocklogLevel : OptionSet {
    public init(rawValue: UInt) { self.rawValue = rawValue }
    internal init(_ rawValue: UInt) { self.init(rawValue: rawValue) }
    public private(set) var rawValue: UInt
    /// 不输出日志
    public static var none:     AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 0) }
    /// 警告日志
    public static var warning:  AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 1) }
    /// 致命日志
    public static var fatal:    AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 2) }
    /// 信息日志
    public static var info:     AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 3) }
    /// 未实现的点击事件日志
    public static var action:   AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 4) }
    /// debug日志
    public static var debug:    AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 5) }
    /// 跟踪日志
    public static var trace:    AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 6) }
    /// 所有日志
    public static var all:      AxcBadrocklogLevel { return AxcBadrocklogLevel(UInt(1) << 7) }
}

open class AxcBadrock {
    /// 单例实例化
    public static let shared: AxcBadrock = {
        let badrock = AxcBadrock()
        return badrock
    }()
    /// 日志开关，若关闭，相比logLevel.none更节约比较性能
    /// 且关闭后无论日志输出等级，都将不输出 默认开启
    open var openLog: Bool = true
    /// 日志输出等级 默认显示警告和致命错误
    open var logLevel: AxcBadrocklogLevel = [.warning, .fatal]
    
    /// 是否开启fatalError断言操作 默认true
    /// 开启后，当有框架使用错误出现时会断言终止程序，
    /// 关闭后，部分小错误会忽略
    /// 注意：即使关闭断言操作，遇到必须解决的错误依然会终止程序
    open var fatalError: Bool = true
    
    // MARK: 色系设置
    /// 主题色
    /// 默认 systemTeal
    open var themeColor: UIColor = UIColor.systemTeal
    /// 主题渐变色
    /// 默认 systemBlue -> systemTeal
    open var themeGradientColors: [UIColor] = [UIColor.systemTeal, UIColor.systemBlue]
    /// 标题文字色
    /// 默认 black
    open var titleColor: UIColor = UIColor.black
    /// 普通文字色
    /// 默认 black
    open var textColor: UIColor = UIColor.black
    /// 不可选/未选中文字色
    /// 默认 black
    open var unTextColor: UIColor = UIColor.gray
    /// 主题填充时内容色
    /// 默认 white
    open var themeFillContentColor: UIColor = UIColor.white
    /// 返回按钮色
    /// 默认 black
    open var backImageColor: UIColor = UIColor.black
    /// 默认背景色
    /// 默认 systemGroupedBackground
    open var backgroundColor: UIColor = UIColor.groupTableViewBackground
    /// 默认蒙版背景色
    /// 默认 black.axc_alpha(0.7)
    open var maskBackgroundColor: UIColor = UIColor.black.axc_alpha(0.5)
    /// 标记/提醒色
    /// 默认 systemRed
    open var markedColor: UIColor = UIColor.systemRed
    /// 分割线颜色
    /// 默认 systemGray3
    open var lineColor: UIColor = UIColor.groupTableViewBackground
    /// 阴影颜色
    /// 默认 systemTeal
    open var shadowColor: UIColor = UIColor.groupTableViewBackground
    /// 阴影透明度
    /// 默认 0.5
    open var shadowOpacity: CGFloat = 0.5

}

// MARK: - 类属性快速读取
public extension AxcBadrock {
    // MARK: 日志级别
    /// none级别
    static var logNone: Bool { return false }
    /// warning级别
    static var logWarning: Bool {
        return (AxcBadrock.shared.logLevel.contains(.all)) || (AxcBadrock.shared.logLevel.contains(.warning))
    }
    /// fatal级别
    static var logFatal: Bool {
        return (AxcBadrock.shared.logLevel.contains(.all)) || (AxcBadrock.shared.logLevel.contains(.fatal))
    }
    /// info级别
    static var logInfo: Bool {
        return (AxcBadrock.shared.logLevel.contains(.all)) || (AxcBadrock.shared.logLevel.contains(.info))
    }
    /// action级别
    static var logAction: Bool {
        return (AxcBadrock.shared.logLevel.contains(.all)) || (AxcBadrock.shared.logLevel.contains(.action))
    }
    /// debug级别
    static var logDebug: Bool {
        return (AxcBadrock.shared.logLevel.contains(.all)) || (AxcBadrock.shared.logLevel.contains(.debug))
    }
    /// trace级别
    static var logTrace: Bool {
        return (AxcBadrock.shared.logLevel.contains(.all)) || (AxcBadrock.shared.logLevel.contains(.trace))
    }
    /// all级别
    static var logAll: Bool { return true }
    
    // MARK: 断言操作
    /// 断言状态
    static var fatalError: Bool { return AxcBadrock.shared.fatalError }
}
