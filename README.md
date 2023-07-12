# AxcBedrock
![language](https://img.shields.io/badge/Language-swift-8E44AD.svg)
![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
![MIT License](https://img.shields.io/github/license/mashape/apistatus.svg)
![Platform](https://img.shields.io/badge/platform-%20iOS%20-lightgrey.svg)
![CocoaPods](https://img.shields.io/badge/CocoaPods-1.12.1-brightgreen.svg)
[![Version](https://img.shields.io/cocoapods/v/AxcBedrock.svg?style=flat)](https://cocoapods.org/pods/AxcBedrock)
[![Platform](https://img.shields.io/cocoapods/p/AxcBedrock.svg?style=flat)](https://cocoapods.org/pods/AxcBedrock)
![Axc](https://img.shields.io/badge/Axc-Kit-orange.svg)

![bedrock](./readme_source/bedrock.png)<br>
AxcBedrock是一个Swift工具库，为iOS和macOS应用程序提供常用的函数和扩展。
所有API使用都遵循xxxx(实例).axc.xxxxApi这种格式，可轻松访问您需要的所有函数和扩展。

# 介绍
提供常用的Swift函数和扩展
所有API均遵循xxxx类实例.axc.xxxxApi格式，易于访问
支持iOS和macOS应用程序
# 安装
您可以使用CocoaPods快速安装AxcBedrock:
Podfile:
```ruby
pod 'AxcBedrock'
```
您也可以手动将源代码添加到项目中。

# 用法
使用AxcBedrock中的函数和扩展非常简单。只需将AxcBedrock导入到您的项目中，即可开始使用。

以下是一个简单的示例，演示如何使用AxcBedrock中的功能：

import AxcBedrock

let myString = "hello world"
let testString = myString.axc.keepPrefix(count: 3)
print(testString) // "hel"
有关AxcBedrock中可用函数和扩展的完整列表，请参见文档。

# 问题
如果您在使用AxcBedrock时遇到问题或错误，请在GitHub上提交问题。

# 作者
axclogo@163.com

# 贡献
AxcBedrock是开源的，并感谢任何形式的贡献。如果您发现错误或想改进库，请提交拉取请求。

# 证书

AxcBedrock is available under the MIT license. See the LICENSE file for more info.
