//
//  AxcStringEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/1.
//

import UIKit
import CommonCrypto


// MARK: - 数据转换 - 扩展
public extension String {
    /// 转换CFString
    var axc_cfString: CFString {
        return self as CFString
    }
    // MARK: Foundation转换
    /// 字符串转Data
    var axc_data: Data? {
        return axc_data()
    }
    /// 字符串转Data
    func axc_data(_ using: Encoding = .utf8) -> Data? {
        return data(using: using, allowLossyConversion: false)
    }
    
    /// 字符串转base64Data
    var axc_base64Data: Data? {
        return axc_base64Data(NSData.Base64DecodingOptions())
    }
    /// 字符串转base64Data
    /// - Parameter options: Base64DecodingOptions选项
    /// - Returns: Data
    func axc_base64Data(_ options: Data.Base64DecodingOptions) -> Data? {
        return Data(base64Encoded: self, options: options)
    }
    
    /// 转成十六进制后转Data
    var axc_hexData: Data? {
        var data = Data(capacity: count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        guard data.count > 0 else { return nil }
        return data
    }
    
    /// 如果这个字符串本身是json，那么调用此可以直接获取Object
    /// 也可以用来判断是否为json字符串，nil 就不是json字符串
    var axc_jsonObj: Any? {
        return axc_data?.axc_jsonObj
    }
    
    /// 类名转换Class
    var axc_class: AnyClass? {
        return AxcStringFromClass(self)
    }
    /// 方法名转换Selector
    var axc_selector: Selector {
        return NSSelectorFromString(self)
    }
    
    /// 获取时间戳
    var axc_date: Date? {
        return axc_date()
    }
    
    /// 获取时间戳
    /// - Parameter format: 默认时间戳格式 yyyy-MM-dd
    func axc_date(_ format: String = AxcTimeStamp.iso8601Day) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    /// 获取这段字符串的NSRange
    var axc_nsRange: NSRange {
        NSRange(startIndex ..< endIndex, in: self)
    }
    
    /// 获取这个路径下的文件数据
    var axc_fileData: Data? {
        guard let url = axc_url else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    
    /// 获取这个字符串的正则对象
    var axc_regular: NSRegularExpression? {
        let regex = try? NSRegularExpression(pattern: self, options: NSRegularExpression.Options())
        return regex
    }
    
    /// 转换成URL
    var axc_url: URL? {
        return URL(string: self)
    }
    /// 转换成文件路径URL
    var axc_fileUrl: URL? {
        return URL(fileURLWithPath: self)
    }
    
    /// 转换成URLRequest
    var axc_urlRequest: URLRequest? {
        guard let url = axc_url else { return nil }
        return URLRequest(url: url)
    }
    
    /// 转换成通知键值
    var axc_notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: self)
    }
    
    // MARK: UIKit转换
    /// 获取工程中Bundle图片
    func axc_image(_ bundle: Bundle) -> UIImage {
        guard self.count != 0 else { return UIImage() }
        return UIImage(named: self, in: bundle, compatibleWith: nil) ?? UIImage()
    }
    
    /// 根据这个nib类名生成View
    var axc_nibView: UIView? {
        guard let view = Axc_bundle.loadNibNamed(self, owner: nil, options: nil)?.first as? UIView else { return nil }
        return view
    }
    
