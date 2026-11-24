// MARK: - 区间限制

public extension AxcSpace where Base: Comparable {
    /// 返回限制在闭区间内的值，区间内的值保持不变。
    /// 浮点 NaN 原样返回，正负无穷按边界限制；区间边界必须满足 ClosedRange 的有效性要求。
    func clamped(to range: ClosedRange<Base>) -> Base {
        if base < range.lowerBound { return range.lowerBound }
        if base > range.upperBound { return range.upperBound }
        return base
    }
}
