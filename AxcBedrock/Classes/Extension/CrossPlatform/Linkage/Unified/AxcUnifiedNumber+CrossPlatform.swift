//
//  AxcUnifiedNumber+CrossPlatform.swift
//  AxcBedrock-Core
//
//  Created by 赵新 on 2023/7/28.
//

import Foundation

// MARK: 通用转换

public extension AxcSpace where Base: AxcUnifiedNumber {
    /// 转换成EdgeInsets
    var edge: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(base)
    }

    /// 转换成EdgeInsets的Top，其他为0
    var edgeTop: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(base, 0, 0, 0)
    }

    /// 转换成EdgeInsets的Left，其他为0
    var edgeLeft: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(0, base, 0, 0)
    }

    /// 转换成EdgeInsets的Bottom，其他为0
    var edgeBottom: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(0, 0, base, 0)
    }

    /// 转换成EdgeInsets的Right，其他为0
    var edgeRight: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(0, 0, 0, base)
    }

    /// 转换成EdgeInsets的Left、Right，其他为0
    var edgeHorizontal: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(0, base, 0, base)
    }

    /// 转换成EdgeInsets的Top、Bottom，其他为0
    var edgeVertical: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(base, 0, base, 0)
    }
}