    /// 将这个base64字符转换成图片
    var axc_base64Image: UIImage? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else { return nil }
        return UIImage(data: data)
    }
    
    /// 生成字符串对应的二维码图片
    var axc_qrCodeImage: UIImage? {
        return axc_qrCodeImage()
    }
    
    /// 字体名大小转UIFont
    func axc_fontSize(_ size: AxcUnifiedNumberTarget) -> UIFont {
        return UIFont(name: self, size: size.axc_cgFloat) ?? size.axc_cgFloat.axc_font
    }
    
    /// 生成字符串对应的二维码图片
    /// - Parameter size: 大小，默认1024
    /// - Returns: 图片
    func axc_qrCodeImage(size: CGSize = CGSize.axc_1024Size ) -> UIImage? {
        guard let ciImage = axc_qrCodeCIImage else { return nil }
        guard let cgImage = ciImage.axc_hdImage(size) else { return nil }
        return UIImage(cgImage: cgImage )
    }
    #warning(" 更新滤镜")
    /// 获取以这个字符串为内容生成CIImage格式的二维码
    var axc_qrCodeCIImage: CIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setDefaults()
        guard let data = axc_data else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        guard let outPutImage = filter.outputImage else { return nil }
        return outPutImage
    }
    
    /// 标记成富文本
    /// - Parameters:
    ///   - text: 标记文字
    ///   - color: 颜色可选
    ///   - font: 字体可选
    ///   - backgroundColor: 背景色可选
    /// - Returns: NSMutableAttributedString
    func axc_mark(_ text: String,
                  color: AxcUnifiedColorTarget? = nil,
                  font: AxcUnifiedFontTarget? = nil,
                  backgroundColor: AxcUnifiedColorTarget? = nil) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let _color = color?.axc_color                     { attributes[.foregroundColor] = _color }
        if let _font = font?.axc_font                        { attributes[.font] = _font }
        if let _backgroundColor = backgroundColor?.axc_color { attributes[.backgroundColor] = _backgroundColor }
        return axc_mark(text, attributes: attributes)
    }
    /// 标记成富文本
    /// - Parameters:
    ///   - text: 标记文字
    ///   - attributes: 标记属性
    ///   - options: 类型
    /// - Returns: NSMutableAttributedString
    func axc_mark(_ text: String, attributes: [NSAttributedString.Key: Any] ) -> NSMutableAttributedString {
        let attStr = axc_attributedStr
        var searchRange = NSRange(location: 0, length: count)
        let nsStr = axc_nsString
        var range = nsStr.range(of: text, options: .caseInsensitive, range: searchRange)
        while range.location != NSNotFound {
            let max = NSMaxRange(range)
            searchRange = NSRange(location: max, length: count - max)
            attStr.addAttributes(attributes, range: range)
            range = nsStr.range(of: text, options: .caseInsensitive, range: searchRange)
        }
        return attStr
    }
    
    /// 计算文字的宽度
    func axc_width(_ maxHeight: CGFloat, font: UIFont) -> CGFloat {
        return axc_size(CGSize(width: Axc_floatMax, height: maxHeight), font: font).width
    }
    /// 计算文字的高度
    func axc_height(_ maxWidth: CGFloat, font: UIFont) -> CGFloat {
        return axc_size(CGSize(width: maxWidth, height: Axc_floatMax), font: font).height
    }
    /// 计算文字的大小
    func axc_size(_ size: CGSize, font: UIFont) -> CGSize {
        return axc_attributedStr.axc_setFont(font).axc_size(size)
    }
    
    // MARK: 编码转换
    /// 获取这个字符串UrlEncoded编码字符
    var axc_urlEncoded: String? {
        guard let encodedStr = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return encodedStr
    }
    
    /// 获取这个字符串UrlDecode编码字符
    var axc_urlDecoded: String? {
        guard let decodedStr = removingPercentEncoding else { return nil }
        return decodedStr
    }
    
    /// 获取这个汉字字符串的拼音
    var axc_pinYin: String? {
        guard self.count > 0 else { return nil }
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        return String(mutableString)
    }
    
    /// 获取这个字符串base64的编码字符串
    var axc_base64Str: String? {
        return axc_data?.axc_base64Str
    }
    
    /// 转换成Html格式的文本
    var axc_htmlStr: String {
        let headerString : String =
            """
        <header>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
        <style>img{max-width:100%}</style>
        </header>
        """
        return headerString + "<body id=\"content\">" + self + "</body>"
    }
    
    // MARK: 富文本
    /// 转换成可变富文本
    var axc_attributedStr: NSMutableAttributedString {
        return axc_attributedStr()
    }
    
    /// 转换成可变富文本（重载）
    ///   - color: 字色
    ///   - font: 字体
    ///   - isHtml: 是否是html文本
    /// - Returns: 可变富文本
    func axc_attributedStr(color: AxcUnifiedColorTarget? = nil,
                           font: AxcUnifiedFontTarget? = nil) -> NSMutableAttributedString {
        return axc_attributedStr(color: color?.axc_color, font: font?.axc_font, isHtml: false)
    }
    /// 转换成可变富文本
    ///   - color: 字色
    ///   - font: 字体
    ///   - isHtml: 是否是html文本
    /// - Returns: 可变富文本
    func axc_attributedStr(color: UIColor? = nil,
                           font: UIFont? = nil,
                           isHtml: Bool = false) -> NSMutableAttributedString {
        var attStr_M = NSMutableAttributedString()
        if isHtml { // 是html字符串
            guard let data = axc_data else { return attStr_M }
            attStr_M = data.axc_attributedHtmlStr.axc_mutableCopy()
        }else{
            attStr_M = NSMutableAttributedString(string: self)
            if let textColor = color { attStr_M.axc_setTextColor(textColor) }
            if let textFont = font   { attStr_M.axc_setFont(textFont) }
        }
        return attStr_M
    }
    
    /// 转换成一段设置属性的可变富文本
    /// - Parameters:
    ///   - key: NSAttributedString.Key
    ///   - value: Any
    /// - Returns: 可变富文本
    func axc_setAttributes(key: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: [key : value])
    }
    
}

// MARK: - 类方法/属性
public extension String {
    /// 实例化一个随机固定长度的字符串
    /// - Parameter length: 给定的长度
    init(axc_randomOf length: Int) {
        self = String.axc_random(length)
    }
    
