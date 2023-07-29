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

// MARK: - 废弃需替换

public extension AxcSpace where Base: AxcUnifiedNumber {
    // MARK: UIKit

    /// 转换成EdgeInsets
    @available(*, deprecated, renamed: "edge")
    var uiEdge: AxcBedrockEdgeInsets {
        return edge
    }

    /// 转换成EdgeInsets的Top，其他为0
    @available(*, deprecated, renamed: "edgeTop")
    var uiEdgeTop: AxcBedrockEdgeInsets {
        return edgeTop
    }

    /// 转换成EdgeInsets的Left，其他为0
    @available(*, deprecated, renamed: "edgeLeft")
    var uiEdgeLeft: AxcBedrockEdgeInsets {
        return edgeLeft
    }

    /// 转换成EdgeInsets的Bottom，其他为0
    @available(*, deprecated, renamed: "edgeBottom")
    var uiEdgeBottom: AxcBedrockEdgeInsets {
        return edgeBottom
    }

    /// 转换成EdgeInsets的Right，其他为0
    @available(*, deprecated, renamed: "edgeRight")
    var uiEdgeRight: AxcBedrockEdgeInsets {
        return edgeRight
    }

    /// 转换成EdgeInsets的Left、Right，其他为0
    @available(*, deprecated, renamed: "edgeHorizontal")
    var uiEdgeHorizontal: AxcBedrockEdgeInsets {
        return edgeHorizontal
    }

    /// 转换成EdgeInsets的Top、Bottom，其他为0
    @available(*, deprecated, renamed: "edgeVertical")
    var uiEdgeVertical: AxcBedrockEdgeInsets {
        return edgeVertical
    }

    // MARK: AppKit

    /// 转换成EdgeInsets
    @available(*, deprecated, renamed: "edge")
    var nsEdge: AxcBedrockEdgeInsets {
        return edge
    }

    /// 转换成EdgeInsets的Top，其他为0
    @available(*, deprecated, renamed: "edgeTop")
    var nsEdgeTop: AxcBedrockEdgeInsets {
        return edgeTop
    }

    /// 转换成EdgeInsets的Left，其他为0
    @available(*, deprecated, renamed: "edgeLeft")
    var nsEdgeLeft: AxcBedrockEdgeInsets {
        return edgeLeft
    }

    /// 转换成EdgeInsets的Bottom，其他为0
    @available(*, deprecated, renamed: "edgeBottom")
    var nsEdgeBottom: AxcBedrockEdgeInsets {
        return edgeBottom
    }

    /// 转换成EdgeInsets的Right，其他为0
    @available(*, deprecated, renamed: "edgeRight")
    var nsEdgeRight: AxcBedrockEdgeInsets {
        return edgeRight
    }

    /// 转换成EdgeInsets的Left、Right，其他为0
    @available(*, deprecated, renamed: "edgeHorizontal")
    var nsEdgeHorizontal: AxcBedrockEdgeInsets {
        return edgeHorizontal
    }

    /// 转换成EdgeInsets的Top、Bottom，其他为0
    @available(*, deprecated, renamed: "edgeVertical")
    var nsEdgeVertical: AxcBedrockEdgeInsets {
        return edgeVertical
    }
}
