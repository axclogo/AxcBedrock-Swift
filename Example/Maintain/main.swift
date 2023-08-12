//
//  main.swift
//  Renewal
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AxcBedrock

print(AxcLogoBanner.larry3D.banner)
print("\n\n👇🏻👇🏻👇🏻<++更新程序开始运行++>👇🏻👇🏻👇🏻")

//Application.Shared.applicationDidRunFinish()


//let resu = YPCalculator.LargeNumber("532432339532432339", add: "652801199412031633")

//YPCalculator.LargeNumbe

//print(resu)



print("\n\n🎉🎉🎉-->更新程序运行完成<--🎉🎉🎉")

/// 文件管理
let fileManager: FileManager = .default

/// 判断文件是否存在
func fileExistsAtPath(_ filePath: String) -> Bool {
    return fileManager.fileExists(atPath: filePath)
}


// MARK: - 控制台函数

func console_inputBool(prompt: String) -> Bool {
    let output = console_input(prompt: prompt)
    return output.contains("y")
}

func console_input(prompt: String) -> String {
    print("👉🏻\(prompt)：")
    let stdin = FileHandle.standardInput
    let inputContent = stdin.availableData.axc.string
    return inputContent
}