    /// 根据长度生成一段随机的字符
    /// String.axc_random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    /// - Parameter length: 给定的长度
    static func axc_random(_ length: Int) -> String {
        guard length > 0 else { return "" }
        var randomString = ""
        for _ in 1...length { randomString.append(String(Character.axc_random())) }
        return randomString
    }
    
}

// MARK: - 属性 & Api
public extension String {
    /// 获取长度
    var axc_length: Int {
        return count
    }
    /// 转首字母大写字符串
    var axc_firstUppercased: String {
        return axc_uppercased(0)
    }
    /// 第几个字符转大写
    func axc_uppercased(_ idx: Int) -> String {
        var prefixStr = ""
        if idx > 0 { prefixStr = String(prefix(idx - 1)) }
        var suffixStr = ""
        if idx < count { suffixStr = String(suffix( count - (idx + 1))) }
        let upperStr = self[axc_safe: idx]?.axc_string ?? ""
        return prefixStr + upperStr + suffixStr
    }
    
    // MARK: 头部操作
    /// 获取第一个字符
    var axc_firstCharStr: String? {
        guard let first = first else { return nil }
        return String(first)
    }
    /// 获取第二个字符
    var axc_secondCharStr: String? {
        guard self.count >= 2,
              let second = self[axc_safe:1..<2]?.axc_string
        else { return nil }
        return second
    }
    
    /// 头部附加某段字符，如果本串自带，则不附加
    /// - Parameter prefix: 附加字符
    func axc_appendPrefix(_ prefix: String) -> String {
        guard !hasPrefix(prefix) else { return self }
        return prefix + self
    }
    
    /// 截取从开始到第几位字符
    func axc_startCut(_ start: Int) -> String? {
        return self[axc_safe:0 ..< start]
    }
    
    /// 去掉头部多少位字符
    /// - Parameter num: 位数
    func axc_removePrefix(_ num: Int) -> String? {
        guard num <= self.count else { return nil }
        return self[axc_safe:num ..< self.count]
    }
    
