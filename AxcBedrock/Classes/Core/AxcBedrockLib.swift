//
//  AxcBedrock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

import Foundation

// MARK: - [AxcBedrockLib]

open class AxcBedrockLib: NSObject {
    public var attribute: Any?
}

// MARK: AxcLibraryTarget

extension AxcBedrockLib: AxcLibraryTarget {
    public var moduleName: String {
        return "AxcBedrock"
    }

    public var moduleEmoji: String? {
        return "🔃"
    }
    
    public typealias ErrorType = AxcBedrockError
}
