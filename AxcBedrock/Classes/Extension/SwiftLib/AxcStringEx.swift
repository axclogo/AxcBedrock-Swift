//
//  AxcStringEx.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/12/16.
//

import Foundation

fileprivate extension AxcLazyCache.TableKey {
    /// 拼音缓存表，启用缓存
    static let pinYinTable = AxcLazyCache.Table("pinyin_table", enableCache: true)
}

// MARK: - String + AxcSpaceProtocol

extension String: AxcSpaceProtocol { }

// MARK: - 数据转换

public extension AxcSpace where Base == String {
    // MARK: Foundation转换

    /// 类名转Class
    var classFromString: AnyClass? {
//        let projectName = AxcBedrockLib.App.ProjectName.replacingOccurrences(of: "-", with: "_")
//        let name = "\(projectName).\(base)"
        return NSClassFromString(base)
    }

    /// 转换CFString
    var cfString: CFString {
        return base as CFString
    }

    /// 字符串转Data
    var data: Data? {
        return data(encoding: .utf8)
    }

    /// 字符串转Data
    @available(*, deprecated, renamed: "data(encoding:)")
    func data(_ using: String.Encoding = .utf8) -> Data? {
        return data(encoding: using)
    }

    /// 字符串转Data
    @available(*, deprecated, renamed: "data(encoding:)")
    func data(using: String.Encoding = .utf8) -> Data? {
        return data(encoding: using)
    }

    /// 字符串转Data
    func data(encoding: String.Encoding = .utf8) -> Data? {
        guard !base.isEmpty else { return nil }
        return base.data(using: encoding, allowLossyConversion: false)
    }

    /// 字符串转base64Data
    var base64Data: Data? {
        return base64Data(NSData.Base64DecodingOptions())
    }

    /// 字符串转base64Data
    /// - Parameter options: Base64DecodingOptions选项
    /// - Returns: Data
    func base64Data(_ options: Data.Base64DecodingOptions) -> Data? {
        return Data(base64Encoded: base, options: options)
    }

    /// 转成十六进制后转Data
    var hexData: Data? {
        var data = Data(capacity: base.count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: base, range: NSRange(base.startIndex..., in: base))
            { match, _, _ in
                let byteString = (base as NSString).substring(with: match!.range)
                let num = UInt8(byteString, radix: 16)!
                data.append(num)
            }
        guard data.count > 0 else { return nil }
        return data
    }

    /// 字符串全填充转NSRange
    var fullNSRange: NSRange {
        return NSRange(fullRange, in: base)
    }

    /// 字符串全填充转Range
    var fullRange: Range<String.Index> {
        return base.startIndex ..< base.endIndex
    }

    /// 方法名转换Selector
    var selector: Selector {
        return NSSelectorFromString(base)
    }

    /// 获取时间戳
    var date: Date? {
        return date()
    }

    /// 获取时间戳
    /// - Parameter format: 默认时间戳格式 yyyy-MM-dd
    func date(format: AxcSpace<Date>.TimeStamp = .iso8601Day,
              identifier: AxcSpace<TimeZone>.TimeZoneIdentifier = .gmt(.GMT)) -> Date? {
        return date(format: format.rawValue, identifier: identifier)
    }

    /// 获取时间戳
    /// - Parameter format: 默认时间戳格式 yyyy-MM-dd
    func date(format: String,
              identifier: AxcSpace<TimeZone>.TimeZoneIdentifier? = .gmt(.GMT)) -> Date? {
        let formatter = DateFormatter.Axc.Create(format: format,
                                                 identifier: identifier)
        return formatter.date(from: base)
    }

    /// 获取这个字符串的正则对象
    var regular: NSRegularExpression? {
        let regex = try? NSRegularExpression(pattern: base, options: NSRegularExpression.Options())
        return regex
    }

