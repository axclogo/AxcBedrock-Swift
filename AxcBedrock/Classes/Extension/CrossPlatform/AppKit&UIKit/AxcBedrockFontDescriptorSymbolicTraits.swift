//
//  AxcBedrock.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/2/11.
//

/// （💈跨平台标识）字体描述符符号特征
public typealias AxcFontDescriptorSymbolicTraits = AxcBedrockLib.FontDescriptorSymbolicTraits

#if os(macOS)
import AppKit

public extension AxcBedrockLib {
    /// 字体描述符符号特征
    struct FontDescriptorSymbolicTraits: OptionSet {
        public let rawValue: Int32

        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public init(rawValue: Int) {
            self.rawValue = Int32(rawValue)
        }

        public init(symbolicTraits: NSFontSymbolicTraits) {
            var traits = FontDescriptorSymbolicTraits()

            if symbolicTraits & UInt32(NSFontItalicTrait) == UInt32(NSFontItalicTrait) {
                traits.insert(.traitItalic)
            }

            if symbolicTraits & UInt32(NSFontBoldTrait) == UInt32(NSFontBoldTrait) {
                traits.insert(.traitBold)
            }

            if symbolicTraits & UInt32(NSFontExpandedTrait) == UInt32(NSFontExpandedTrait) {
                traits.insert(.traitExpanded)
            }

            if symbolicTraits & UInt32(NSFontCondensedTrait) == UInt32(NSFontCondensedTrait) {
                traits.insert(.traitCondensed)
            }

            if symbolicTraits & UInt32(NSFontMonoSpaceTrait) == UInt32(NSFontMonoSpaceTrait) {
                traits.insert(.traitMonoSpace)
            }

            if symbolicTraits & UInt32(NSFontVerticalTrait) == UInt32(NSFontVerticalTrait) {
                traits.insert(.traitVertical)
            }

            if symbolicTraits & UInt32(NSFontUIOptimizedTrait) == UInt32(NSFontUIOptimizedTrait) {
                traits.insert(.traitUIOptimized)
            }

            self = traits
        }

        public static let traitItalic = FontDescriptorSymbolicTraits(rawValue: NSFontItalicTrait)
        public static let traitBold = FontDescriptorSymbolicTraits(rawValue: NSFontBoldTrait)
        public static let traitExpanded = FontDescriptorSymbolicTraits(rawValue: NSFontExpandedTrait)
        public static let traitCondensed = FontDescriptorSymbolicTraits(rawValue: NSFontCondensedTrait)
        public static let traitMonoSpace = FontDescriptorSymbolicTraits(rawValue: NSFontMonoSpaceTrait)
        public static let traitVertical = FontDescriptorSymbolicTraits(rawValue: NSFontVerticalTrait)
        public static let traitUIOptimized = FontDescriptorSymbolicTraits(rawValue: NSFontUIOptimizedTrait)

        public var symbolicTraits: NSFontSymbolicTraits {
            var symbolicTraits: NSFontSymbolicTraits = 0

            if contains(.traitItalic) {
                symbolicTraits ^= UInt32(NSFontItalicTrait)
            }

            if contains(.traitBold) {
                symbolicTraits ^= UInt32(NSFontBoldTrait)
            }

            if contains(.traitExpanded) {
                symbolicTraits ^= UInt32(NSFontExpandedTrait)
            }

            if contains(.traitCondensed) {
                symbolicTraits ^= UInt32(NSFontCondensedTrait)
            }

            if contains(.traitMonoSpace) {
                symbolicTraits ^= UInt32(NSFontMonoSpaceTrait)
            }

            if contains(.traitVertical) {
                symbolicTraits ^= UInt32(NSFontVerticalTrait)
            }

            if contains(.traitUIOptimized) {
                symbolicTraits ^= UInt32(NSFontUIOptimizedTrait)
            }

            return symbolicTraits
        }
    }
}

#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit

public extension AxcBedrockLib {
    /// 字体描述符符号特征
    typealias FontDescriptorSymbolicTraits = UIFontDescriptor.SymbolicTraits
}
#endif
