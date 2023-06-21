//
//  AxcUnifiedNumber+UIKit.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/14.
//

#if canImport(UIKit)

import UIKit

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 转换成UIEdgeInsets
    var uiEdge: UIEdgeInsets {
        return UIEdgeInsets.Axc.Create(base)
    }

    /// 转换成UIEdgeInsets的Top，其他为0
    var uiEdgeTop: UIEdgeInsets {
        return UIEdgeInsets.Axc.Create(base, 0, 0, 0)
    }

    /// 转换成UIEdgeInsets的Left，其他为0
    var uiEdgeLeft: UIEdgeInsets {
        return UIEdgeInsets.Axc.Create(0, base, 0, 0)
    }

    /// 转换成UIEdgeInsets的Bottom，其他为0
    var uiEdgeBottom: UIEdgeInsets {
        return UIEdgeInsets.Axc.Create(0, 0, base, 0)
    }

    /// 转换成UIEdgeInsets的Right，其他为0
    var uiEdgeRight: UIEdgeInsets {
        return UIEdgeInsets.Axc.Create(0, 0, 0, base)
    }

    /// 转换成UIEdgeInsets的Left、Right，其他为0
    var uiEdgeHorizontal: UIEdgeInsets {
        return UIEdgeInsets.Axc.Create(0, base, 0, base)
    }

    /// 转换成UIEdgeInsets的Top、Bottom，其他为0
    var uiEdgeVertical: UIEdgeInsets {
        return UIEdgeInsets.Axc.Create(base, 0, base, 0)
    }
}

#endif
