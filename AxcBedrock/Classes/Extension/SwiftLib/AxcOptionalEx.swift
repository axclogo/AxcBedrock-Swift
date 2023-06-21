//
//  AxcOptionalEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/15.
//

// MARK: - [AxcOptionalSpace]

public struct AxcOptionalSpace<Base> {
    init(_ base: Base?) {
        self.base = base
    }

    var base: Base?
}

public extension Optional {
    /// 命名空间
    var axc: AxcOptionalSpace<Wrapped> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcOptionalSpace<Wrapped>.Type {
        return AxcOptionalSpace.self
    }
}

// MARK: - 数据转换

public extension AxcOptionalSpace { }

// MARK: - 类方法

public extension AxcOptionalSpace { }

// MARK: - 属性 & Api

public extension AxcOptionalSpace {
    /// 设置默认值，功能等效于 ?? 运算符
    ///
    ///        let foo: String? = nil
    ///        print(foo.axc.unwrapped(or: "bar")) -> "bar"
    ///
    ///        let bar: String? = "bar"
    ///        print(bar.axc.unwrapped(or: "foo")) -> "bar"
    ///
    /// - Parameter defaultValue: 默认值
    /// - Returns: 如果自身为空，则返回默认值
    func unwrapped(_ defaultValue: Base) -> Base {
        return base ?? defaultValue
    }

    /// 设置Error错误，如果为nil，则返回错误
    ///
    ///        let foo: String? = nil
    ///        try print(foo.axc.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.axc.unwrapped(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: 如果可选值为nil，则返回这个error
    /// - Throws: 错误输出
    /// - Returns: 如果该值为nil，则返回Error，否则返回该值
    func unwrapped(_ error: Error) throws -> Base {
        guard let wrapped = base else { throw error }
        return wrapped
    }
}

// MARK: - 决策判断

public extension AxcOptionalSpace {
    /// 是否为空
    var isNil: Bool {
        switch base {
        case .none: return true
        default: return false
        }
    }

    /// 是否有效
    var isValid: Bool {
        return !isNil
    }
}
