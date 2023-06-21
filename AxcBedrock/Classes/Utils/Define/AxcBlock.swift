//
//  AxcBlock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation

public typealias AxcBlock = AxcBedrockLib.Block

// MARK: AxcBlock.Block

public extension AxcBedrockLib {
    /// Block集合
    struct Block { }
}

public extension AxcBlock {
    /// 事件回调Block
    typealias Action<Param> = (_ action: Param) -> Void
    /// 设置类回调Block
    typealias Maker<Param> = (_ make: Param) -> Void

    /// 无参数，无返回定义
    typealias Empty = () -> Void
    /// 1参数，无返回定义
    typealias OneParam<One> =
        OneParamReturn<One, Void>
    /// 2参数，无返回定义
    typealias TwoParam<One, Two> =
        TwoParamReturn<One, Two, Void>
    /// 3参数，无返回定义
    typealias ThreeParam<One, Two, Three> =
        ThreeParamReturn<One, Two, Three, Void>
    /// 4参数，无返回定义
    typealias FourParam<One, Two, Three, Four> =
        FourParamReturn<One, Two, Three, Four, Void>
    /// 5参数，无返回定义
    typealias FiveParam<One, Two, Three, Four, Five> =
        FiveParamReturn<One, Two, Three, Four, Five, Void>

    /// 无参数，带返回定义
    /// 可以使用自动闭包声明 @autoclosure
    typealias Return<Return> =
        () -> Return
    /// 1参数，带返回定义
    typealias OneParamReturn<One, Return> =
        (One) -> Return
    /// 2参数，带返回定义
    typealias TwoParamReturn<One, Two, Return> =
        (One, Two) -> Return
    /// 3参数，带返回定义
    typealias ThreeParamReturn<One, Two, Three, Return> =
        (One, Two, Three) -> Return
    /// 4参数，带返回定义
    typealias FourParamReturn<One, Two, Three, Four, Return> =
        (One, Two, Three, Four) -> Return
    /// 5参数，带返回定义
    typealias FiveParamReturn<One, Two, Three, Four, Five, Return> =
        (One, Two, Three, Four, Five) -> Return
}
