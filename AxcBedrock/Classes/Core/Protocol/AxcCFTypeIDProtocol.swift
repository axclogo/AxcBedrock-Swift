//
//  _AxcCFTypeIDProtocol.swift
//  AxcBedrock
//
//  Created by 赵新 on 2023/2/11.
//

import CoreText

// MARK: - [AxcCFTypeIDProtocol]

/// CF统一类型协议
public protocol AxcCFTypeIDProtocol {
    static var typeID: CFTypeID { get }
}

#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - CGFont + AxcCFTypeIDProtocol

extension CGFont: AxcCFTypeIDProtocol { }

// MARK: - CGColor + AxcCFTypeIDProtocol

extension CGColor: AxcCFTypeIDProtocol { }

// MARK: - CGImage + AxcCFTypeIDProtocol

extension CGImage: AxcCFTypeIDProtocol { }

// MARK: - CGLayer + AxcCFTypeIDProtocol

extension CGLayer: AxcCFTypeIDProtocol { }

// MARK: - CGPath + AxcCFTypeIDProtocol

extension CGPath: AxcCFTypeIDProtocol { }
#endif

#if canImport(CoreFoundation)
import CoreFoundation

// MARK: - CFString + AxcCFTypeIDProtocol

extension CFString: AxcCFTypeIDProtocol {
    public static var typeID: CFTypeID {
        return CFStringGetTypeID()
    }
}

// MARK: - CTFont + AxcCFTypeIDProtocol

extension CTFont: AxcCFTypeIDProtocol {
    public static var typeID: CFTypeID {
        return CTFontGetTypeID()
    }
}

// MARK: - CTFrame + AxcCFTypeIDProtocol

extension CTFrame: AxcCFTypeIDProtocol {
    public static var typeID: CFTypeID {
        return CTFontGetTypeID()
    }
}

// MARK: - CTLine + AxcCFTypeIDProtocol

extension CTLine: AxcCFTypeIDProtocol {
    public static var typeID: CFTypeID {
        return CTFontGetTypeID()
    }
}

#endif
