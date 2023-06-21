//
//  AxcUnifiedNumber+AppKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/21.
//

#if canImport(AppKit)

import AppKit

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 转换成NSEdgeInsets
    var nsEdge: NSEdgeInsets {
        return NSEdgeInsets.Axc.Create(base)
    }

    /// 转换成NSEdgeInsets的Top，其他为0
    var nsEdgeTop: NSEdgeInsets {
        return NSEdgeInsets.Axc.Create(base, 0, 0, 0)
    }

    /// 转换成NSEdgeInsets的Left，其他为0
    var nsEdgeLeft: NSEdgeInsets {
        return NSEdgeInsets.Axc.Create(0, base, 0, 0)
    }

    /// 转换成NSEdgeInsets的Bottom，其他为0
    var nsEdgeBottom: NSEdgeInsets {
        return NSEdgeInsets.Axc.Create(0, 0, base, 0)
    }

    /// 转换成NSEdgeInsets的Right，其他为0
    var nsEdgeRight: NSEdgeInsets {
        return NSEdgeInsets.Axc.Create(0, 0, 0, base)
    }
}

#endif
