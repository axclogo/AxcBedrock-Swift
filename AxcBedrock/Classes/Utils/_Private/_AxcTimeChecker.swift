//
//  AxcTimeChecker.swift
//  FBSnapshotTestCase
//
//  Created by 赵新 on 2023/2/13.
//

import Foundation

// MARK: - [AxcTimeChecker.Key]

typealias AxcTimeCheckerKey = AxcTimeChecker.Key

// MARK: - [AxcTimeChecker.Key]

extension AxcTimeChecker {
    struct Key: Hashable, Equatable, RawRepresentable {
        init(rawValue: String) {
            self.rawValue = rawValue
        }

        var rawValue: String

        typealias RawValue = String
    }
}

extension AxcTimeCheckerKey {
    static var start: AxcTimeCheckerKey = .init(rawValue: "start")
    static var all: AxcTimeCheckerKey = .init(rawValue: "all")
    static var section: AxcTimeCheckerKey = .init(rawValue: "section")
}

// MARK: - AxcTimeChecker + AxcTimeCheckerTarget

extension AxcTimeChecker: AxcTimeCheckerTarget {
    typealias MarkType = AxcTimeCheckerKey
    
    var logPrefix: String {
        return AxcBedrockLib.Shared.logPrefix
    }
}

// MARK: - [AxcTimeChecker]

class AxcTimeChecker: NSObject { }