    /// 转换成通知键值
    var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: base)
    }

    /// 本地化转换
    var localized: String {
        return localized()
    }

    /// 本地化转换
    func localized(tableName: String? = nil,
                   bundle: Bundle = Bundle.main,
                   value: String = "") -> String {
        return NSLocalizedString(base,
                                 tableName: tableName,
                                 bundle: bundle,
                                 value: value,
                                 comment: base)
    }

    /// 转换为字符数组
    var characters: [Character] {
        return Array(base)
    }

    // MARK: 编码转换

    /// 获取这个字符串UrlEncoded编码字符
    var urlEncoded: String? {
        guard let encodedStr = base.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return encodedStr
    }

    /// 获取这个字符串UrlDecode解码字符
    var urlDecoded: String? {
        guard let decodedStr = base.removingPercentEncoding else { return nil }
        return decodedStr
    }

    /// 获取这个字符串base64的编码字符串
    var base64Encoded: String? {
        return data?.axc.base64Str
    }

    /// 解码base64的编码字符串
    var base64Decoded: String? {
        if let data = Data(base64Encoded: base, options: .ignoreUnknownCharacters) {
            return data.axc.string
        }
        let remainder = base.count % 4
        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }
        guard let data = Data(base64Encoded: base + padding,
                              options: .ignoreUnknownCharacters) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    /// 获取这个汉字字符串的拼音
    /// 该api首次执行效率低，对性能要求高的地方慎用！
    /// 已通过缓存方式进行优化处理
    var pinYin: String? {
        guard base.count > 0 else { return nil }
        // 缓存代码块
        let py: String = AxcLazyCache.MemoryCache(table: .pinYinTable, key: base) {
            let mutableString = NSMutableString(string: base)
            CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
            return String(mutableString)
        }
        return py
    }

    /// 转换成Html格式的文本
    var htmlStr: String {
        let htmlStr: String =
            """
            <header>
            <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
            <style>img{max-width:100%}</style>
            </header>
            <body id=\"content\">
            \(base)
            </body>
            """
        return htmlStr
    }
}

// MARK: - 类方法

public extension AxcSpace where Base == String {
    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedString?) -> String? {
        guard let unifiedValue = unifiedValue else { return nil }
        // 数据类型
        if let int = unifiedValue as? Int { return String(int) } else
        if let int8 = unifiedValue as? Int8 { return String(int8) } else
        if let int32 = unifiedValue as? Int32 { return String(int32) } else
        if let int64 = unifiedValue as? Int64 { return String(int64) } else
        if let uInt = unifiedValue as? UInt { return String(uInt) } else
        if let uInt8 = unifiedValue as? UInt8 { return String(uInt8) } else
        if let uInt32 = unifiedValue as? UInt32 { return String(uInt32) } else
        if let uInt64 = unifiedValue as? UInt64 { return String(uInt64) } else
        if let float = unifiedValue as? Float { return String(float) } else
        if let double = unifiedValue as? Double { return String(double) } else
        if let cgFloat = unifiedValue as? CGFloat { return String(Float(cgFloat)) } else
        if let bool = unifiedValue as? Bool { return bool ? "true" : "false" } else
        if let nsNumber = unifiedValue as? NSNumber { return nsNumber.stringValue } else
        // 字符串类型
        if let string = unifiedValue as? String { return string } else
        if let subString = unifiedValue as? Substring { return String(subString) } else
        if let char = unifiedValue as? Character { return String(char) } else
        if let cfString = AxcBedrockLib.Func.CFType(unifiedValue, as: CFString.self)
        { return cfString as String } else
        if let cfMutableString = AxcBedrockLib.Func.CFType(unifiedValue, as: CFMutableString.self)
        { return cfMutableString as String } else
        if let nsString = unifiedValue as? NSString
        { return nsString as String } else
        if let nsMutableString = unifiedValue as? NSMutableString
        { return nsMutableString as String } else
        if let nsAttString = unifiedValue as? NSAttributedString
        { return nsAttString.string } else
        if let nsMutableAttString = unifiedValue as? NSMutableAttributedString
        { return nsMutableAttString.string } else
        // 其他类型
        if let url = unifiedValue as? URL { return url.absoluteString } else
        if let data = unifiedValue as? Data { return data.axc.string(encoding: .utf8) ?? "" } else
        if let date = unifiedValue as? Date { return date.axc.string(.iso8601Day) }
        return nil
    }

    /// 配合协议用创建方法
    static func Create(_ unifiedValue: AxcUnifiedString?) -> String {
        return CreateOptional(unifiedValue) ?? ""
    }

    /// 配合协议用创建方法
    static func CreateOptional(_ unifiedValue: AxcUnifiedUrl?) -> String? {
        guard let unifiedValue = unifiedValue else { return nil }
        if let string = unifiedValue as? String { return string }
        if let url = unifiedValue as? URL { return url.absoluteString }
        return nil
    }

    /// 配合协议用创建方法
    static func Create(_ unifiedValue: AxcUnifiedUrl?) -> String {
        return CreateOptional(unifiedValue) ?? ""
    }

    /// 根据长度生成一段随机的字符
    ///
    ///     String.Axc.Random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: 给定的长度
    static func RandomString(_ length: Int) -> String {
        guard length > 0 else { return "" }
        var randomString = ""
        for _ in 1 ... length {
            randomString.append(Character.Axc.RandomCharacter().axc.string)
        }
        return randomString
    }
}

