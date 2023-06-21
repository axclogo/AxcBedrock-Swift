//
//  AxcDateFormatterEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/20.
//

import Foundation

public extension AxcSpace where Base == DateFormatter {
    /// 格式对象
    /// - Parameters:
    static func Create(format: String,
                       identifier: AxcSpace<TimeZone>.TimeZoneIdentifier? = nil)
        -> DateFormatter
    {
        let dateFormatter = Foundation.DateFormatter()
        if let identifier = identifier {
            dateFormatter.timeZone = .Axc.CreateOptional(identifier: identifier)
        }
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
