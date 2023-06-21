//
//  AxcArrayEx+Sort.swift
//  Pods
//
//  Created by 赵新 on 2023/3/29.
//

// MARK: - [AxcArraySpace.SortType]

public extension AxcArraySpace {
    /// 排序类型
    enum SortType {
        /// 升序
        case ascending
        /// 降序
        case descending
    }
}

// MARK: 堆排序

public extension AxcArraySpace where Element: Comparable {
    /// 堆排序，时间复杂度为 O(nlogn)
    /// 堆排序是一种高效的排序算法，其主要应用场景包括：
    /// 大数据量排序：堆排序具有稳定的时间复杂度，因此在排序大数据量时表现良好。
    /// 实时数据排序：堆排序可以对数据进行实时排序，例如在高速数据流中对数据进行排序，可以利用堆排序对数据进行处理并及时输出结果。
    /// 优先级队列：堆排序可以用来实现优先级队列，例如操作系统中的任务调度等场景。
    /// 中位数查找：通过利用堆排序中的特性，可以快速地查找一组数据的中位数。
    /// 总之，堆排序适用于需要高效排序的场景，以及需要快速实现优先级队列和中位数查找等操作的场景。
    /// - Parameter sortType: 升序或降序
    /// - Returns: 排序后的结果
    func heapSort(sortType: SortType) -> [Element] {
        var sortArray = base // 复制数组
        // 构建初始堆
        _buildMaxHeap(&sortArray, sortType: sortType)

        // 将堆顶元素（最大值）与堆底元素交换位置，并从堆中删除最大值
        for i in stride(from: sortArray.count - 1, through: 1, by: -1) {
            sortArray.swapAt(0, i)
            _heapify(&sortArray, index: 0, endIndex: i - 1, sortType: sortType)
        }
        return sortArray
    }

    /// 构建最大堆
    fileprivate func _buildMaxHeap(_ array: inout [Element], sortType: SortType) {
        let n = array.count
        for i in stride(from: n / 2 - 1, through: 0, by: -1) {
            _heapify(&array, index: i, endIndex: n - 1, sortType: sortType)
        }
    }

    /// 将堆从指定位置开始递归地调整为最大堆
    fileprivate func _heapify(_ array: inout [Element], index: Int, endIndex: Int, sortType: SortType) {
        var largest = index
        let left = index * 2 + 1
        let right = index * 2 + 2
        // 找出左右子节点中的最大值
        let isLeft = left <= endIndex
        let isRight = right <= endIndex
        switch sortType {
        case .ascending: // 升序
            if isLeft, array[left] > array[largest] { largest = left }
            if isRight, array[right] > array[largest] { largest = right }
        case .descending: // 降序
            if isLeft, array[left] < array[largest] { largest = left }
            if isRight, array[right] < array[largest] { largest = right }
        }
        // 如果最大值不是当前节点，则交换它们的位置，并递归地调整堆
        if largest != index {
            array.swapAt(largest, index)
            _heapify(&array, index: largest, endIndex: endIndex, sortType: sortType)
        }
    }
}

// MARK: 基数排序

public extension AxcArraySpace where Element: AxcArraySortWeightProtocol {
    /// 基数排序，时间复杂度为O(dn)，其中d为数据的最大位数，n为数据个数
    /// 基数排序是一种非比较排序算法，可以用于对一组数据进行排序。基数排序的应用场景主要包括以下几个方面：
    /// 大量数据的排序：基数排序适合处理大量数据的排序，因为它的时间复杂度为O(dn)，其中d为数据的最大位数，n为数据个数。
    /// 数据范围有限：基数排序要求排序数据的取值范围有限，可以通过将数据分解为多个关键字，每个关键字的取值范围较小，然后对每个关键字进行排序，最终得到有序序列。
    /// 数据结构简单：基数排序不需要使用复杂的数据结构，只需要使用桶、队列等简单的数据结构就可以实现。
    /// 适合对稳定性要求高的排序：基数排序是一种稳定排序算法，即相同元素的相对位置不会发生改变，适合对稳定性要求较高的排序场景。
    /// 适合对内存要求高的排序：基数排序是一种非常适合对内存要求较高的排序算法，因为它不需要进行元素之间的比较，只需要对每个关键字进行排序。
    /// - Parameter sortType: 升序或降序
    /// - Returns: 排序后的结果
    func radixSort(sortType: SortType) -> [Element] {
        var sortArray = base // 复制数组
        guard let maxNumber = sortArray.map({ $0.sortWeight }).max() else { return sortArray }
        var digit = 1
        var buckets: [[Element]] = Array(repeating: [], count: 10)
        while digit <= maxNumber {
            for number in sortArray {
                let index = (number.sortWeight / digit) % 10
                buckets[index].append(number)
            }
            sortArray.removeAll()
            var sortBuckets = buckets
            // 改变桶的遍历顺序即可
            switch sortType {
            case .ascending: sortBuckets = buckets
            case .descending: sortBuckets = buckets.reversed()
            }
            for bucket in sortBuckets {
                sortArray.append(contentsOf: bucket)
            }
            digit *= 10
            buckets = Array(repeating: [], count: 10)
        }
        return sortArray
    }
}