// MARK: - 属性 & Api

public extension AxcSpace where Base == String {
    /// 获取长度
    var length: Int {
        return base.count
    }

    /// 第几个字符转大写
    func uppercased(_ idx: Int) -> String {
        var prefixStr = ""
        if idx > 0 {
            prefixStr = String(base.prefix(idx - 1))
        }
        var suffixStr = ""
        if idx < base.count {
            suffixStr = String(base.suffix(base.count - (idx + 1)))
        }
        let upperStr = string(at: idx) ?? ""
        return prefixStr + upperStr + suffixStr
    }

    /// 转换为驼峰命名
    var camelCased: String {
        let source = base.lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }

    /// 根据索引获取一个字符
    /// - Parameter index: 索引
    func string(at index: Int) -> String? {
        guard index >= 0, index < base.count else { return nil }
        return String(base[base.index(base.startIndex, offsetBy: index)])
    }

    /// 字符串使用下标获取某段字符
    func string(at range: AxcUnifiedRange) -> String? {
        guard let range = Range.Axc.CreateOptional(range),
              range.lowerBound >= 0,
              let lowerIndex = base.index(base.startIndex,
                                          offsetBy: range.lowerBound,
                                          limitedBy: base.endIndex),
              let upperIndex = base.index(base.startIndex,
                                          offsetBy: range.upperBound,
                                          limitedBy: base.endIndex) else { return nil }
        return String(base[lowerIndex ..< upperIndex])
    }

    /// 向后以路径方式拼接
    /// - Parameter string: 拼接的字符串
    /// - Returns: 新字符串
    func appendPathComponent(_ string: String) -> String {
        return base.axc.nsString.appendingPathComponent(string)
    }

    // MARK: 头部操作

    /// 获取第一个字符
    var first: String? {
        guard let first = base.first else { return nil }
        return String(first)
    }

    /// 获取第二个字符
    var second: String? {
        guard base.count >= 2,
              let second = string(at: 1) else { return nil }
        return second
    }

    /// 头部附加某段字符，如果本串自带，则不附加
    /// - Parameter prefix: 附加字符
    func appendPrefix(string: String) -> String {
        guard !base.hasPrefix(string) else { return base }
        return "\(base)\(string)"
    }

    /// 保留头部多少数量的字符
    ///
    ///     "AxcLogo".axc.keepPrefix(count: 3) = "Axc"
    ///     "AxcLogo".axc.keepPrefix(count: 3, suffix: "...") = "Axc..."
    ///
    func keepPrefix(count: Int,
                    suffix: String = "") -> String {
        guard base.count > count else { return base }
        if base.count > count {
            var newStr = base.prefix(count).axc.string
            newStr.append(suffix)
            return newStr
        } else {
            return base
        }
    }

    /// 去掉头部多少位字符
    /// - Parameter count: 位数
    func removePrefix(count: Int) -> String? {
        guard count <= base.count else { return nil }
        return string(at: count ..< base.count)
    }

    /// 去掉头部某种符合的前缀
    /// - Parameter prefix: 需要去除的前缀
    func removePrefix(string: String) -> String {
        guard base.hasPrefix(string) else { return base }
        return base.dropFirst(string.count).axc.string
    }

    /// 移除fileUrl前缀
    /// - Returns: 新字符串
    func removeFileUrlPrefix() -> String {
        return base.axc.removePrefix(string: "file:///")
    }

    // MARK: 尾部操作

    /// 获取最后一个字符
    var last: String? {
        guard let last = base.last else { return nil }
        return last.axc.string
    }

    /// 获取第二个字符
    var lastSecond: String? {
        guard base.count >= 2,
              let second = string(at: base.count - 1) else { return nil }
        return second
    }

    /// 尾部附加某段字符，如果本串自带，则不附加
    /// - Parameter prefix: 附加字符
    func appendSuffix(string: String) -> String {
        guard !base.hasSuffix(string) else { return base }
        return "\(base)\(string)"
    }

    /// 保留尾部多少数量的字符
    ///
    ///     "12345".axc.splitSuffix(count: 3) = 345
    ///
    func keepSuffix(count: Int) -> String {
        guard base.count > count else { return base }
        return base.suffix(count).axc.string
    }

