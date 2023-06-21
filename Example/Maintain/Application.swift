//
//  Application.swift
//  Renewal
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import AxcBedrock
import Foundation

// MARK: - Application + YPSharedTarget

extension Application: YPSharedTarget { }

// MARK: - [Application]

class Application: NSObject {
    /// 项目路径
    var projectPath: String?
    /// 内容输入文件路径
    var inputContentFilePath: String?
    
    
    var isAxcLogo: Bool = false
}

extension Application {
    func applicationDidRunFinish() {
        if !isAxcLogo {
            print("初始化'内容输入文件'")
            setInputContentFile()
            print("✅设置设置工程目录成功：\(projectPath!)")
            print("✅设置'内容输入文件'路径成功：\(inputContentFilePath!)")
        }else{
            projectPath = "/Users/zhaoyang/Desktop/YP组件"
            inputContentFilePath = "/Users/zhaoyang/Desktop/YP组件/AxcBedrock/Example/Maintain/InputContent.txt"
        }

        print("准备更新'YPUnifiedColor+UIKit'的转接系统Api")
        MaintainUnifiedColor.Renewal()
    }

    /// 设置内容输入文件
    func setInputContentFile() {
        let inputContentFilePathPrompt =
            """
            请输入'内容输入文件'的路径
            1、需要txt类型文件
            请输入
            """
        let filePath = console_input(prompt: inputContentFilePathPrompt)
        var isSuccess: Bool = true
        if !filePath.contains("txt") {
            print("⚠️文件类型必须是txt！")
            isSuccess = false
        }
        // 设置文件Url
        inputContentFilePath = filePath
            .yp.replacing("%EF%9C%81")
            .yp.replacing("%0A")
            .removingPercentEncoding?
            .yp.replacing("\n")
        inputContentFilePath = removeSpace(inputContentFilePath!)
        // 设置工程目录
        projectPath = inputContentFilePath?.yp.replacing("/AxcBedrock/Example/Renewal/InputContent.txt")
        if !isSuccess { // 递归
            setInputContentFile()
        }
    }

    /// 获取输入内容
    func getInputContent() -> String {
        let fileUrl = URL(fileURLWithPath: inputContentFilePath!)
        guard let fileData = try? Data(contentsOf: fileUrl),
              let fileString = fileData.yp.string_optional
        else { return "" }
        return fileString
    }
    
    func removeSpace(_ str: String) -> String {
        if str.hasPrefix(" ") {
            let newStr = str.yp.removePrefix(count: 1)
            return removeSpace(newStr!)
        }
        return str
    }
}
