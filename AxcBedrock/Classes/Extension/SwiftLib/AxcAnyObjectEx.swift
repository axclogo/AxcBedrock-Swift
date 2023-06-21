//
//  AxcAnyObjectEx.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/11.
//

import Foundation

// MARK: - 数据转换

public extension AxcSpace where Base: AnyObject {
    /// 获取对象的类名
    var stringFromClass: String {
        let className = NSStringFromClass(type(of: base))
        return className
    }

    /// typeID判断
    /// - Parameters:
    ///   - value: 对象
    ///   - cfType: 类型
    /// - Returns: 值
    @discardableResult
    func cfType<U: AxcCFTypeIDProtocol>(as cfType: U.Type) -> U? {
        return AxcFunc.CFType(base, as: U.self)
    }
}

// MARK: - 类方法

public extension AxcSpace where Base: AnyObject {
    /// 获取类的类名
    /// 注意，这里只能通过泛型获取类型，并不能动态获取类型
    static var StringFromClass: String {
        return NSStringFromClass(Base.self)
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base: AnyObject {
    /// 所在内存地址
    var memoryAddress: String {
        let str = Unmanaged<AnyObject>.passRetained(base).toOpaque()
        return String(describing: str)
    }
}