    /// 去掉头部某种符合的前缀
    /// - Parameter prefix: 需要去除的前缀
    func axc_removePrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return dropFirst(prefix.count).axc_string
    }
    /// 切割头部多少数量的字符
    /// "12345".axc_splitPrefix(count: 3) = 123
    func axc_keepPrefix(count: Int) -> String {
        guard self.count > count else { return self }
        return self.prefix(count).axc_string
    }
    
    // MARK: 尾部操作
    /// 获取最后一个字符
    var axc_lastCharStr: String? {
        guard let last = last else { return nil }
        return last.axc_string
    }
    
    /// 尾部附加某段字符，如果本串自带，则不附加
    /// - Parameter prefix: 附加字符
    func axc_appendSuffix(_ suffix: String) -> String {
        guard !hasSuffix(suffix) else { return self }
        return self + suffix
    }
    
    /// 截取从第几位字符到结束
    func axc_endCut(_ end: Int) -> String? {
        return self[axc_safe:end ..< self.count]
    }
    
    /// 去掉尾部多少位字符串
    /// - Parameter num: 位数
    func axc_removeSuffix(_ num: Int) -> String? {
        let count = self.count - num
        guard count >= 0 else { return nil }
        return self[axc_safe:0 ..< count]
    }
    
    /// 去掉尾部某种符合的后缀
    /// - Parameter suffix: 需要去除的后缀
    func axc_removeSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return dropLast(suffix.count).axc_string
    }
    /// 切割尾部多少数量的字符
    /// "12345".axc_splitSuffix(count: 3) = 345
    func axc_keepSuffix(count: Int) -> String {
        guard self.count > count else { return self }
        return self.suffix(count).axc_string
    }
    
    // MARK: 分隔操作
    /// 切割获取从某个开始到某个结束中间的字符
    /// - Parameters:
    ///   - start: 起始
    ///   - end: 结束
    /// - Returns: 结果
    func axc_split(start: String, end: String) -> [String]? {
        var result = [String]()
        let startArr = components(separatedBy: start)
        guard startArr.count > 1 else { return nil }
        for value in startArr[1...] { // 遍历检查
            let endArr = value.axc_split(separator: end)
            if endArr.count > 0, let firstStr = endArr.first {
                result.append(firstStr)
            }
        }
        return result
    }
    
    /// 使用传入的字符进行分隔字符串
    /// - Parameter separator: 传入字符如："-"
    func axc_split(separator: String) -> [String] {
        return components(separatedBy: separator).filter {
            !$0.axc_trimmed.isEmpty
        }
    }
    
    /// 使用传入的多字符进行分隔字符串
    /// - Parameter charStrs: 传入字符如："-,./\][09876"
    func axc_split(charStrs: String) -> [String] {
        return components(separatedBy: CharacterSet(charactersIn: charStrs)).filter {
            !$0.axc_trimmed.isEmpty
        }
    }
    
    /// 使用传入的CharacterSet进行分隔字符串
    /// - Parameter characters: 传入如："CharacterSet.alphanumerics"
    func axc_split(characters: CharacterSet) -> [String] {
        return components(separatedBy: characters).filter {
            !$0.axc_trimmed.isEmpty
        }
    }
    
    // MARK: 单词段落
    /// 获取这段字符串中单词数量
    var axc_wordsCount: Int {
        guard let regex = AxcRegularEnum.wordsCount.rawValue.axc_regular else { return 0 }
        return regex.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(),
                                     range: NSRange(location: 0, length: count))
    }
    
    /// 获取这段字符串中的单词集合
    var axc_words: [String] {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
    
    /// 获取这段字符串中段落数量
    var axc_paragraphCount: Int {
        guard let regex = AxcRegularEnum.paragraphCount.rawValue.axc_regular else { return 0 }
        let str = axc_trimmed
        return (regex.numberOfMatches(in: axc_trimmed, options: NSRegularExpression.MatchingOptions(),
                                      range: NSRange(location: 0, length: str.count))) + 1
    }
    
    // MARK: 过滤操作
    /// 去空修剪后的字符串
    var axc_trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 去除字符中的音调
    /// "Hèllö Wórld!".latinized -> "Hello World!"
    var axc_latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// 在正则表达式模式中包含的转义字符串
    /// "hello ^$ there" -> "hello \\^\\$ there"
    var axc_regexEscaped: String {
        return NSRegularExpression.escapedPattern(for: self)
    }
    
    /// 过滤去除空格和换行符
    /// "   \n AxcLogo   \n  Swift  ".withoutSpacesAndNewLines -> "AxcLogoSwift"
    var axc_filterSpacesEnter: String {
        return axc_replacing(" ", with: "").axc_replacing("\n", with: "")
    }
    
    /// 剔除非中文字符串
    var axc_filterNonChinses: String {
        return filter{ $0.axc_string.axc_isChinese }
    }
    
    /// 替换字符串
    /// - Parameters:
    ///   - str: 原字符串
    ///   - reStr: 替换字符串
    /// - Returns: 新字符串
    func axc_replacing(_ str: String, with reStr: String? = nil) -> String {
        let replacStr = reStr ?? ""
        return replacingOccurrences(of: str, with: replacStr)
    }
    
    /// 根据正则进行匹配获取所有符合规则的字符串
    /// - Parameter regular: 正则表达规则
    /// - Returns: 匹配字符串集合
    func axc_regularExtract(_ regular: String) -> [String] {
        var results: [String] = []
        guard let regex = try? NSRegularExpression(pattern: regular, options:[])
        else { return results }
        let matches: [NSTextCheckingResult] = regex.matches(in: self,
                                                            options: [],
                                                            range: NSRange(startIndex...,
                                                                           in: self))
        for (idx, match) in matches.enumerated() {
            let count = idx + 1
            if let subRange = Range(match.range(at: count), in: self) {
                let str = self[subRange]
                results.append(String(str))
            }
        }
        return results
    }
    
    // MARK: 统计操作
    /// 转换字符数组
    var axc_charsArray: [Character] {
        return Array(self)
    }
    
    /// 出现次数最多的字符
    var axc_mostCharStr: String? {
        let mostCommon = axc_filterSpacesEnter.reduce(into: [Character: Int]()) {
            let count = $0[$1] ?? 0
            $0[$1] = count + 1
        }.max { $0.1 < $1.1 }?.key
        guard let char = mostCommon else { return nil }
        return String(char)
    }
    
    /// 某个子字符串在本串中出现的次数
    /// - Parameters:
    ///   - string: 子串
    ///   - caseSensitive: 是否区分大小写
    func axc_count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive { return lowercased().components(separatedBy: string.lowercased()).count - 1 }
        return components(separatedBy: string).count - 1
    }
    
    /// 提取emoji表情数组
    var axc_emojis: [Character] {
        return filter{$0.axc_isEmoji}
    }
    
    /// 统计汉字出现的数量
    var axc_chineseCount: Int {
        var c_count = 0
        for c in self { if (String(c).axc_isChinese) { c_count += 1 } }
        return c_count
    }
    
    /// 匹配字符串出现的位置
    /// - Parameter matchStr: 匹配的字符串
    /// - Returns: 所有出现的Range
    func axc_matchStr(_ matchStr: String) -> [NSRange] {
        var selfStr = self as NSString
        var withStr = Array(repeating: "X", count: (matchStr as NSString).length).joined(separator: "") //辅助字符串
        if matchStr == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: matchStr).location != NSNotFound {
            let range = selfStr.range(of: matchStr)
            allRange.append(NSRange(location: range.location,length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }
    
    /// 匹配字符串出现的位置
    /// - Parameters:
    ///   - sub: 匹配的字符串
    ///   - backwards: 是否是最后出现的位置？默认false，如果设置为true则是首次出现的位置
    /// - Returns: 出现的下标
    func axc_matchStr(_ matchStr:String, backwards:Bool = false) -> Int? {
        var pos: Int?
        if let range = range(of:matchStr, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty { pos = self.distance(from:startIndex, to:range.lowerBound) }
        }
        return pos
    }
    
    // MARK: 其他操作
    /// 将这段字符串复制到剪贴板
    func axc_copyToPasteboard() { UIPasteboard.general.string = self }
}

// MARK: - Hash摘要函数
typealias AxcDigestAlgorithmClosure = (_ data: UnsafePointer<UInt8>, _ dataLength: UInt32) -> [UInt8]
// MARK: 摘要算法枚举
public enum AxcAlgorithm_Digest: CustomStringConvertible {
    /// 摘要枚举
    case md2, md4, md5, sha1, sha224, sha256, sha384, sha512
    /// 加密摘要方式
    func axc_progressClosure() -> AxcDigestAlgorithmClosure {
        var closure: AxcDigestAlgorithmClosure?
        switch self {
        case .md2:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_MD2($0, $1, &hash)
                return hash }
        case .md4:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_MD4($0, $1, &hash)
                return hash }
        case .md5:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_MD5($0, $1, &hash)
                return hash }
        case .sha1:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_SHA1($0, $1, &hash)
                return hash }
        case .sha224:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_SHA224($0, $1, &hash)
                return hash }
        case .sha256:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_SHA256($0, $1, &hash)
                return hash }
        case .sha384:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_SHA384($0, $1, &hash)
                return hash }
        case .sha512:
            closure = { var hash = [UInt8](repeating: 0, count: self.axc_digestLength)
                CC_SHA512($0, $1, &hash)
                return hash }
        }
        return closure!
    }
    /// 获取摘要长度
    var axc_digestLength: Int {
        var result: CInt = 0
        switch self {
        case .md2:      result = CC_MD2_DIGEST_LENGTH
        case .md4:      result = CC_MD4_DIGEST_LENGTH
        case .md5:      result = CC_MD5_DIGEST_LENGTH
        case .sha1:     result = CC_SHA1_DIGEST_LENGTH
        case .sha224:   result = CC_SHA224_DIGEST_LENGTH
        case .sha256:   result = CC_SHA256_DIGEST_LENGTH
        case .sha384:   result = CC_SHA384_DIGEST_LENGTH
        case .sha512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
    /// 摘要描述
    public var description: String {
        get { switch self {
        case .md2:      return "Digest.MD2"
        case .md4:      return "Digest.MD4"
        case .md5:      return "Digest.MD5"
        case .sha1:     return "Digest.SHA1"
        case .sha224:   return "Digest.SHA224"
        case .sha256:   return "Digest.SHA256"
        case .sha384:   return "Digest.SHA384"
        case .sha512:   return "Digest.SHA512"
        }
        }
    }
}

public extension String {
    // MARK: 摘要算法函数
    /// 获取摘要字符串
    func axc_hashDigestStr(_ algorithm:AxcAlgorithm_Digest)-> String? {
        guard let data = axc_data else { return nil }
        return data.axc_hashDigestStr(algorithm)
    }
    
    /// 获取摘要[UInt8]数组
    func axc_hashDigestBytes(_ algorithm:AxcAlgorithm_Digest)->[UInt8]? {
        guard let data = axc_data else { return nil }
        return data.axc_hashDigestBytes(algorithm)
    }
    
    /// 获取Data摘要
    func axc_hashDigestData(_ algorithm:AxcAlgorithm_Digest)->Data? {
        guard let data = axc_data else { return nil }
        return data.axc_hashDigestData(algorithm)
    }
    
    /// 获取摘要的Base64字符串
    func axc_hashDigestBase64(_ algorithm:AxcAlgorithm_Digest)->String? {
        guard let data = axc_data else { return nil }
        return data.axc_hashDigestBase64(algorithm)
    }
}

// MARK: - Hamc签名函数
// MARK: 签名算法枚举
public enum AxcAlgorithm_Hmac: CustomStringConvertible {
    case md5, sha1, sha224, sha256, sha384, sha512
    /// 算法枚举
    var axc_toCCEnum: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .md5:      result = kCCHmacAlgMD5
        case .sha1:     result = kCCHmacAlgSHA1
        case .sha224:   result = kCCHmacAlgSHA224
        case .sha256:   result = kCCHmacAlgSHA256
        case .sha384:   result = kCCHmacAlgSHA384
        case .sha512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    /// 长度
    var axc_digestLength: Int {
        var result: CInt = 0
        switch self {
        case .md5:      result = CC_MD5_DIGEST_LENGTH
        case .sha1:     result = CC_SHA1_DIGEST_LENGTH
        case .sha224:   result = CC_SHA224_DIGEST_LENGTH
        case .sha256:   result = CC_SHA256_DIGEST_LENGTH
        case .sha384:   result = CC_SHA384_DIGEST_LENGTH
        case .sha512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
    /// 描述
    public var description: String {
        get {
            switch self {
            case .md5:      return "HMAC.MD5"
            case .sha1:     return "HMAC.SHA1"
            case .sha224:   return "HMAC.SHA224"
            case .sha256:   return "HMAC.SHA256"
            case .sha384:   return "HMAC.SHA384"
            case .sha512:   return "HMAC.SHA512"
            }
        }
    }
}

public extension String {
    /// 获取签名字符串
    func axc_hamcSignStr(_ algorithm:AxcAlgorithm_Hmac, key:String)->String? {
        guard let data = axc_data else { return nil }
        return data.axc_hamcSignStr(algorithm, key: key)
    }
    
    /// 获取签名[UInt8]数组
    func axc_hamcSignBytes(_ algorithm:AxcAlgorithm_Hmac, key:String) -> [UInt8]? {
        guard let data = axc_data else { return nil }
        return data.axc_hamcSignBytes(algorithm, key: key)
    }
    
    /// 获取Data签名
    func axc_hamcSignData(_ algorithm:AxcAlgorithm_Hmac, key:String) -> Data? {
        guard let data = axc_data else { return nil }
        return data.axc_hamcSignData(algorithm, key: key)
    }
    
    /// 获取签名base64字符串
    func axc_hamcSignBase64(_ algorithm:AxcAlgorithm_Hmac, key:String) -> String? {
        guard let data = axc_data else { return nil }
        return data.axc_hamcSignBase64(algorithm, key: key)
    }
}

// MARK: - AES加密函数
// MARK: AES算法枚举
/// 算法模式，使用PKCS5填充
public enum AxcAlgorithm_Aes {
    case cbc(_ key: String, iv: String? = nil)
    case ecb(_ key: String)
}
public extension String {
    // MARK: AES加密
    /// hexStr十六进制字符串加密String字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 加密hexStr字符串
    func axc_aesEncryptHexStr(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        return axc_aesEncryptData(aAlgorithm)?.axc_hexStr
    }
    /// 字符串加密base64Str字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 加密base64Str字符串
    func axc_aesEncryptBase64Str(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        return axc_aesEncryptData(aAlgorithm)?.axc_base64Str
    }
    /// 字符串加密Data数据
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 加密Data数据
    func axc_aesEncryptData(_ aAlgorithm: AxcAlgorithm_Aes) -> Data? {
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return axc_data?.axc_aesCBCEncrypt(key, iv: iv)
        case .ecb(let key): return axc_data?.axc_aesEBCEncrypt(key)
        }
    }
    
    // MARK: AES解密
    /// hexStr十六进制字符串解密hexStr字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 解密hexStr字符串
    func axc_aesDecryptHexStr(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        let data = axc_hexData
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return data?.axc_aesCBCDecrypt(key, iv: iv)?.axc_string
        case .ecb(let key): return data?.axc_aesEBCDecrypt(key)?.axc_string
        }
    }
    /// 字符串解密base64Str字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 解密base64Str字符串
    func axc_aesDecryptBase64Str(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        let data = axc_base64Data
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return data?.axc_aesCBCDecrypt(key, iv: iv)?.axc_string
        case .ecb(let key): return data?.axc_aesEBCDecrypt(key)?.axc_string
        }
    }
    /// 字符串解密Data数据
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 解密Data数据
    func axc_aesDecryptData(_ aAlgorithm: AxcAlgorithm_Aes) -> Data? {
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return axc_data?.axc_aesCBCDecrypt(key, iv: iv)
        case .ecb(let key): return axc_data?.axc_aesEBCDecrypt(key)
        }
    }
}

