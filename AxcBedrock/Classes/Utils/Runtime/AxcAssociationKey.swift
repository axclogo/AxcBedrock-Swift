import Foundation

// MARK: - 类型安全的关联对象键

/// 以实例身份区分的关联对象键，值类型在创建时确定。
/// 建议使用 static let 保存；不同键实例即使值类型相同也互不冲突。
/// 关联值会持有键，避免键提前释放后地址被复用；移除关联或宿主释放时一并释放。
public final class AxcAssociationKey<Value> {
    fileprivate let makeReader: (Value) -> () -> Value?

    /// 创建强持有值的键。值类型按值保存，引用类型按引用保存，不执行复制。
    public init() {
        makeReader = { value in { value } }
    }

    private init(makeReader: @escaping (Value) -> () -> Value?) {
        self.makeReader = makeReader
    }

    /// 创建弱持有对象的键；对象释放后读取返回 nil，不使用不安全的 assign 策略。
    public static func Weak() -> AxcAssociationKey<Value> where Value: AnyObject {
        return AxcAssociationKey<Value>(makeReader: { value in
            let weakValue = AxcWeakObj(value)
            return { weakValue.object }
        })
    }

    fileprivate var pointer: UnsafeRawPointer {
        return UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
    }
}

// MARK: - Runtime 类型化接口

public extension AxcRuntime {
    /// 写入类型化关联值；传入 nil 仅移除此键。宿主必须是支持关联对象的 NSObject 实例。
    /// 单次读写使用 Runtime 的原子持有策略；读后修改再写回并非原子操作，值内部状态需自行同步。
    /// 强引用值若反向持有宿主仍可能形成循环引用；需要弱引用时使用 Weak() 键。
    static func Set<Value>(object: NSObject, key: AxcAssociationKey<Value>, value: Value?) {
        let storage = value.map { _AxcAssociationValue(key: key, read: key.makeReader($0)) }
        Set(object: object, key: key.pointer, value: storage, policy: .OBJC_ASSOCIATION_RETAIN)
    }

    /// 读取此键对应的值；未设置、已移除或弱引用对象已释放时返回 nil。
    static func GetObject<Value>(_ object: NSObject, key: AxcAssociationKey<Value>) -> Value? {
        let storage: _AxcAssociationValue<Value>? = GetObject(object, key: key.pointer)
        return storage?.read()
    }

    /// 仅移除此键对应的关联值，不影响宿主上的其他关联对象。
    static func Remove<Value>(object: NSObject, key: AxcAssociationKey<Value>) {
        Set(object: object, key: key.pointer, value: nil, policy: .OBJC_ASSOCIATION_RETAIN)
    }
}

private final class _AxcAssociationValue<Value> {
    let key: AxcAssociationKey<Value>
    let read: () -> Value?

    init(key: AxcAssociationKey<Value>, read: @escaping () -> Value?) {
        self.key = key
        self.read = read
    }
}
