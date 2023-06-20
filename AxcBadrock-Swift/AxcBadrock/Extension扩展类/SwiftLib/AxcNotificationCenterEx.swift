//
//  AxcNotificationCenterEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/4/12.
//

import UIKit

// MARK: - 数据转换
public extension NotificationCenter {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 类方法/属性
public extension NotificationCenter {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 属性 & Api
// MARK: - 通知转Block
private var kkeyNames = "kkeyNames"
public extension NotificationCenter {
    typealias AxcNotificationBlock = (Notification) -> Void
    typealias KeyPathsType = [[String: AxcNotificationBlock]]
    /// 存储键值对组
    private var keyNames: KeyPathsType {
        set { AxcRuntime.setObj(self, &kkeyNames, newValue) }
        get {
            guard let names: KeyPathsType  = AxcRuntime.getObj(self, &kkeyNames)
            else {
                let names: KeyPathsType = [[:]]
                self.keyNames = names
                return names
            }
            return names
        }
    }
    
    /// 添加普通通知
    /// - Parameters:
    ///   - name: 字符串通知名
    ///   - selector: 执行
    func axc_addNotification(_ name: String, selector: Selector) {
        axc_addNotification(name.axc_notificationName, selector: selector)
    }
    /// 添加普通通知
    /// - Parameters:
    ///   - name: 通知名
    ///   - selector: 执行
    func axc_addNotification(_ name: NSNotification.Name, selector: Selector) {
        addObserver(self, selector: selector, name: name, object: nil)
    }
    
    /// 添加Block回调通知
    /// - Parameters:
    ///   - name: 名称键值
    ///   - firstTrigger: 首次执行
    ///   - actionBlock: 回调Block
    /// - Returns: 通知中心，需要设置生命周期
    func axc_addNotification(_ name: NSNotification.Name,
                             firstTrigger: Bool = false,
                             actionBlock: @escaping AxcNotificationBlock) -> Self {
        axc_addNotification(name.rawValue, firstTrigger: firstTrigger, actionBlock: actionBlock)
    }
    /// 添加Block回调通知
    /// - Parameters:
    ///   - name: 名称键值
    ///   - firstTrigger: 首次执行
    ///   - actionBlock: 回调Block
    /// - Returns: 通知中心，需要设置生命周期
    func axc_addNotification(_ name: String,
                             firstTrigger: Bool = false,
                             actionBlock: @escaping AxcNotificationBlock) -> Self {
        keyNames.append([name: actionBlock])
        addObserver(self, selector: #selector(notificationResponse(notification:)),
                    name: name.axc_notificationName, object: nil)
        if firstTrigger { // 首次执行
            let notification = Notification(name: name.axc_notificationName,
                                            object: nil,
                                            userInfo: nil)
            notificationResponse(notification: notification)
        }
        return self
    }
    
    /// 移除一个键值通知
    /// - Parameter keyPath: 字符串键值
    func axc_removeNotification(_ name: String, obj: Any? = nil){
        axc_removeNotification(name.axc_notificationName, obj: obj)
    }
    /// 移除一个键值通知
    /// - Parameter keyPath: 键值
    func axc_removeNotification(_ name: Notification.Name, obj: Any? = nil){
        removeObserver(self, name: name, object: obj)
        AxcLog("Notification释放！\nObserver:\(self)\nKeyPath:\(name)", level: .trace)
    }
    /// 移除所有键值通知
    func axc_removeAllNotification() {
        keyNames.forEach{   // 遍历所有监听
            $0.forEach { (dic) in   // 挑出键值进行移除
                axc_removeNotification(dic.key)
            }
        }
    }
    
    /// 发出一个通知
    /// - Parameters:
    ///   - name: 名称
    ///   - obj: 对象
    ///   - userInfo: 参数
    func axc_postNotification(_ name: String,
                              obj: Any? = nil,
                              userInfo: [AnyHashable : Any]? = nil) {
        axc_postNotification(name.axc_notificationName, obj: obj, userInfo: userInfo)
    }
    /// 发出一个通知
    /// - Parameters:
    ///   - name: 名称
    ///   - obj: 对象
    ///   - userInfo: 参数
    func axc_postNotification(_ name: Notification.Name,
                              obj: Any? = nil,
                              userInfo: [AnyHashable : Any]? = nil) {
        axc_notificationCenter.post(name: name, object: obj, userInfo: userInfo)
    }
    
    /// 设置生命周期
    /// - Parameter cycle: 生命周期AxcObserveCycle
    func axc_setCycle(_ cycle: AxcNotificationCycle) {
        cycle.notificationCenter = self
    }
    
    /// 找出所有包含这个键值的通知Block
    func axc_containsKey(_ keyPath: String) -> KeyPathsType {
        var keysArr: KeyPathsType = []
        keyNames.forEach{
            if $0.axc_isHasKey(keyPath){ keysArr.append($0) }
        }
        return keysArr
    }
    
    @objc func notificationResponse(notification: Notification) {
        let name = notification.name.rawValue
        let keysArr = axc_containsKey(name)
        keysArr.forEach{    // 遍历所有监听
            if $0.axc_isHasKey(name), let block = $0[name] {
                block(notification) // 回调指针指向的Block函数块
            }
        }
    }
}

/// 通知中心周期管理
open class AxcNotificationCycle {
    public var notificationCenter: NotificationCenter? = nil
    deinit { // 移除所有通知
        if let center = notificationCenter { // 高频决策优化
            center.axc_removeAllNotification()
        }
    }
}

// MARK: - 决策判断
public extension NotificationCenter {
// MARK: 协议
// MARK: 扩展
}

// MARK: - 操作符
public extension NotificationCenter {
}

// MARK: - 运算符
public extension NotificationCenter {
}