// MARK: - 3DES加密函数
public extension String {
    // MARK: 3DES加密
    /// hexStr十六进制字符串加密String字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 加密hexStr字符串
    func axc_3desEncryptHexStr(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        return axc_3desEncryptData(aAlgorithm)?.axc_hexStr
    }
    /// 字符串加密base64Str字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 加密base64Str字符串
    func axc_3desEncryptBase64Str(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        return axc_3desEncryptData(aAlgorithm)?.axc_base64Str
    }
    /// 字符串加密Data数据
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 加密Data数据
    func axc_3desEncryptData(_ aAlgorithm: AxcAlgorithm_Aes) -> Data? {
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return axc_data?.axc_3desCBCEncrypt(key, iv: iv)
        case .ecb(let key): return axc_data?.axc_3desECBEncrypt(key)
        }
    }
    
    // MARK: 3DES解密
    /// hexStr十六进制字符串解密hexStr字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 解密hexStr字符串
    func axc_3desDecryptHexStr(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        let data = axc_hexData
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return data?.axc_3desCBCDecrypt(key, iv: iv)?.axc_string
        case .ecb(let key): return data?.axc_3desECBDecrypt(key)?.axc_string
        }
    }
    /// 字符串解密base64Str字符串
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 解密base64Str字符串
    func axc_3desDecryptBase64Str(_ aAlgorithm: AxcAlgorithm_Aes) -> String? {
        let data = axc_base64Data
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return data?.axc_3desCBCDecrypt(key, iv: iv)?.axc_string
        case .ecb(let key): return data?.axc_3desECBDecrypt(key)?.axc_string
        }
    }
    /// 字符串解密Data数据
    /// - Parameter aAlgorithm: 算法模式
    /// - Returns: 解密Data数据
    func axc_3desDecryptData(_ aAlgorithm: AxcAlgorithm_Aes) -> Data? {
        switch aAlgorithm {
        case .cbc(let key, iv: let iv): return axc_data?.axc_3desCBCDecrypt(key, iv: iv)
        case .ecb(let key): return axc_data?.axc_3desECBDecrypt(key)
        }
    }
}

