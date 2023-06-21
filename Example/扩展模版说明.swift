
/**
  创建模板需要严格按照一下格式进行创建
  1、命名：YP+扩展的类+Ex

  2、内容模板复制以下:
  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  import UIKit

  extension <#class#>: YPSpaceProtocol {}

  // MARK: - 数据转换
  public extension YPSpace where Base: <#class#> {

  }

  // MARK: - 类方法
  public extension YPSpace where Base: <#class#> {

  }

  // MARK: - 属性 & Api
  public extension YPSpace where Base: <#class#> {

  }

  // MARK: - 决策判断
  public extension YPSpace where Base: <#class#> {

  }

 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

 3、根据功能性，在不同的分层中进行编写代码

 4、如果有功能代码较大，可考虑另起一个分层，放在【类方法】与【属性&api】之间

 6、编写完后需要用SwiftFormat进行代码格式化，格式化后进行编译检查功能完整性

 7、提交pull reuqest进行代码审核

 */

/**

 类方法的扩展必须首字母大写

 */