    /// 去掉尾部多少位字符串
    /// - Parameter count: 位数
    func removeSuffix(count: Int) -> String? {
        let count = base.count - count
        guard count >= 0 else { return nil }
        return string(at: 0 ..< count)
    }

    /// 去掉尾部某种符合的后缀
    /// - Parameter suffix: 需要去除的后缀
    func removeSuffix(string: String) -> String {
        guard base.hasSuffix(string) else { return base }
        return base.dropLast(string.count).axc.string
    }

    // MARK: 分隔操作

    /// 切割获取从某个开始到某个结束中间的字符
    /// - Parameters:
    ///   - start: 起始
    ///   - end: 结束
    /// - Returns: 结果
    func split(start: String, end: String) -> [String]? {
        var result: [String] = []
        let pattern = "\(start).+\(end)"
        if let regex = try? AxcRegex(pattern) {
            let splitStr = base.replacingOccurrences(of: end, with: "\(end)\n")
            for match in regex.matches(in: splitStr) {
                result.append(match.string)
            }
            return result
        } else {
            let log = "正则表达式不合法，pattern:\(pattern)"
            AxcBedrockLib.Log(log)
            #if DEBUG
            AxcBedrockLib.FatalLog(log)
            #else
            return []
            #endif
        }
    }

    /// 使用传入的字符进行分隔字符串
    /// - Parameter separator: 传入字符如："-"
    func split(separator: String) -> [String] {
        return base.components(separatedBy: separator)
            .filter {
                !$0.axc.trimmed.isEmpty
            }
    }

    /// 使用传入的多字符进行分隔字符串
    /// - Parameter charStrs: 传入字符如："-,./\][09876"
    func split(charStrs: String) -> [String] {
        return base.components(separatedBy: CharacterSet(charactersIn: charStrs)).filter {
            !$0.axc.trimmed.isEmpty
        }
    }

    /// 使用传入的CharacterSet进行分隔字符串
    /// - Parameter characters: 传入如："CharacterSet.alphanumerics"
    func split(characters: CharacterSet) -> [String] {
        return base.components(separatedBy: characters).filter {
            !$0.axc.trimmed.isEmpty
        }
    }

    // MARK: 过滤操作

    /// 去空修剪后的字符串
    var trimmed: String {
        return base.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// 去除字符中的音调
    /// "Hèllö Wórld!".latinized -> "Hello World!"
    var latinized: String {
        return base.folding(options: .diacriticInsensitive, locale: Locale.current)
    }

    /// 在正则表达式模式中包含的转义字符串
    /// "hello ^$ there" -> "hello \\^\\$ there"
    var regexEscaped: String {
        return NSRegularExpression.escapedPattern(for: base)
    }

    /// 替换字符串
    /// 将多个字符串全部替换成指定的字符串
    /// - Parameters:
    ///   - strings: 原字符串组
    ///   - reStr: 替换字符串
    /// - Returns: 新字符串
    func replacing(strings: [String], with reStr: String? = nil) -> String {
        var newString: String = base
        for string in strings {
            newString = newString.axc.replacing(string, with: reStr)
        }
        return newString
    }

    /// 替换字符串
    /// - Parameters:
    ///   - str: 原字符串
    ///   - reStr: 替换字符串
    /// - Returns: 新字符串
    func replacing(_ str: String, with reStr: String? = nil) -> String {
        let replacStr = reStr ?? ""
        return base.replacingOccurrences(of: str, with: replacStr)
    }

    // MARK: 统计操作

    /// 转换字符数组
    var charsArray: [Character] {
        return Array(base)
    }

    /// 某个子字符串在本串中出现的次数
    /// - Parameters:
    ///   - string: 子串
    ///   - caseSensitive: 是否区分大小写
    func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return base
                .lowercased()
                .components(separatedBy: string.lowercased())
                .count - 1
        }
        return base.components(separatedBy: string).count - 1
    }

    /// 匹配字符串出现的位置
    /// - Parameter matchStr: 匹配的字符串
    /// - Returns: 所有出现的Range
    func matchStr(_ matchStr: String) -> [NSRange] {
        var baseStr = base as NSString
        var withStr = Array(repeating: "X", count: (matchStr as NSString).length).joined(separator: "") // 辅助字符串
        if matchStr == withStr { withStr = withStr.lowercased() } // 临时处理辅助字符串差错
        var allRange = [NSRange]()
        while baseStr.range(of: matchStr).location != NSNotFound {
            let range = baseStr.range(of: matchStr)
            allRange.append(NSRange(location: range.location, length: range.length))
            baseStr = baseStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }

    // MARK: 其他操作

    /// 搜索一组字符的范围
    /// - Parameter textList: 字符列表
    /// - Returns: 范围列表
    func searchRanges(with text: String) -> [NSRange] {
        return searchRanges(with: [text])
    }

    /// 搜索一组字符的范围
    /// - Parameter textList: 字符列表
    /// - Returns: 范围列表
    func searchRanges(with textList: [String]) -> [NSRange] {
        var ranges: [NSRange] = []
        for searchText in textList {
            var searchRange = NSRange(location: 0, length: base.count)
            let nsStr = base.axc.nsString
            var range = nsStr.range(of: searchText, options: .caseInsensitive, range: searchRange)
            while range.location != NSNotFound {
                let max = NSMaxRange(range)
                searchRange = NSRange(location: max, length: base.count - max)
                ranges.append(range)
                range = nsStr.range(of: searchText, options: .caseInsensitive, range: searchRange)
            }
        }
        return ranges
    }

    /// 获取当前字符串的编码类型
    var encodingType: String.Encoding? {
        // 按照使用频率从高到低排序，减少循环次数，优化命中率
        let encodingAllValues: [String.Encoding] = [
            .utf8,
            .utf16, .utf16LittleEndian, .utf16BigEndian,
            .utf32, .utf32LittleEndian, .utf32BigEndian,
            .isoLatin1,
            .ascii,
            .nextstep,
            .nonLossyASCII,
            .shiftJIS,
            .isoLatin2,
            .symbol,
            .iso2022JP,
            .windowsCP1252, .windowsCP1250, .windowsCP1254, .windowsCP1251,
            .macOSRoman,
            .japaneseEUC,
        ]
        // 尝试将字符串转换为 Data 对象，使用不同的编码类型
        for encoding in encodingAllValues {
            if let data = string.data(using: encoding),
               let convertedString = String(data: data, encoding: encoding),
               string == convertedString { // 如果转换后的字符串与原始字符串相等，则表示找到了匹配的编码类型
                return encoding
            }
        }
        // 如果没有找到匹配的编码类型，则返回 nil
        return nil
    }
    
    /// 最后一个路径名称
    var lastPathComponent: String {
        return nsString.lastPathComponent
    }
}