// MARK: - 决策判断
/// 预设表达式枚举
enum AxcRegularEnum: String {
    /// Url正则
    case urlRegular         = "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
    /// 手机号正则
    case phoneRegular       = "^1\\d{10}$"
    /// 邮箱正则
    case emailRegular       = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    /// 身份证正则
    case idCardRegular      = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
    /// ip正则
    case ipAddressRegular   = "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
    /// 纯中文正则
    case chineseRegular     = "^[\\u4e00-\\u9fa5]+$"
    /// 纯英文正则
    case englishRegular     = "^[A-Za-z]+$"
    /// 纯数字
    case numberRegular      = "^[0-9]*$"
    /// 英文数字正则
    case englishNumRegular  = "^[A-Za-z0-9]+$"
    /// 是否为整数
    case integerNumRegular  = "^-?\\d+$"
    /// 这个字符串是否为有理数和小数
    case ratDecNumRegular   = "^(\\-|\\+)?\\d+(\\.\\d+)?$"
    /// 至少是x位的数字
    case minNumRegular      = "^\\d{%d}$"
    /// 单词数量
    case wordsCount         = "\\w+"
    /// 段落数量
    case paragraphCount     = "\\n"
}

public extension String {
    /// 是否为空
    /// 策略：字符串除去尖括号后长度大于4则为否（null长度为4）
    /// 如果小于等于4，则进行小写匹配，这4个字符里是否包含nil或者null字段，包含则为空
    var axc_isEmpty: Bool {
        let str = axc_trimmed.lowercased() - "<" - ">"
        if str.count > 4 { return false } // 长度优化
        if !str.hasPrefix("n") { return false } // 不以n开头
        return (str.axc_contains("null")) || (str.axc_contains("nil")) || isEmpty
    }
    /// 是否为合法格式Url
    var axc_isUrl: Bool { return axc_matchingRegular(AxcRegularEnum.urlRegular.rawValue) }
    
