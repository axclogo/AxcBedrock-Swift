//
//  AxcNameSpace.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/16.
//

import Foundation

// MARK: - [AxcSpaceProtocol]

/*
 对于带泛型的结构体，需要定制特定的命名空间来实现，为了api的统一
 由于Swift结构体写时复制机制，导致无法对于var声明的结构体做引用操作
    所以在操作类型api中，都通过返回一个新对象的方式来操作
 命名空间对象中，对于同名api会有冲突，字段会被占用，命名时需要注意
 无法扩展 @objc方法，需要额外的类累承接实现

 此外，对于有命名重复的api，会采用两个或多个Space进行分离
 在api调用者看来没有太大问题，实现方面会比较麻烦，但是也不会污染系统的代码补全
 */

public protocol AxcSpaceProtocol { }
public extension AxcSpaceProtocol {
    /// 命名空间， 实例类型
    var axc: AxcSpace<Self> {
        set { }
        get { return AxcSpace(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcSpace<Self>.Type {
        return AxcSpace<Self>.self
    }
}

// MARK: - [AxcSpace]

open class AxcSpace<Base>: AxcAssertUnifiedTransformTarget {
    public init(_ base: Base) {
        self.base = base
    }

    public var base: Base
}
