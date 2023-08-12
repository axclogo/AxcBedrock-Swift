//
//  AxcDataEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2022/1/21.
//

import Foundation

// MARK: - Data + AxcSpaceProtocol

extension Data: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == Data {
    /// 转成NSData
    var nsData: NSData {
        return base as NSData
    }

    /// data转CFData
    var cfData: CFData {
        return base as CFData
    }

    /// 通过给定的编码来返回字符串
    @available(*, deprecated, renamed: "string(encoding:)")
    func string(_ encoding: String.Encoding) -> String? {
        return string(encoding: encoding)
    }

    /// 通过给定的编码来返回字符串
    func string(encoding: String.Encoding) -> String? {
        return String(data: base, encoding: encoding)
    }

    /// 转换为Base64字符串
    var base64Str: String {
        return base64Str(NSData.Base64EncodingOptions(rawValue: 0))
    }

    /// 转换为Base64字符串
    /// - Parameter options: 选项
    /// - Returns: String
    func base64Str(_ options: NSData.Base64EncodingOptions) -> String {
        return base.base64EncodedString(options: options)
    }

    /// 转换为十六进制字符串
    var hexStr: String {
        let string = NSMutableString(capacity: base.count * 2)
        var byte: UInt8 = 0
        for i in 0 ..< base.count {
            base.copyBytes(to: &byte, from: i ..< base.index(after: i))
            string.appendFormat("%02x", byte)
        }
        return string as String
    }

    /// 转换成plain富文本
    var attributedPlainStr: NSAttributedString {
        return attributedStr(documentType: .plain)
    }

    /// 转换成rtf富文本
    var attributedRtfStr: NSAttributedString {
        return attributedStr(documentType: .rtf)
    }

    /// 转换成rtfd富文本
    var attributedRtfdStr: NSAttributedString {
        return attributedStr(documentType: .rtfd)
    }

    /// 转换成Html富文本
    var attributedHtmlStr: NSAttributedString {
        return attributedStr(documentType: .html)
    }

    /// 转换成富文本
    /// - Parameter documentType: 类型
    /// - Returns: 富文本
    func attributedStr(documentType: NSAttributedString.DocumentType) -> NSAttributedString {
        return attributedStr(options: [.documentType: documentType])
    }

    /// 转换成富文本
    /// - Parameters:
    ///   - options: 类型
    ///   - documentAttributes: 富文本属性
    /// - Returns: 富文本
    func attributedStr(options: [NSAttributedString.DocumentReadingOptionKey: Any],
                       documentAttributes: AutoreleasingUnsafeMutablePointer<NSDictionary?>? = nil) -> NSAttributedString
    {
        do { return try NSAttributedString(data: base,
                                           options: options,
                                           documentAttributes: documentAttributes) } catch {
            let log = "Data转换NSAttributedString错误！\nOptions:\(options)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return NSAttributedString()
            #endif
        }
    }

    /// 以字节数组的形式返回数据
    var bytes: UnsafeRawPointer { nsData.bytes }

    /// 以字节数组的形式返回数据
    func byteArray() -> [UInt8] {
        let count = base.count / MemoryLayout<UInt8>.size
        var bytesArray = [UInt8](repeating: 0, count: count)
        (base as NSData).getBytes(&bytesArray, length: count * MemoryLayout<UInt8>.size)
        return bytesArray
    }
}


// MARK: - Hash摘要算法

public extension AxcSpace where Base == Data {
    /// 获取摘要字符串
    func hashStr(_ algorithm: AxcSpace<String>.Digest) -> String {
        let digestLength = algorithm.digestLength
        let bytes = hashBytes(algorithm)
        var hashString: String = ""
        for i in 0 ..< digestLength {
            hashString += String(format: "%02x", bytes[i])
        }
        return hashString
    }

    /// 获取摘要[UInt8]数组
    func hashBytes(_ algorithm: AxcSpace<String>.Digest) -> [UInt8] {
        let string = bytes.bindMemory(to: UInt8.self, capacity: base.count)
        let stringLength = UInt32(base.count)
        let closure = algorithm.progressClosure()
        let bytes = closure(string, stringLength)
        return bytes
    }

    /// 获取Data摘要
    func hashData(_ algorithm: AxcSpace<String>.Digest) -> Data {
        let bytes = hashBytes(algorithm)
        return Data(bytes: bytes, count: bytes.count)
    }

    /// 获取摘要的Base64字符串
    func hashBase64(_ algorithm: AxcSpace<String>.Digest) -> String {
        let data = hashData(algorithm)
        return data.axc.base64Str
    }
}

// MARK: - Hamc签名算法

import CommonCrypto

public extension AxcSpace where Base == Data {
    /// 获取签名字符串
    func hamcStr(_ algorithm: AxcSpace<String>.Hmac, key: String) -> String {
        let bytes = hamcBytes(algorithm, key: key)
        let digestLength = bytes.count
        var hash: String = ""
        for i in 0 ..< digestLength {
            hash += String(format: "%02x", bytes[i])
        }
        return hash
    }

    /// 获取签名[UInt8]数组
    func hamcBytes(_ algorithm: AxcSpace<String>.Hmac, key: String) -> [UInt8] {
        let string = bytes.bindMemory(to: UInt8.self, capacity: base.count)
        let stringLength = base.count
        let digestLength = algorithm.digestLength
        let keyString = key.cString(using: String.Encoding.utf8)!
        let keyLength = key.lengthOfBytes(using: String.Encoding.utf8)
        var result = [UInt8](repeating: 0, count: digestLength)
        CCHmac(algorithm.toCCEnum, keyString, keyLength, string, stringLength, &result)
        return result
    }

    /// 获取Data签名
    func hamcData(_ algorithm: AxcSpace<String>.Hmac, key: String) -> Data {
        let bytes = hamcBytes(algorithm, key: key)
        let data = Data(bytes: bytes, count: bytes.count)
        return data
    }

    /// 获取签名的Base64字符串
    func hamcBase64(_ algorithm: AxcSpace<String>.Hmac, key: String) -> String {
        let data = hamcData(algorithm, key: key)
        return data.axc.base64Str
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == Data { }

// MARK: - 决策判断

public extension AxcSpace where Base == Data { }