    /// 是否是一个有效Url
    var axc_isValidUrl: Bool { return axc_url != nil }
    
    /// 是否是一个有效的Schem URL
    var axc_isValidSchemedUrl: Bool { guard let url = axc_url else { return false }; return url.axc_isValidSchemedUrl }
    
    /// 是否是一个http的Url
    var axc_isHttpUrl: Bool { guard let url = axc_url else { return false }; return url.axc_isHttpUrl }
    
    /// 是否是一个https的Url
    var axc_isHttpsUrl: Bool { guard let url = axc_url else { return false }; return url.axc_isHttpsUrl }
    
    /// 是否是文件Url
    var axc_isFileUrl: Bool { guard let url = axc_url else { return false }; return url.axc_isFileUrl }
    
    /// 是否为合法手机号
    var axc_isPhone: Bool { return axc_matchingRegular(AxcRegularEnum.phoneRegular.rawValue) }
    
    /// 是否为合法邮箱
    var axc_isEmail: Bool { return axc_matchingRegular(AxcRegularEnum.emailRegular.rawValue) }
    
    /// 是否为合法身份证号
    var axc_isIdCard: Bool { return axc_matchingRegular(AxcRegularEnum.idCardRegular.rawValue) }
    
    /// 是否为合法ip
    var axc_isIpAddress: Bool { return axc_matchingRegular(AxcRegularEnum.ipAddressRegular.rawValue) }
    
    /// 是否为纯中文
    var axc_isChinese: Bool { return axc_matchingRegular(AxcRegularEnum.chineseRegular.rawValue) }
    
    /// 判断是否含有汉字
    var axc_isIncludeChinese: Bool {
        for (_,char) in enumerated() {
            if ("\u{4e00}" <= char && char <= "\u{9fa5}") { return true }
        }
        return false
    }
    /// 是否为纯英文
    var axc_isEnglish: Bool { return axc_matchingRegular(AxcRegularEnum.englishRegular.rawValue) }
    
    /// 是否为纯数字
    var axc_isNumber: Bool { return axc_matchingRegular(AxcRegularEnum.numberRegular.rawValue) }
    
