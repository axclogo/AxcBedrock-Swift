# AxcBedrock
![language](https://img.shields.io/badge/Language-swift-8E44AD.svg)
![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
![MIT License](https://img.shields.io/github/license/mashape/apistatus.svg)
[![Platform](https://img.shields.io/cocoapods/p/AxcBedrock.svg?style=flat)](https://cocoapods.org/pods/AxcBedrock)
![CocoaPods](https://img.shields.io/badge/CocoaPods-1.12.1-brightgreen.svg)
![Axc](https://img.shields.io/badge/Axc-Kit-orange.svg)

# 介绍
![bedrock](./readme_source/bedrock.png)<br>
AxcBedrock是一个Swift工具库，为iOS和macOS应用程序提基础供常用的函数和扩展。

如同MineCraft中的基岩一样，作为世界基础，承担起所有方块.

# 安装
您可以使用CocoaPods快速安装AxcBedrock:
Podfile:
```ruby
pod 'AxcBedrock'
```
您也可以手动将源代码添加到项目中。

# 用法
使用AxcBedrock中的函数和扩展非常简单。只需将AxcBedrock导入到您的项目中，即可开始使用。

## 格式/规范
所有API使用都遵循这种格式的命名规范：
```swift
// 实例功能调用：
xxxx.axc.xxxx
// 类功能调用
Xxxx.Axc.Xxxx
```
以此可轻松访问您需要的所有函数和扩展。

## 部分示例
### 调用示例
以下是一个简单的示例，演示如何使用AxcBedrock中的功能：

```swift
import AxcBedrock

let myString = "hello world"
let testString = myString.axc.keepPrefix(count: 3)
print(testString) // "hel"
```

### 富文本操作示例
```swift
let attText = "这是一段富文本".axc.makeAttributed { make in
    make.set(font: 15, range: 0...1)
        .set(foregroundColor: "FFBBAA", range: NSRange(location: 0, length: 4))
}
```
| iOS表现 | MacOS表现 |
| ---------------- | ---------------- |
| ![bedrock](./readme_source/attributedText_iOS_example.png)<br>  | ![bedrock](./readme_source/attributedText_MacOS_example.png)<br>  |
需要注意的是，AxcUnifiedXXX的类为通用类，例如上面示例的设置Font和Color的类分别为：
AxcUnifiedFont和AxcUnifiedColor
这样的类可以兼容并采取以下写法：

**AxcUnifiedFont:**
```swift
make.set(font: 15.axc.uiFont, range: 0...1)
make.set(font: 15.4, range: NSRange(location: 0, length: 4))

make.set(font: UIFont.systemFont(ofSize: 15), range: 0...1)
make.set(font: UIFont.systemFont(ofSize: 15), range: NSRange(location: 0, length: 4))
```

**AxcUnifiedColor:**
```swift
.set(foregroundColor: "FFBBAA", range: 1...2)
.set(foregroundColor: "FFBBAA", range: NSRange(location: 0, length: 4))

.set(foregroundColor: UIColor.red, range: 1...2)
.set(foregroundColor: UIColor.red, range: NSRange(location: 0, length: 4))

.set(foregroundColor: 0xFFBBAA, range: 1...2)
.set(foregroundColor: 0xFFBBAA, range: NSRange(location: 0, length: 4))
```
当然，无论UIColor还是NSColor都可以支持，但是要在对应的平台上使用

有关AxcBedrock中可用函数和扩展的完整列表，请参见文档。

# 问题
如果您在使用AxcBedrock时遇到问题或错误，请在GitHub上提交问题。
如果您在使用过程中，不知道或不明白有哪些Api，也可以在GitHub上提交问题。

# 作者
axclogo@163.com

# 贡献
AxcBedrock是开源的，并感谢任何形式的贡献。如果您发现错误或想改进库，请提交拉取请求。
目前急需协助帮忙完善单元测试部分~如果有想法的请联系我！谢谢！

# 证书
AxcBedrock is available under the MIT license. See the LICENSE file for more info.

# 如果这个库有帮助到你，或者启发了你什么灵感，请给个Star ~ ~ Thanks♪(･ω･)ﾉ
