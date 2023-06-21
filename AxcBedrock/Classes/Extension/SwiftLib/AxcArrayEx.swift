//
//  AxcArrayEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/22.
//

import Foundation

// MARK: - [AxcArraySpace]

public struct AxcArraySpace<Element>: AxcAssertUnifiedTransformTarget {
    init(_ base: [Element]) {
        self.base = base
    }

    var base: [Element]
}

public extension Array {
    /// 命名空间
    var axc: AxcArraySpace<Element> {
        set { }
        get { return .init(self) }
    }

    /// 命名空间， 类型方法
    static var Axc: AxcArraySpace<Element>.Type {
        return AxcArraySpace<Element>.self
    }
}

// MARK: - 数据转换

public extension AxcArraySpace {
    /// 转换成NSArray
    var nsArray: NSArray {
        return base as NSArray
    }

    /// 转换成CFArray
    var cfArray: CFArray {
        return base as CFArray
    }
}

// MARK: - AxcArraySpace + AxcCollectionJsonTarget

/// 遵循协议
extension AxcArraySpace: AxcCollectionJsonTarget {
    public typealias CollectionType = [Element]
    /// 协议的需要转换的类型
    public var collection: [Element]? {
        return base
    }
}

// MARK: - 类方法

public extension AxcArraySpace {
    /// 使用单个元素创建一定数量的数组
    /// - Parameters:
    ///   - expression: 为每个集合执行的表达式
    ///   - count: 数量
    /// - Returns: 数组
    static func Create(expression: @autoclosure () throws -> Element,
                       count: Int) rethrows -> [Element] {
        var array: [Element] = []
        if count > 0 {
            array.reserveCapacity(count)
            while array.count < count {
                array.append(try expression())
            }
        }
        return array
    }
}

// MARK: - 属性 & Api

public extension AxcArraySpace {
    /// 复制一个array
    var copy: [Element] {
        let arr = base
        return arr
    }
}

// MARK: - 元素操作

public extension AxcArraySpace {
    /// 随机返回一个值
    /// - Returns: 元素
    var random: Element? {
        guard base.count > 0 else { return nil }
        let index = arc4random_uniform(base.count.axc.uint32).axc.int
        return base[index]
    }

    // MARK: 增

    /// 拼接一组元素
    /// - Parameter newElements: 新的元素组
    /// - Returns: 元素集合
    func append(_ newElements: [Element]) -> [Element] {
        var newArr = base
        newElements.forEach { obj in
            newArr.append(obj)
        }
        return newArr
    }

    /// 安全插入一个元素
    /// - Parameters:
    ///   - newElement: 新元素
    ///   - index: 索引
    /// - Returns: 元素集合
    func insert(_ newElement: Element,
                at index: Int) -> [Element] {
        var newArr = base
        if index >= 0, index < base.count {
            newArr.insert(newElement, at: index)
        } else if index < 0 {
            AxcBedrockLib.Log("插入索引小于0！\nArray:\(self)\nindex:\(index)")
            newArr.insert(newElement, at: 0)
        } else {
            AxcBedrockLib.Log("插入索引越界！\nArray:\(self)\nindex:\(index)")
            newArr.append(newElement)
        }
        return newArr
    }

    // MARK: 删

    /// 安全移除一个元素
    /// - Parameter index: 索引
    /// - Returns: 元素集合
    func remove(at index: Int) -> [Element] {
        var newArr = base
        if index < base.count {
            newArr.remove(at: index)
        } else {
            AxcBedrockLib.Log("移除元素越界！\nArray:\(self)\nindex:\(index)")
        }
        return newArr
    }

    /// 从开始安全移除第一个出现符合规则的元素
    /// - Parameter rule: 规则
    /// - Returns: 元素集合
    func removeFirst(_ rule: AxcBlock.OneParamReturn<Element, Bool>) -> [Element] {
        guard let index = base.firstIndex(where: rule) else { return base }
        return remove(at: index)
    }

    /// 从最后安全移除第一个出现符合规则的元素
    /// - Parameter rule: 规则
    /// - Returns: 元素集合
    func removeLast(_ rule: AxcBlock.OneParamReturn<Element, Bool>) -> [Element] {
        guard let index = base.lastIndex(where: rule) else { return base }
        return remove(at: index)
    }

    // MARK: 改

    /// 替换一个元素
    /// - Parameters:
    ///   - newElement: 新元素
    ///   - index: 要替换的索引
    /// - Returns: 元素集合
    func replace(_ newElement: Element,
                 at index: Int) -> [Element] {
        let array = remove(at: index)
        return array.axc.insert(newElement, at: index)
    }

    /// 将一个元素移到最后
    /// - Parameter index: 索引
    /// - Returns: 元素集合
    func moveToLast(form index: Int) -> [Element] {
        return move(form: index, to: base.count - 1)
    }

