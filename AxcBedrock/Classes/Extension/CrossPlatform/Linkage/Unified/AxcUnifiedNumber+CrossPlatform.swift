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
    var edgeInsets: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(all: base)
    }

    /// 转换成EdgeInsets的Top，其他为0
    var edgeInsetsTop: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(top: base, left: 0, bottom: 0, right: 0)
    }

    /// 转换成EdgeInsets的Left，其他为0
    var edgeInsetsLeft: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(top: 0, left: base, bottom: 0, right: 0)
    }

    /// 转换成EdgeInsets的Bottom，其他为0
    var edgeInsetsBottom: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(top: 0, left: 0, bottom: base, right: 0)
    }

    /// 转换成EdgeInsets的Right，其他为0
    var edgeInsetsRight: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(top: 0, left: 0, bottom: 0, right: base)
    }

    /// 转换成EdgeInsets的Left、Right，其他为0
    var edgeInsetsHorizontal: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(top: 0, left: base, bottom: 0, right: base)
    }

    /// 转换成EdgeInsets的Top、Bottom，其他为0
    var edgeInsetsVertical: AxcBedrockEdgeInsets {
        return AxcBedrockEdgeInsets.Axc.Create(top: base, left: 0, bottom: base, right: 0)
    }
}

// MARK: - 废弃需替换 — 已删除（项目未上线，无需保留兼容层）
