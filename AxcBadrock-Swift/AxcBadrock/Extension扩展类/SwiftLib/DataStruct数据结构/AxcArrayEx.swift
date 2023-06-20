//
//  AxcArrayEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/5.
//

import Foundation


// MARK: - 数据转换
extension Array: AxcDataStringTransform {
}

// MARK: - 属性 & Api
public extension Array {
    /// 转换成NSArray
    var axc_nsArray: NSArray {
        return self as NSArray
    }
    
    /// 随机返回一个值
    var axc_random: Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    /// 获取一个洗牌乱序打乱数组
    var axc_shuffleArr: Array {
        var result = self
        result.shuffle()
        return result
    }
    
    /// 根据索引获取元素
    func axc_objAtIdx(_ index: Int) -> Element? {
        guard index >= 0 && axc_safeIdx(index) else { return nil }
        return self[index]
    }
    
    /// 取头部前多少个元素
    /// 如果本数组数量不足，则有多少取多少
    /// - Parameter count: 数量
    /// - Returns: 新集合
    func axc_prefix(_ count: Int) -> Self {
        var newArr = [Element]()
        for (index,value) in enumerated() {
            if index < count { newArr.append(value) }else{ break }
        }
        return newArr
    }
    
    /// 取尾部多少个元素
    /// 如果本数组数量不足，则有多少取多少
    /// - Parameter count: 数量
    /// - Returns: 新集合
    func axc_suffix(_ count: Int) -> Self {
        var newArr = [Element]()
        for (index,value) in enumerated().reversed() {
            if index < count { newArr.append(value) }else{ break }
        }
        return newArr
    }
    
    /// 向头部插入一个元素
    mutating func axc_insertFirst(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    /// 安全移动一个元素form Idx 到 to idx
    mutating func axc_move(from index: Index, to otherIndex: Index) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
    
    /// 安全移除一个元素
    mutating func axc_remove(_ idx: Int) {
        if idx < count { remove(at: idx) }
        else {
            let log = "移除元素越界！\nArray:\(self)\nindex:\(idx)"
            AxcLog(log, level: .fatal)
            if AxcBadrock.fatalError { fatalError(log) } // 框架断言
        }
    }
    /// 过滤重复的
    func axc_filterRepeat<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
/// 当数组元素为String时，增加以下扩展
public extension Array where Element == String {
    /// 拼接字符串
    var axc_joint: String {
        return axc_joint()
    }
    /// 拼接字符串
    func axc_joint(_ jointStr: String = "") -> String {
        return self.joined(separator: jointStr)
    }
    /// 排重 会乱序
    func axc_removeRepeat() -> Self {
        var dic: [String:String] = [:]
        forEach{ dic[$0] = "" }
        return [String](dic.keys)
    }
    /// 排空
    func axc_removeEmpty() -> Self {
        return filter{ !$0.isEmpty || $0.count != 0 }
    }
}

// MARK: - 快速取值
public extension Array  {
    // MARK: 顺序取值
    /// 获取第1个元素
    var axc_firstObj: Element?  { return first }
    /// 获取第2个元素
    var axc_secondObj: Element? { return axc_objAtIdx(1) }
    /// 获取第3个元素
    var axc_thirdObj: Element?  { return axc_objAtIdx(2) }
    /// 获取第4个元素
    var axc_fourthObj: Element? { return axc_objAtIdx(3) }
    /// 获取第5个元素
    var axc_fifthObj: Element?  { return axc_objAtIdx(4) }
    
    // MARK: 倒序取值
    /// 获取倒数第1个元素
    var axc_lastObj: Element?       { return last }
    /// 获取倒数第2个元素
    var axc_lastSecondObj: Element? { return axc_objAtIdx(self.count - 2) }
    /// 获取倒数第3个元素
    var axc_lastThirdObj: Element?  { return axc_objAtIdx(self.count - 3) }
    /// 获取倒数第4个元素
    var axc_lastFourthObj: Element? { return axc_objAtIdx(self.count - 4) }
    /// 获取倒数第5个元素
    var axc_lastFifthObj: Element?  { return axc_objAtIdx(self.count - 5) }
}

// MARK: - 决策判断
public extension Array {
    /// 判断是否为空
    var axc_isEmpty: Bool { return count <= 0 || isEmpty }
    
    /// 判断索引是否越界
    func axc_safeIdx(_ idx: Int) -> Bool { return idx >= 0 && count > idx }
}