    /// 将某个索引的元素移动到新的索引
    /// - Parameters:
    ///   - oldIndex: 旧索引
    ///   - newIndex: 新索引
    /// - Returns: 元素集合
    func move(form oldIndex: Int,
              to newIndex: Int) -> [Element] {
        guard let moveElement = object(at: oldIndex),
              !isCrossing(newIndex) else {
            let log = "移动的两个索引中，有越界行为！\n当前数组个数：\(base.count)，oldIndex:\(oldIndex)，newIndex\(newIndex)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return []
            #endif
        }
        return remove(at: oldIndex).axc.insert(moveElement, at: newIndex)
    }

    // MARK: 查

    /// 根据索引安全获取元素
    /// - Parameter index: 索引，越界后返回空
    /// - Returns: 元素
    func object(at index: Int) -> Element? {
        guard index >= 0, !base.axc.isCrossing(index) else {
            AxcBedrockLib.Log("获取数组元素越界！当前数组个数：\(base.count)，获取索引：\(index)")
            return nil
        }
        return base[index]
    }

    /// 过滤元素 返回ture过滤 否则不过滤
    /// - Parameter rule: 规则代码块
    /// - Returns: 元素集合
    func filter(by rule: @escaping AxcBlock.OneParamReturn<Element, Bool>) -> [Element] {
        var result: [Element] = []
        base.forEach { elmt in
            if !rule(elmt) {
                result.append(elmt)
            }
        }
        return result
    }

    /// 查找某个符合条件的元素
    /// - Parameters:
    ///   - reversed: 是否倒序，默认false
    ///   - rule: 规则代码块
    /// - Returns: 元素
    func object(reversed: Bool = false,
                by rule: @escaping AxcBlock.OneParamReturn<Element, Bool>) -> Element? {
        var result: Element?
        let arr = reversed ? base.reversed() : base
        arr.forEach { element in
            if rule(element) {
                result = element
                return
            }
        }
        return result
    }

    /// 获取某个元素的下标 如果没有则返回空
    /// - Parameter rule: 规则代码块
    /// - Returns: 索引
    func index(of rule: @escaping AxcBlock.OneParamReturn<Element, Bool>) -> Int? {
        var index: Int?
        base.enumerated().forEach { idx, element in
            if rule(element) {
                index = idx
                return
            }
        }
        return index
    }

    /// 获取符合规则的数量
    /// - Parameter rule: 规则
    /// - Returns: 数量
    func count(where rule: AxcBlock.OneParamReturn<Element, Bool>) -> Int {
        var count = 0
        for element in base where rule(element) {
            count += 1
        }
        return count
    }

    /// 倒叙遍历
    /// - Parameter body: 值代码块
    func forEachReversed(_ block: AxcBlock.OneParam<Element>) {
        base.reversed().forEach(block)
    }

    /// 索引值遍历
    /// - Parameter block: 索引值代码块
    func forEachEnumerated(_ block: AxcBlock.TwoParam<Int, Element>) {
        base.enumerated().forEach(block)
    }

    // MARK: 截取

    /// 截取数组
    /// - Parameter range: 返回
    /// - Returns: 元素集合
    func subArray(of range: AxcUnifiedRange) -> [Element] {
        let range = assertTransformNSRange(range)
        let lenght = range.length
        let maxLenght = base.count - range.location
        if lenght <= maxLenght {
            let count = range.location + range.length
            return Array(base[range.location ..< count])
        } else {
            AxcBedrockLib.Log("lenght越界！当前数组个数：\(base.count), range: \(range)")
            return Array(base[range.location ..< base.count])
        }
    }

    /// 从头部开始取值 数量不足则返回所有
    /// - Parameter count: 个数
    /// - Returns: 元素集合
    func prefix(_ count: Int) -> [Element] {
        return subArray(of: 0 ..< count)
    }

    /// 从尾部开始取值 数量不足则返回所有
    /// - Parameter count: 个数
    /// - Returns: 元素集合
    func suffix(_ count: Int) -> [Element] {
        var start = base.count - count
        if start < 0 {
            start = 0
            AxcBedrockLib.Log("count越界！当前数组个数：\(base.count), count: \(count)")
        }
        return subArray(of: start ... base.count - 1)
    }

    /// 将数组区分成块
    ///
    ///     let array = [1,2,3,4,5,6,7]
    ///     array.axc.chuncked(by: 3) // [[1,2,3], [4,5,6], [7]]
    ///
    /// - Parameter chunkSize: 块大小
    /// - Returns: 新数组
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: base.count, by: chunkSize).map {
            Array(base[$0 ..< Swift.min($0 + chunkSize, base.count)])
        }
    }
}

// MARK: - 特定元素扩展

// MARK: Hashable

