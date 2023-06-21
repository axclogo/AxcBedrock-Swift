//
//  MaintainUnifiedColor.swift
//  Renewal
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import AxcBedrock
import Foundation

// MARK: - [MaintainUnifiedColor.ColorAttribute]

extension MaintainUnifiedColor {
    struct ColorAttribute {
        var name: String
        var remark: String?
        var available: String?
    }
}

// MARK: - [MaintainUnifiedColor]

class MaintainUnifiedColor: NSObject {
    static func Renewal() {
        let prompt = """
            请输入UIColor框架文件中的头文件全部代码
            1、点进UIColor.h 与 UIInterface.h 文件中（Swift或OC都可以）
            2、【command + a】全部选中
            3、在'内容输入文件'中进行粘贴
            是否完成[y/n]
            """
        let output = console_inputBool(prompt: prompt)
        if output {
            let inputContentStr = Application.Shared.getInputContent()
            if inputContentStr.isEmpty {
                print("⚠️未检测到代码！")
                Renewal()
            } else {
                // 判断文件是OC还是Swift
                if inputContentStr.contains("#import") {
                    RenewalUnifiedColor_oc(inputContentStr)
                } else {
                    RenewalUnifiedColor_swift(inputContentStr)
                }
            }
        } else {
            Renewal()
        }
    }

    /// 开始更新代码
    static func RenewalUnifiedColor_swift(_ codeStr: String) {
        let pattern = "(@available(.*)\\n(\\s*))?open class var(.*): UIColor(.*)"
        var result: [ColorAttribute] = []
        let codeList = matches(string: codeStr, pattern: pattern)
        for string in codeList {
            // 获取名称
            guard var name = matches(string: string, pattern: "var(.*):").first else { return }
            name = name.yp.replacing(strings: ["var", " ", ":"])
            var colorAttribute = ColorAttribute(name: name)
            // 获取版本
            let availablePattern = "@available(.*)"
            if string.yp.isConform(pattern: availablePattern) {
                if var availableStr = matches(string: string, pattern: availablePattern).first,
                   var versionStr = matches(string: availableStr, pattern: "iOS (.*),").first {
                    versionStr = versionStr.yp.replacing(strings: ["iOS", ",", " "])
                    if let versionFloat = versionStr.yp.float_optional,
                       versionFloat > 10 {
                        colorAttribute.available = availableStr
                    }
                }
            }
            // 获取备注
            if string.contains("//") {
                if var remarkStr = string.components(separatedBy: "//").last {
                    colorAttribute.remark = "///\(remarkStr)"
                }
            }
            result.append(colorAttribute)
        }
        createCodeToFile(list: result)
    }

    /// 开始更新代码
    static func RenewalUnifiedColor_oc(_ codeStr: String) {
        let pattern = "@property(.*)\\(class, nonatomic, readonly\\) UIColor(.*);"
        var result: [String] = []
        for match in matches(string: codeStr, pattern: pattern) {
            result.append(match)
        }
        print(result)
    }

    static func matches(string: String,
                        pattern: String) -> [String] {
        guard let regex = try? YPRegex(pattern) else { return [] }
        var result: [String] = []
        for match in regex.matches(in: string) {
            result.append(match.string)
        }
        return result
    }

    static func createCodeToFile(list: [ColorAttribute]) {
        var codeString = ""
        for model in list {
            if let remarkStr = model.remark {
                codeString.append("\(remarkStr)\n")
            }
            if let availableStr = model.available {
                codeString.append("\(availableStr)\n")
            }
            codeString.append("static var \(model.name): UIColor { return .\(model.name) }\n\n")
        }
        print(codeString)
    }
}
