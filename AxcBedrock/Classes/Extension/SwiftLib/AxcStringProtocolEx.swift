//
//  AxcStringProtocolEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/15.
//

// MARK: - [AxcStringProtocolSpace]

public struct AxcStringProtocolSpace<Base> where Base: StringProtocol {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension StringProtocol {
    /// 命名空间
    var axc: AxcStringProtocolSpace<Self> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcStringProtocolSpace<Self>.Type {
        return AxcStringProtocolSpace.self
    }
}

// MARK: - 数据转换

public extension AxcStringProtocolSpace { }

// MARK: - 类方法

public extension AxcStringProtocolSpace { }

// MARK: - 属性 & Api

public extension AxcStringProtocolSpace {
    /// 获取两个字符串相同连续的字符
    ///
    ///        "Hello world!".axc.commonSuffix(with: "It's cold!") = "ld!"
    ///
    /// - Parameters:
    /// -  aString: 比较字符串
    /// -  options: 类型
    /// - Returns: 接收方和给定字符串的最长公共后缀
    func commonSuffix<T: StringProtocol>(with aString: T,
                                         options: String.CompareOptions = []) -> String {
        return String(zip(base.reversed(),
                          aString.reversed())
                .lazy
                .prefix(while: { (lhs: Character, rhs: Character) in
                    String(lhs).compare(String(rhs), options: options) == .orderedSame
                })
                .map { (lhs: Character, _: Character) in lhs }
                .reversed())
    }

    /// 首字母大写
    var firstUppercased: String {
        return base.prefix(1).uppercased() + base.dropFirst()
    }

    /// 首字母小写
    var firstLowercased: String {
        return base.prefix(1).lowercased() + base.dropFirst()
    }
}

// MARK: - 决策判断

public extension AxcStringProtocolSpace { }
