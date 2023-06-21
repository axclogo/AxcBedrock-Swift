//
//  AxcSignedIntegerEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/12.
//

import Foundation

// MARK: - [AxcSignedIntegerSpace]

public struct AxcSignedIntegerSpace<Base> where Base: SignedInteger {
    init(_ base: Base) {
        self.base = base
    }

    var base: Base
}

public extension SignedInteger {
    /// 命名空间
    var axc: AxcSignedIntegerSpace<Self> {
        set { }
        get { return .init(self) }
    }
}

public extension AxcSignedIntegerSpace {
    /// 年
    var year: AxcTimeMark {
        return AxcTimeMark(year: Int(base))
    }

    /// 月
    var month: AxcTimeMark {
        return AxcTimeMark(month: Int(base))
    }

    /// 周
    var week: AxcTimeMark {
        return AxcTimeMark(week: Int(base))
    }

    /// 日
    var day: AxcTimeMark {
        return AxcTimeMark(day: Int(base))
    }

    /// 时
    var hour: AxcTimeMark {
        return AxcTimeMark(hour: Int(base))
    }

    /// 分
    var minute: AxcTimeMark {
        return AxcTimeMark(minute: Int(base))
    }

    /// 秒
    var second: AxcTimeMark {
        return AxcTimeMark(second: Int(base))
    }
}