// MARK: - [AxcBlock.Algorithm]

public extension AxcBlock {
    /// 算法类Block
    struct Algorithm {
        public typealias DigestClosure = (_ data: UnsafePointer<UInt8>, _ dataLength: UInt32) -> [UInt8]
    }
}

// MARK: - Hash摘要函数

import CommonCrypto

public extension AxcSpace where Base == String {
    // MARK: 摘要算法枚举

    /// 摘要算法枚举
    enum Digest: CustomStringConvertible {
        /// 摘要枚举
        case md2, md4, md5, sha1, sha224, sha256, sha384, sha512
        /// 加密摘要方式
        func progressClosure() -> AxcBlock.Algorithm.DigestClosure {
            var closure: AxcBlock.Algorithm.DigestClosure?
            switch self {
            case .md2:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_MD2($0, $1, &hash)
                    return hash
                }
            case .md4:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_MD4($0, $1, &hash)
                    return hash
                }
            case .md5:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_MD5($0, $1, &hash)
                    return hash
                }
            case .sha1:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_SHA1($0, $1, &hash)
                    return hash
                }
            case .sha224:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_SHA224($0, $1, &hash)
                    return hash
                }
            case .sha256:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_SHA256($0, $1, &hash)
                    return hash
                }
            case .sha384:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_SHA384($0, $1, &hash)
                    return hash
                }
            case .sha512:
                closure = {
                    var hash = [UInt8](repeating: 0, count: digestLength)
                    CC_SHA512($0, $1, &hash)
                    return hash
                }
            }
            return closure!
        }

        /// 获取摘要长度
        var digestLength: Int {
            var result: CInt = 0
            switch self {
            case .md2: result = CC_MD2_DIGEST_LENGTH
            case .md4: result = CC_MD4_DIGEST_LENGTH
            case .md5: result = CC_MD5_DIGEST_LENGTH
            case .sha1: result = CC_SHA1_DIGEST_LENGTH
            case .sha224: result = CC_SHA224_DIGEST_LENGTH
            case .sha256: result = CC_SHA256_DIGEST_LENGTH
            case .sha384: result = CC_SHA384_DIGEST_LENGTH
            case .sha512: result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }

        /// 摘要描述
        public var description: String {
            switch self {
            case .md2: return "Digest.MD2"
            case .md4: return "Digest.MD4"
            case .md5: return "Digest.MD5"
            case .sha1: return "Digest.SHA1"
            case .sha224: return "Digest.SHA224"
            case .sha256: return "Digest.SHA256"
            case .sha384: return "Digest.SHA384"
            case .sha512: return "Digest.SHA512"
            }
        }
    }

    // MARK: 摘要算法函数

    /// 获取摘要字符串
    func hashStr(_ algorithm: Digest) -> String? {
        guard let data = data else { return nil }
        return data.axc.hashStr(algorithm)
    }

    /// 获取摘要[UInt8]数组
    func hashBytes(_ algorithm: Digest) -> [UInt8]? {
        guard let data = data else { return nil }
        return data.axc.hashBytes(algorithm)
    }

    /// 获取Data摘要
    func hashData(_ algorithm: Digest) -> Data? {
        guard let data = data else { return nil }
        return data.axc.hashData(algorithm)
    }

    /// 获取摘要的Base64字符串
    func hashBase64(_ algorithm: Digest) -> String? {
        guard let data = data else { return nil }
        return data.axc.hashBase64(algorithm)
    }
}