    /// 是否为英文/数字
    var axc_isEnNum: Bool { return axc_matchingRegular(AxcRegularEnum.englishNumRegular.rawValue) }
    
    /// 是否为整数
    var axc_isIntegerNum: Bool { return axc_matchingRegular(AxcRegularEnum.integerNumRegular.rawValue) }
    
    /// 是否为正数、负数、和小数（有理数和小数）
    var axc_isRatDecNum: Bool { return axc_matchingRegular(AxcRegularEnum.ratDecNumRegular.rawValue) }
    
    /// 是否为至少为x位的数字
    /// - Parameter min: 至少min位的数字
    func axc_isMinNum(min: Int) -> Bool { return axc_matchingRegular(String(format: AxcRegularEnum.minNumRegular.rawValue, min)) }
    
    /// 判断路径的文件是否存在
    var axc_isFileExist: Bool { return Axc_fileManager.fileExists(atPath: self) }
    
    /// 检查字符串是否为空或仅由空格和换行符组成
    var axc_isBlank: Bool { return axc_trimmed.isEmpty }
    
    /// 检查字符串是否包含Emoji
    var axc_hasEmoji: Bool { return contains{$0.axc_isEmoji} }
    
    /// 判断是否包含另一个字符串
    /// - Parameters:
    ///   - subStr: 查找子串
    ///   - caseSensitive: 是否区分大小写，默认 true
    func axc_hasSubStr(_ subStr: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive { return range(of: subStr, options: .caseInsensitive) != nil }
        return range(of: subStr) != nil
    }
    
    /// 判断是否包含另一个字符串
    func axc_contains(_ subStr: String, caseSensitive: Bool = true) -> Bool {
        return axc_hasSubStr(subStr, caseSensitive: caseSensitive)
    }
    
    /// 是否包含字母
    var axc_hasLetters: Bool { return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil }
    
    /// 是否包含数字
    var axc_hasNumbers: Bool { return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil }
    
    /// 判断本字符串是否符合正则表达式
    /// - Parameter regular: 正则表达式
    func axc_matchingRegular(_ regular: String) -> Bool {
        guard !regular.isEmpty else { return false }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        return predicate.evaluate(with: self)
    }
    
    /// 是否是UICollectionView的头部Key
    var axc_isCollectionHeader: Bool {
        return self == UICollectionView.axc_elementKindSectionHeader
    }
    /// 是否是UICollectionView的尾部Key
    var axc_isCollectionFooter: Bool {
        return self == UICollectionView.axc_elementKindSectionFooter
    }
}

// MARK: - 操作符
public extension String {
    /// 字符串使用下标获取某个字符
    ///
    /// "Hello World!"[axc_safe: 3] -> "l"
    /// "Hello World!"[axc_safe: 20] -> nil
    ///
    subscript(axc_safe index: Int) -> String? {
        guard index >= 0, index < count else { return nil }
        return String(self[self.index(startIndex, offsetBy: index)])
    }
    
    /// 字符串使用下标获取某段字符
    ///
    /// "Hello World!"[axc_safe: 6..<11] -> "World"
    /// "Hello World!"[axc_safe: 21..<110] -> nil
    /// "Hello World!"[axc_safe: 6...11] -> "World!"
    /// "Hello World!"[axc_safe: 21...110] -> nil
    ///
    subscript<R>(axc_safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
              let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
              let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex)
        else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }
}

// MARK: - 运算符
public extension String {
    
    /// 字符串加字符
    /// - Parameters:
    ///   - leftValue: 字符串
    ///   - rightValue: 字符
    /// - Returns: 新字符串
    static func += (leftValue: inout String, rightValue: Character) {
        leftValue = leftValue + rightValue.axc_string
    }
    
    /// 左字符串是否包含右字符串
    ///
    ///  "123" |= "2" -> true
    ///
    static func |= (leftValue: String, rightValue: String) -> Bool {
        return leftValue.axc_hasSubStr(rightValue)
    }
    
    /// 这个字符串乘几次
    ///
    ///  "axc" * 3 -> "axcaxcaxc"
    ///
    static func * (leftValue: String, rightValue: Int) -> String {
        guard rightValue > 0 else { return "" }
        return String(repeating: leftValue, count: rightValue)
    }
    
    /// 乘几次这个字符串
    ///
    ///  3 * "axc" -> "axcaxcaxc"
    ///
    static func * (leftValue: Int, rightValue: String) -> String {
        guard leftValue > 0 else { return "" }
        return String(repeating: rightValue, count: leftValue)
    }
    
    /// 左侧字符串删除所有其中匹配的右侧字符串
    /// "1234321" - "3" -> "12421"
    /// - Parameters:
    ///   - lhs: 主串
    ///   - rhs: 字串
    static func - (leftValue: String, rightValue: String) -> String {
        return leftValue.axc_replacing(rightValue)
    }
}
