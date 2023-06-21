//
//  AxcRuntime.swift
//  AxcBadrock
//
//  Created by 赵新 on 2021/3/19.
//

import Foundation

/// Runtime结构体
public typealias AxcRuntime = AxcBedrockLib.Runtime

// MARK: - [AxcBedrockLib.Runtime]

public extension AxcBedrockLib {
    /// Runtime结构体
    /// ⚠️苹果在将来会慢慢在swift中移除Objc的一些方法。使用swift实现iOS runtime要谨慎
    struct Runtime {
//        @available(*, deprecated, message: "请使用Set(object")
//        public static func SetObj(_ object: Any,
//                                  _ key: UnsafeRawPointer,
//                                  _ value: Any?,
//                                  _ policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
//            Set(object: object, key: key, value: value, policy: policy)
//        }

        /// 向某个对象绑定一个变量
        /// - Parameters:
        ///   - object: 对象
        ///   - key: 键
        ///   - value: 值
        ///   - policy: 类型
        public static func Set(object: Any,
                               key: UnsafeRawPointer,
                               value: Any?,
                               policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        {
            objc_setAssociatedObject(object, key, value, policy)
        }

//        @available(*, deprecated, message: "请使用GetObject")
//        public static func GetObj<T>(_ object: Any,
//                                     _ key: UnsafeRawPointer) -> T? {
//            return GetObject(object, key: key)
//        }

        /// 获取绑定的变量
        /// - Parameters:
        ///   - object: 对象
        ///   - key: 键
        /// - Returns: 值
        public static func GetObject<T>(_ object: Any,
                                        key: UnsafeRawPointer) -> T? {
            guard let obj = objc_getAssociatedObject(object, key) as? T else { return nil }
            return obj
        }

        /// 移除所有绑定的变量
        /// - Parameter object: 对象
        public static func Remove(object: Any) {
            objc_removeAssociatedObjects(object)
        }

        /// 遍历该项目里所有类
        /// - Parameter block: 回调
        public static func MapProjectClass(_ block: (AnyObject.Type) -> Void) {
            let typeCount = Int(objc_getClassList(nil, 0))
            let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
            let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
            objc_getClassList(autoreleasingTypes, Int32(typeCount))
            for index in 0 ..< typeCount { block(types[index]) } // 遍历所有类
            types.deallocate() // 销毁
        }

        /// 遍历获取属性名
        /// - Parameter _class: 类
        /// - Returns: 集合
        public static func GetAllParamName(_ _class: AnyClass) -> [[String: String]] {
            var list: [[String: String]] = []
            var count: UInt32 = 0 // 记录属性的个数
            // 获取所有属性、个数
            guard let ivarList = class_copyIvarList(_class, &count) else { return list }
            for index in 0 ..< count { // 遍历属性获取属性名
                var propertyName = ""
                if let propertyNameC = ivar_getName(ivarList[Int(index)]) { // 获取属性名的C（C语言的字符串） 如果有
                    propertyName = String(cString: propertyNameC) // 将C语言字符串转成Swift语言的字符串
                }
                var prorpertyType = ""
                if let propertyTypeC = ivar_getTypeEncoding(ivarList[Int(index)]) { // 获取属性名的C（C语言的字符串） 如果有
                    prorpertyType = String(cString: propertyTypeC) // 将C语言字符串转成Swift语言的字符串
                }
                list.append(["name": propertyName, "type": prorpertyType])
            }
            return list
        }

        /// 遍历获取方法名
        /// - Parameter _class: 类
        /// - Returns: 集合
        public static func GetAllFuncName(_ _class: AnyClass) -> [String] {
            var list: [String] = []
            var count: UInt32 = 0 // 记录方法的个数
            // 获取所有的方法名
            guard let methods = class_copyMethodList(_class, &count) else { return list }
            for index in 0 ..< count { // 遍历数组获取每一个方法名
                let sel = method_getName(methods[Int(index)]) // 获取方法
                let methodNameC = sel_getName(sel) // 获取方法名称（C语言下的）
                list.append(String(cString: methodNameC))
            }
            return list
        }

        /// 方法交换
        /// - Parameters:
        ///   - _class: 类
        ///   - originalSelector: 愿方法
        ///   - swizzledSelector: 交换的方法
        public static func MethodSwizzle(_ _class: AnyClass,
                                         originalSelector: Selector,
                                         swizzledSelector: Selector) {
            guard let originalMethod = class_getInstanceMethod(_class, originalSelector) else { return }
            guard let swizzledMethod = class_getInstanceMethod(_class, swizzledSelector) else { return }
            let didAddMethod = class_addMethod(_class, originalSelector,
                                               method_getImplementation(swizzledMethod),
                                               method_getTypeEncoding(swizzledMethod))
            if didAddMethod { // 添加成功
                class_replaceMethod(_class, swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod))
            } else { // 添加失败 交换
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }

        /// 跨类方法交换
        /// - Parameters:
        ///   - originaClass: 原类
        ///   - originalSelector: 原方法
        ///   - swizzledClass: 新类
        ///   - swizzledSelector: 新方法
        public static func MethodSwizzle(originaClass: AnyClass,
                                         originalSelector: Selector,
                                         swizzledClass: AnyClass,
                                         swizzledSelector: Selector) {
            guard let originalMethod = class_getInstanceMethod(originaClass, originalSelector) else { return }
            guard let swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector) else { return }
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }

        /// 跨类方法交换
        /// - Parameters:
        ///   - originaClass: 原类
        ///   - originalSelector: 原方法
        ///   - swizzledClass: 新类
        ///   - swizzledSelector: 新方法
        public static func MethodClassSwizzle(originaClass: AnyClass,
                                              originalSelector: Selector,
                                              swizzledClass: AnyClass,
                                              swizzledSelector: Selector) {
            guard let originalMethod = class_getClassMethod(originaClass, originalSelector) else { return }
            guard let swizzledMethod = class_getClassMethod(swizzledClass, swizzledSelector) else { return }
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