// MARK: - Hamc签名函数

public extension AxcSpace where Base == String {
    // MARK: 签名算法枚举

    enum Hmac: CustomStringConvertible {
        case md5, sha1, sha224, sha256, sha384, sha512
        /// 算法枚举
        var toCCEnum: CCHmacAlgorithm {
            var result: Int = 0
            switch self {
            case .md5: result = kCCHmacAlgMD5
            case .sha1: result = kCCHmacAlgSHA1
            case .sha224: result = kCCHmacAlgSHA224
            case .sha256: result = kCCHmacAlgSHA256
            case .sha384: result = kCCHmacAlgSHA384
            case .sha512: result = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(result)
        }

        /// 长度
        var digestLength: Int {
            var result: CInt = 0
            switch self {
            case .md5: result = CC_MD5_DIGEST_LENGTH
            case .sha1: result = CC_SHA1_DIGEST_LENGTH
            case .sha224: result = CC_SHA224_DIGEST_LENGTH
            case .sha256: result = CC_SHA256_DIGEST_LENGTH
            case .sha384: result = CC_SHA384_DIGEST_LENGTH
            case .sha512: result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }

        /// 描述
        public var description: String {
            switch self {
            case .md5: return "HMAC.MD5"
            case .sha1: return "HMAC.SHA1"
            case .sha224: return "HMAC.SHA224"
            case .sha256: return "HMAC.SHA256"
            case .sha384: return "HMAC.SHA384"
            case .sha512: return "HMAC.SHA512"
            }
        }
    }

    // MARK: 签名算法函数

    /// 获取签名字符串
    func hamcStr(_ algorithm: Hmac, key: String) -> String? {
        guard let data = data else { return nil }
        return data.axc.hamcStr(algorithm, key: key)
    }

    /// 获取签名[UInt8]数组
    func hamcBytes(_ algorithm: Hmac, key: String) -> [UInt8]? {
        guard let data = data else { return nil }
        return data.axc.hamcBytes(algorithm, key: key)
    }

    /// 获取Data签名
    func hamcData(_ algorithm: Hmac, key: String) -> Data? {
        guard let data = data else { return nil }
        return data.axc.hamcData(algorithm, key: key)
    }

    /// 获取签名base64字符串
    func hamcBase64(_ algorithm: Hmac, key: String) -> String? {
        guard let data = data else { return nil }
        return data.axc.hamcBase64(algorithm, key: key)
    }
}

// MARK: - 决策判断

public extension AxcSpace where Base == String {
    /// 判断是否符合某种正则
    /// - Parameter pattern: 正则表达式
    /// - Returns: 结果
    func isConform(pattern: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: base)
    }

    func isJSONString(encoding: String.Encoding) -> Bool {
        guard let data = data(encoding: encoding),
              let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [])
        else { return false }
        let result = jsonObj is [String: Any] || jsonObj is [Any]
        return result
    }

    /// 判断是否含包含汉字
    func isContantChinese() -> Bool {
        for item in base {
            if ("\u{4E00}" <= item && item <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }

    /// 判断是否包含emoji
    @available(iOS 10.2, *)
    @available(iOSApplicationExtension 10.2, *)
    func isContantEmoji() -> Bool {
        for character in base {
            if character.axc.isEmoji() {
                return true
            }
        }
        return false
    }
}