public extension AxcArraySpace where Element: Equatable {
    /// 获取序列中的重复项
    ///
    ///     [1, 1, 2, 2, 3, 3, 3, 4, 5].axc.duplicates().sorted() -> [1, 2, 3])
    ///     ["h", "e", "l", "l", "o"].axc.duplicates().sorted() -> ["l"])
    ///
    /// - Returns: 在序列中重复的集合
    func duplicates() -> [Element] {
        var result = [Element]()
        for value in base {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}

// MARK: AdditiveArithmetic

public extension AxcArraySpace where Element: AdditiveArithmetic {
    /// 数组中所有元素的和。
    ///
    ///        [1, 2, 3, 4, 5].axc.sum() -> 15
    ///
    /// - Returns: 数组元素的和.
    func sum() -> Element {
        return base.reduce(.zero, +)
    }
}

// MARK: String

/// 当数组元素为String时，增加以下扩展
public extension AxcArraySpace where Element == String {
    /// 拼接字符串
    var jointString: String {
        return joint()
    }

    /// 拼接字符串
    func joint(_ jointStr: String = "") -> String {
        return base.joined(separator: jointStr)
    }

    /// 排重 会乱序
    func removeRepeat() -> [Element] {
        var dic: [String: String] = [:]
        base.forEach { dic[$0] = "" }
        return [String](dic.keys)
    }

    /// 排空
    func filterEmpty() -> [Element] {
        return base.filter { !$0.isEmpty || $0.count != 0 }
    }
}

// MARK: - 排序

public extension AxcArraySpace {
    /// 根据键路径返回一个升序排序的数组
    /// - Parameter keyPath: 键路径
    /// - Returns: 元素集合
    func sortByAscend<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> [Element] {
        return base.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

    /// 根据键路径返回一个降序排序的数组
    /// - Parameter keyPath: 键路径
    /// - Returns: 元素集合
    func sortByDescend<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> [Element] {
        return base.sorted { $0[keyPath: keyPath] > $1[keyPath: keyPath] }
    }
}

public extension AxcArraySpace where Element == AxcUnifiedString {
    /// 字母次序
    /// - Returns: 元素集合
    func sortByLexicographical() -> [Element] {
        return base.sorted { obj1, obj2 in
            let str1 = String.Axc.Create(obj1)
            let str2 = String.Axc.Create(obj2)
            return str1.caseInsensitiveCompare(str2).rawValue == -1
        }
    }
}

// MARK: - 快速取值

public extension AxcArraySpace {
    // MARK: 顺序取值

    /// 获取第1个元素
    var first: Element? { return base.first }
    /// 获取第2个元素
    var second: Element? { return base.axc.object(at: 1) }
    /// 获取第3个元素
    var third: Element? { return base.axc.object(at: 2) }
    /// 获取第4个元素
    var fourth: Element? { return base.axc.object(at: 3) }
    /// 获取第5个元素
    var fifth: Element? { return base.axc.object(at: 4) }

    // MARK: 倒序取值

    /// 获取倒数第1个元素
    var last: Element? { return base.last }
    /// 获取倒数第2个元素
    var lastSecond: Element? { return base.axc.object(at: base.count - 2) }
    /// 获取倒数第3个元素
    var lastThird: Element? { return base.axc.object(at: base.count - 3) }
    /// 获取倒数第4个元素
    var lastFourth: Element? { return base.axc.object(at: base.count - 4) }
    /// 获取倒数第5个元素
    var lastFifth: Element? { return base.axc.object(at: base.count - 5) }
}

// MARK: - 决策判断

public extension AxcArraySpace {
    /// 判断索引是否越界 越界为真
    func isCrossing(_ idx: Int) -> Bool {
        return !(
            (idx >= 0) && (base.count > idx)
        )
    }

    /// 判断是否包含某个元素
    /// - Parameter rule: 规则代码块
    func isContent(by rule: @escaping AxcBlock.OneParamReturn<Element, Bool>) -> Bool {
        for index in 0 ..< base.count {
            let elmt = base[index]
            return rule(elmt)
        }
        return false
    }
}

public extension AxcArraySpace where Element: Equatable {
    /// 两个Equatable集合是否包含关系
    ///
    ///        [1, 2, 3, 4, 5].contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: 元素集合
    /// - Returns: 判断结果
    /// - Complexity: 复杂度：_O(m·n)_，其中_m_是' elements '的长度，_n_是这个序列的长度
    func contains(_ elements: [Element]) -> Bool {
        return elements.allSatisfy { base.contains($0) }
    }
}

public extension AxcArraySpace where Element: Hashable {
    /// 两个Hashable集合是否包含关系
    ///
    ///        [1, 2, 3, 4, 5].axc.contains([1, 2]) -> true
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].axc.contains([2, 6]) -> false
    ///        ["h", "e", "l", "l", "o"].axc.contains(["l", "o"]) -> true
    ///
    /// - Parameter elements: 元素集合
    /// - Returns: 判断结果
    /// - Complexity: 复杂度：_O(m + n)_，其中_m_是' elements '的长度，_n_是这个序列的长度
    func contains(_ elements: [Element]) -> Bool {
        let set = Set(base)
        return elements.allSatisfy { set.contains($0) }
    }

    /// 检查序列中是否存在重复项
    /// - Returns: 结果
    func containsDuplicates() -> Bool {
        var set = Set<Element>()
        for element in base {
            if !set.insert(element).inserted {
                return true
            }
        }
        return false
    }
}
