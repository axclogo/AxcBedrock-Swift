# AxcBedrock 优化清单（目标：95+ 分）

> 评分标准：主流开源 Swift 库最严格标准（参考 Alamofire、SnapKit、RxSwift 等顶级库）
> 当前评分：7.5 / 10
> 每项标注 [权重] 表示对最终评分的影响程度

---

## ⚠️ 开发约束（所有开发者必读）

### 项目背景
- 这是一个 Swift 跨平台（iOS/macOS）基础工具库
- 项目**未上线**，无需考虑向后兼容，deprecated API 直接删除
- 社区有用户通过 CocoaPods 使用，最低版本保持 **iOS 10.0 / macOS 11.0**
- 当前仅支持 CocoaPods，需新增 SPM 支持（双轨并行）

### 核心架构（不可破坏）
1. **命名空间模式**：所有扩展通过 `.axc`（实例）和 `.Axc`（类方法）访问，不直接扩展系统类型
2. **AxcSpace<Base>** 是命名空间载体，是 `open class`（非 struct），这是有意为之的设计（Swift 值类型写时复制导致无法做引用操作）
3. **Unified 类型协议**（AxcUnifiedNumber、AxcUnifiedColor 等）允许 API 接受多种输入类型
4. **AxcBedrockLib** 是库的根命名空间，所有工具类型嵌套在其中（如 `AxcBedrockLib.Runtime`、`AxcBedrockLib.Enum`）

### 编码风格（必须遵循）
```swift
// 文件结构 MARK 分段（每个文件必须遵循）：
// MARK: - 数据转换
// MARK: - 类方法
// MARK: - 属性 & Api
// MARK: - 决策判断

// 命名规范：
// - 类/协议/枚举：PascalCase + Axc 前缀（AxcDirection、AxcSpaceProtocol）
// - 扩展文件名：Axc{TypeName}Ex.swift（AxcStringEx.swift、AxcCGPointEx.swift）
// - 工厂方法：Create(xxx:) 返回非可选，CreateOptional(xxx:) 返回可选
// - 属性命名：camelCase，布尔属性用 is/has/can 前缀

// API 设计原则：
// - 所有操作返回新值（不修改原值），因为 AxcSpace 对值类型的 base 是拷贝
// - 越界/非法输入：Log 警告 + 返回安全默认值，绝不 fatalError（除非 #if DEBUG）
// - public API 必须有文档注释（/// 格式）
// - 参数尽量使用 Unified 类型（AxcUnifiedNumber 等）保持灵活性
```

### 禁止事项
- ❌ 不要引入任何第三方依赖（库必须零外部依赖）
- ❌ 不要使用 `as!` 强制转换（用 `as?` + fallback）
- ❌ 不要在非 DEBUG 环境使用 `fatalError` / `FatalLog`
- ❌ 不要破坏 `.axc` / `.Axc` 命名空间模式
- ❌ 不要提升最低部署版本（保持 iOS 10.0 / macOS 11.0）
- ❌ 不要在 Extension 层直接 `import UIKit` 或 `import AppKit`（跨平台文件用 `#if canImport`）
- ❌ 不要创建新的全局函数或全局变量
- ❌ 不要修改 `AxcSpaceProtocol` 和 `AxcSpace` 的核心接口签名

### 允许事项
- ✅ 删除所有 `@available(*, deprecated, ...)` 标记的 API
- ✅ 重命名文件修正拼写错误（如 Warapper → Wrapper）
- ✅ 修改内部实现细节（不影响 public API 签名的前提下）
- ✅ 添加新的 Unified 类型或扩展
- ✅ 使用 `@available(iOS 13.0, *)` 提供高版本专属 API
- ✅ 重构内部类型分发逻辑（消除重复代码）

### 验证标准
每次修改后必须确保：
1. iOS 10.0 模拟器编译通过（零 error，零 warning 为目标）
2. macOS 11.0 编译通过
3. 所有 public API 的命名空间模式不变（`xxx.axc.xxx` / `Xxx.Axc.Xxx`）
4. 新增代码有对应的单元测试
5. 无新增的 `as!` 强制转换

---

## 一、工程化与基础设施 [权重：20分]

### 1.1 Swift Package Manager 支持 [+5分]
- [ ] 添加 `Package.swift`，定义产品和目标
- [ ] 按平台拆分 target（Core、iOS、macOS）
- [ ] 确保 SPM 和 CocoaPods 双轨并行可用（共用同一份源码）
- [ ] 目录名 `AppKit&UIKit` 含特殊字符，需重命名为 `AppKitAndUIKit`（SPM 路径兼容）
- [ ] 在 README 中补充 SPM 安装说明
- [ ] 平台最低版本保持 iOS 10.0 / macOS 11.0

### 1.2 CI/CD 流水线 [+5分]
- [ ] 当前 `.github/workflows/swift.yml` 只是空壳（echo 'test'），需要重写
- [ ] 添加矩阵构建：iOS 模拟器 + macOS，多 Xcode 版本
- [ ] 集成单元测试自动运行
- [ ] 集成代码覆盖率报告（Codecov 或类似服务）
- [ ] 添加 SwiftLint 检查步骤
- [ ] PR 触发构建，main 分支保护

### 1.3 代码规范工具 [+3分]
- [ ] 添加 `.swiftlint.yml` 配置文件，定义项目规则
- [ ] 添加 `.swiftformat` 配置文件，统一代码格式
- [ ] 在 CI 中强制执行 lint 检查

### 1.4 版本管理 [+2分]
- [ ] 添加 `CHANGELOG.md`，记录每个版本的变更
- [ ] 使用语义化版本（SemVer）严格管理 breaking changes
- [ ] podspec 中版本号与 git tag 自动同步脚本优化

### 1.5 文档生成 [+5分]
- [ ] 配置 Swift-DocC 或 Jazzy 自动生成 API 文档
- [ ] 所有 public API 必须有英文文档注释（当前大量中文注释，国际化不足）
- [ ] 在 CI 中自动部署文档到 GitHub Pages
- [ ] 为核心模式（命名空间、Unified 类型）编写 Architecture Guide

---

## 二、测试覆盖 [权重：20分]

### 2.1 单元测试 [+15分]
- [ ] 当前测试文件全部为空壳模板，零有效测试
- [ ] Core 模块：AxcSpace 命名空间协议测试
- [ ] Unified 类型转换测试：AxcUnifiedNumber 所有类型互转的边界值
- [ ] Unified 类型转换测试：AxcUnifiedColor 十六进制/字符串/原生颜色互转
- [ ] SwiftLib 扩展测试：String、Array、Dictionary、Int、Double 等
- [ ] Foundation 扩展测试：Date、URL、NSAttributedString 等
- [ ] CoreGraphics 扩展测试：CGPoint、CGRect、CGSize、CGPath 等
- [ ] 跨平台一致性测试：同一 API 在 iOS/macOS 上行为一致
- [ ] 边界条件测试：空值、极大值、极小值、非法输入
- [ ] 目标覆盖率：核心模块 > 90%，扩展模块 > 70%

### 2.2 性能测试 [+3分]
- [ ] 为高频调用的 API 添加 `measure {}` 性能基准
- [ ] 特别关注：类型转换、字符串操作、集合操作的性能
- [ ] 建立性能回归基线，CI 中检测性能退化

### 2.3 测试架构 [+2分]
- [ ] 测试文件结构应镜像源码结构
- [ ] 抽取测试辅助工具（TestHelper/Fixtures）
- [ ] 使用 XCTest 的 `addTeardownBlock` 确保资源清理

---

## 三、类型安全与 API 设计 [权重：25分]

### 3.1 消除 `as! Base` 强制转换 [+10分]
- [ ] `AxcUnifiedNumber` 中大量重复的 `if base is Int { return Int(x) as! Base }` 模式
- [ ] 方案A：使用泛型协议 + 关联类型，让每个数值类型自行实现转换
- [ ] 方案B：定义 `AxcNumericConvertible` 协议，要求类型提供 `init(from:)` 工厂方法
- [ ] 方案C：至少抽取一个通用的 `mapValue<T>(_ transform: (Float) -> T) -> Base` 辅助方法消除重复
- [ ] 消除所有运行时 `as!` 崩溃风险，改为 `as?` + 合理的 fallback 或 throws

### 3.2 Unified 协议类型收窄 [+8分]
- [ ] `String` 同时遵循 `AxcUnifiedNumber`、`AxcUnifiedColor`、`AxcUnifiedString` — 类型约束过于宽泛
- [ ] 编译期无法捕获错误（如传入非法字符串给数值 API），全部推迟到运行时
- [ ] 方案：引入中间包装类型（如 `AxcHexColorString`）替代裸 `String` 遵循协议
- [ ] 或使用 `@resultBuilder` / phantom type 在编译期区分用途
- [ ] 至少为 `AxcUnifiedColor` 移除 `Int8/Int16/Int32/Int64` 等不合理的遵循

### 3.3 错误处理机制 [+4分]
- [ ] 当前大量使用 `FatalLog` 直接崩溃，生产环境不可接受
- [ ] 引入 `Result<T, AxcBedrockError>` 或 `throws` 模式
- [ ] 提供 `xxxOrNil` / `xxxOrDefault` 两套 API，让调用者选择容错策略
- [ ] 定义清晰的错误类型层级（`AxcBedrockError`）

### 3.4 API 一致性 [+3分]
- [ ] 部分 API 命名不一致：`Create` vs `CreateOptional`，`set(x:)` vs `set(isUseReadLock:)`
- [ ] 统一工厂方法命名：`Create(xxx:)` 返回非可选，`CreateOptional(xxx:)` 返回可选
- [ ] 删除所有 deprecated API（项目未上线，无需保留兼容层）
- [ ] Builder 模式的 API 应返回 `Self` 支持链式调用

---

## 四、代码质量 [权重：15分]

### 4.1 消除代码重复（DRY）[+7分]
- [ ] `AxcUnifiedNumber` 中 abs/ceil/floor/angleToRadian/radianToAngle/limitThan 每个方法都有完全相同的类型分发逻辑（约 20 行），重复 6+ 次
- [ ] 抽取通用的类型映射方法：`func mapNumericValue(_ transform: (Float) -> Float) -> Base`
- [ ] 或使用协议扩展 + 关联类型让各类型自行处理转换
- [ ] 检查其他模块是否存在类似的复制粘贴模式

### 4.2 文件命名与组织 [+3分]
- [ ] `AxcCodableWarapper.swift` — 拼写错误，应为 `Wrapper`
- [ ] `AxcLockWarapper.swift` — 同上
- [ ] `AxcStringWarapper.swift` — 同上
- [ ] `AxcLogWrapper.swift` 文件头注释写的是 `AxcAVCaptureSessionEx.swift` — 复制粘贴遗留
- [ ] 项目早期名称 `AxcBadrock` 残留在大量文件头注释中，应统一为 `AxcBedrock`

### 4.3 访问控制 [+3分]
- [ ] `AxcCodableWarapper` 使用 `class` 而非 `struct`，且缺少 `public` 修饰符
- [ ] `AxcAssertUnifiedTransformTarget` 协议是 `internal`，但被 `public` 类型遵循
- [ ] 审查所有类型的访问级别，确保最小暴露原则
- [ ] Property wrapper 应该是 `struct` 而非 `class`（除非有明确的引用语义需求）

### 4.4 内存管理 [+2分]
- [ ] `AxcSharedTarget` 使用 Runtime 关联对象实现单例，不如 Swift 原生 `static let` 安全
- [ ] 关联对象的 key 使用 `String` 类型的 `fileprivate var`，存在潜在的 key 冲突风险
- [ ] 审查所有闭包捕获列表，确保无循环引用
- [ ] `AxcSpace` 是 `class`（引用类型），对值类型的 base 持有是否合理需要评估

---

## 五、架构设计 [权重：10分]

### 5.1 模块化 [+4分]
- [ ] 当前 podspec 虽然定义了子库，但实际上是"全量引入"模式
- [ ] SPM 中应拆分为独立的 target：`AxcBedrockCore`、`AxcBedrockUIKit`、`AxcBedrockAppKit`
- [ ] 各模块间依赖关系应明确且单向
- [ ] 用户应能只引入需要的模块，而非全量

### 5.2 协议设计 [+3分]
- [ ] `AxcSpaceProtocol` 的 `var axc` 有 `set {}` 空实现，语义不清
- [ ] `AxcSpace` 作为 `open class` 暴露了过多的继承能力，应考虑 `final` 或 `struct`
- [ ] 但由于 Swift 结构体的写时复制特性，`class` 有其合理性 — 需要在文档中明确说明设计决策

### 5.3 依赖方向 [+3分]
- [ ] `Extension` 层不应反向依赖 `Utils` 层的具体实现
- [ ] `Linkage` 目录的职责不够清晰，需要文档说明
- [ ] 检查是否存在循环依赖

---

## 六、平台兼容性与现代化 [权重：10分]

### 6.1 保持 iOS 10.0 / macOS 11.0 的适配 [+3分]
- [ ] 维持当前最低版本（社区有用户依赖）
- [ ] 使用 `@available` 标注高版本专属 API，提供低版本 fallback
- [ ] 新增的现代特性（async/await 等）通过条件编译 `#if swift(>=5.5)` + `@available(iOS 13.0, *)` 提供
- [ ] 确保核心功能在 iOS 10 上零警告编译通过

### 6.2 Swift 现代特性采用（渐进式）[+4分]
- [ ] 通过 `@available(iOS 13.0, *)` 提供 `async/await` 版本的异步 API
- [ ] 使用 `some Protocol`（Opaque Types，Swift 5.1+，iOS 10 可用）
- [ ] 通过 `@available` 标注 `@Sendable`（Swift 5.5+）
- [ ] 为 Unified 类型引入 `any Protocol`（Swift 5.6+，编译器特性，不受系统版本限制）
- [ ] 条件编译区分新旧 API，核心层保持 iOS 10 兼容

### 6.3 Swift 6 准备 [+3分]
- [ ] 开启 strict concurrency checking（`-strict-concurrency=complete`）
- [ ] 在 `@available` 范围内标注 `@MainActor` / `@Sendable`
- [ ] `AxcLockWarapper` 保持 `os_unfair_lock`（iOS 10 兼容），但修复 Swift 6 中的已知 move 语义问题（用 `class` 包装或 `ManagedBuffer`）
- [ ] 以 Swift 6 零警告为目标

---

## 七、安全性 [权重：附加分 +5]

### 7.1 输入验证 [+2分]
- [ ] 十六进制颜色字符串解析缺少格式验证
- [ ] 数值转换缺少溢出检查（如 `Int8` 接收超出范围的值）
- [ ] URL 字符串转换缺少合法性校验

### 7.2 线程安全 [+3分]
- [ ] `AxcLazyCache` 的线程安全性需要审查
- [ ] Runtime 关联对象操作的线程安全性
- [ ] 全局可变状态的并发访问保护

---

## 八、开发者体验 [权重：附加分 +5]

### 8.1 示例工程 [+2分]
- [ ] 当前 Example 工程功能单薄
- [ ] 为每个主要模块提供 Playground 或 Demo 页面
- [ ] 添加 SwiftUI 预览示例

### 8.2 API 设计文档 [+1分]
- [ ] 编写命名空间模式的设计决策文档（ADR）
- [ ] 编写 Unified 类型系统的使用指南

### 8.3 贡献指南 [+2分]
- [ ] 添加 `CONTRIBUTING.md`
- [ ] 定义 PR 模板和 Issue 模板
- [ ] 定义代码审查标准

---

## 优先级建议

按投入产出比排序：

1. **修复源码 Bug**（下方列出的实际缺陷，优先级最高）
2. **消除 `as!` 强转 + 代码重复**（影响安全性和可维护性）
3. **删除所有 deprecated API + 清理历史包袱**（项目未上线，直接断舍离）
4. **补充单元测试**（基础库没有测试 = 定时炸弹）
5. **添加 SPM 支持**（CocoaPods + SPM 双轨并行）
6. **重写 CI/CD**（自动化保障质量）
7. **Unified 协议类型收窄**（提升类型安全）
8. **文件命名修正 + 注释清理**（低成本高收益）
9. **Swift 6 全面适配**（面向未来）
10. **文档生成 + 贡献指南**（社区建设）

---

## 九、源码 Bug 与缺陷（需修复）

### 9.1 AxcLockWarapper — os_unfair_lock 内存安全问题 [严重]
**文件**: `AxcBedrock/Classes/Wrapper/AxcLockWarapper.swift`

`os_unfair_lock` 作为 struct 存储在 class 的属性中，当对象被移动（Swift ARC 可能重新分配内存）时，锁的地址会变化，导致未定义行为甚至死锁。

```swift
// ❌ 当前实现
private var lock = os_unfair_lock_s()

// ✅ 修复方案：用指针分配确保地址稳定
private let lock: UnsafeMutablePointer<os_unfair_lock> = {
    let lock = UnsafeMutablePointer<os_unfair_lock>.allocate(capacity: 1)
    lock.initialize(to: os_unfair_lock())
    return lock
}()

deinit {
    lock.deinitialize(count: 1)
    lock.deallocate()
}
```

### 9.2 AxcLockWarapper — 读操作未加锁 [严重]
**文件**: `AxcBedrock/Classes/Wrapper/AxcLockWarapper.swift`

默认 `isUseReadLock = false`，意味着 get 操作不加锁，但 set 加锁。这在多线程下会导致数据竞争（data race）——一个线程在写，另一个线程无锁读取，读到半写入的值。

```swift
// ❌ 当前实现：默认读不加锁
open var wrappedValue: T {
    get {
        if isUseReadLock { return getValue() }
        else { return value }  // 无锁读取！
    }
}
```

**修复**：读写都应该加锁，或者使用 `pthread_rwlock` 实现读写锁分离。

### 9.3 AxcArraySpace.isContent — 逻辑错误 [严重]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcArrayEx.swift`

```swift
// ❌ 当前实现：只检查第一个元素就 return 了
func isContent(by rule: ...) -> Bool {
    for index in 0 ..< base.count {
        let elmt = base[index]
        return rule(elmt)  // 第一次循环就 return，永远只检查 index=0
    }
    return false
}

// ✅ 修复
func isContent(by rule: ...) -> Bool {
    for element in base {
        if rule(element) { return true }
    }
    return false
}
```

### 9.4 AxcArraySpace.duplicates — 逻辑错误 [中等]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcArrayEx.swift`

注释说"获取序列中的重复项"，但实际实现是去重（返回唯一元素），和 `removeDuplicates` 功能一样。

```swift
// ❌ 当前实现：这是去重，不是获取重复项
func duplicates() -> [Element] {
    var result = [Element]()
    for value in base {
        if result.contains(value) == false {
            result.append(value)
        }
    }
    return result
}

// ✅ 如果要获取重复项：
func duplicates() -> [Element] {
    var seen = Set<Element>()  // 需要 Element: Hashable
    var duplicates = [Element]()
    for value in base {
        if !seen.insert(value).inserted {
            if !duplicates.contains(value) {
                duplicates.append(value)
            }
        }
    }
    return duplicates
}
```

### 9.5 AxcArraySpace.remove(at:) — 负数索引未处理 [中等]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcArrayEx.swift`

`insert` 方法检查了 `index < 0` 的情况，但 `remove(at:)` 没有。传入负数会直接调用 `base.remove(at: negativeIndex)` 导致崩溃。

```swift
// ❌ 当前
func remove(at index: Int) -> [Element] {
    var newArr = base
    if index < base.count {  // 负数也满足这个条件！
        newArr.remove(at: index)  // 崩溃
    }
    ...
}

// ✅ 修复
func remove(at index: Int) -> [Element] {
    var newArr = base
    guard index >= 0, index < base.count else {
        AxcBedrockLib.Log("移除元素越界！...")
        return newArr
    }
    newArr.remove(at: index)
    return newArr
}
```

### 9.6 Int8/Int16 等窄类型转换 — 溢出崩溃 [中等]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcIntEx.swift`

```swift
// ❌ 当前：Int(1000) 转 Int8 会直接崩溃
if let int = unifiedValue as? Int { return Int8(int) }  // Fatal error: Not enough bits

// ✅ 修复：使用 exactly 或 clamping
if let int = unifiedValue as? Int { return Int8(exactly: int) }  // 返回 nil
// 或
if let int = unifiedValue as? Int { return Int8(clamping: int) }  // 返回 127
```

### 9.7 hexData — 强制解包 [低]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcStringEx.swift`

```swift
// ❌ match! 和 UInt8(...)! 强制解包
regex.enumerateMatches(...) { match, _, _ in
    let byteString = (base as NSString).substring(with: match!.range)
    let num = UInt8(byteString, radix: 16)!
    ...
}

// ✅ 安全解包
regex.enumerateMatches(...) { match, _, _ in
    guard let match = match else { return }
    let byteString = (base as NSString).substring(with: match.range)
    guard let num = UInt8(byteString, radix: 16) else { return }
    data.append(num)
}
```

### 9.8 _AxcCGPathEx — FatalLog 在生产环境崩溃 [中等]
**文件**: `AxcBedrock/Classes/Extension/CoreGraphics/_AxcCGPathEx.swift`

路径计算中多处使用 `AxcBedrockLib.FatalLog("没有找到当前路径点")`，如果路径数据异常会直接崩溃。应改为 `guard let ... else { return nil }` 或 `continue`。

### 9.9 AxcArraySpace.object(reversed:by:) — 找到第一个后不停止 [低]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcArrayEx.swift`

```swift
// ❌ forEach 中的 return 只是跳过当前闭包，不会停止遍历
// 实际会返回最后一个匹配的元素，而非第一个
func object(reversed: Bool = false, by rule: ...) -> Element? {
    var result: Element?
    let arr = reversed ? base.reversed() : base
    arr.forEach { element in
        if rule(element) {
            result = element
            return  // 这只是 continue，不是 break！
        }
    }
    return result
}

// ✅ 修复：使用 first(where:)
func object(reversed: Bool = false, by rule: ...) -> Element? {
    let arr = reversed ? Array(base.reversed()) : base
    return arr.first(where: rule)
}
```

### 9.10 AxcArraySpace.index(of:) — 同上，找到后不停止 [低]
同 9.9 的问题，`forEach` + `return` 不会 break，会返回最后一个匹配的 index 而非第一个。

```swift
// ✅ 修复
func index(of rule: ...) -> Int? {
    return base.firstIndex(where: rule)
}
```

### 9.11 AxcSpace.uppercased — 逻辑错误 [低]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcStringEx.swift`

```swift
// ❌ 当前实现：获取的 upperStr 没有调用 .uppercased()
let upperStr = string(at: idx) ?? ""
return prefixStr + upperStr + suffixStr  // upperStr 并没有被大写化！

// ✅ 修复
let upperStr = (string(at: idx) ?? "").uppercased()
return prefixStr + upperStr + suffixStr
```

### 9.12 AxcSpace.string(at:) 中 encodingType 属性引用了未定义的 `string` [低]
**文件**: `AxcBedrock/Classes/Extension/SwiftLib/AxcStringEx.swift`

`encodingType` 属性内部引用了 `string` 变量，但上下文中没有定义这个变量（应该是 `base`）。

```swift
// ❌ 当前
if let data = string.data(using: encoding),  // string 是什么？
   let convertedString = String(data: data, encoding: encoding),
   string == convertedString

// ✅ 应该是
if let data = base.data(using: encoding),
   let convertedString = String(data: data, encoding: encoding),
   base == convertedString
```

---

## 十、任务依赖关系（执行顺序）

修改存在先后依赖，不能乱序执行：

```
第一批（无依赖，可并行）：
├── 9.x 修复所有源码 Bug
├── 4.2 文件命名修正（Warapper → Wrapper，AxcBadrock → AxcBedrock）
└── 3.4 删除所有 deprecated API

第二批（依赖第一批完成）：
├── 3.1 消除 as! 强转（需要先删除 deprecated，避免改两遍）
├── 4.1 消除代码重复（和 3.1 通常一起做）
└── 4.3 访问控制审查

第三批（依赖第二批完成）：
├── 3.2 Unified 协议类型收窄（需要 3.1 的新转换机制就位）
├── 3.3 错误处理机制（需要 3.1 完成后统一替换）
└── 7.x 安全性（输入验证、线程安全）

第四批（依赖代码稳定后）：
├── 2.x 补充单元测试（代码稳定后再写测试，避免反复改）
├── 1.1 SPM 支持（需要目录结构确定后）
└── 5.x 架构设计优化

第五批（收尾）：
├── 1.2 CI/CD
├── 1.3 代码规范工具
├── 1.5 文档生成
├── 6.x 现代化特性
└── 8.x 开发者体验
```

### 关键路径上的风险点
- 3.1（消除 as!）是最大的重构，影响面最广，改完后需要全量编译验证
- 1.1（SPM）需要在目录重命名（AppKit&UIKit → AppKitAndUIKit）之后做
- 2.x（测试）必须在代码重构完成后再写，否则测试会频繁失效

---

## 十一、源码目录结构说明

```
AxcBedrock/Classes/
├── Core/                          # 核心协议层（最底层，无依赖）
│   ├── AxcBedrockLib.swift        # 库根类，所有工具类型的命名空间容器
│   ├── AxcSpaceProtocol.swift     # .axc/.Axc 命名空间协议（核心中的核心）
│   └── Protocol/
│       ├── Target/                # 功能协议（单例、日志、模块）
│       └── Unified/               # 统一类型协议（Number、Color、Font 等）
│
├── Enum/                          # 枚举定义层（仅依赖 Core）
│   └── Axc{Name}.swift            # 方向、角度、轴向等领域枚举
│
├── Utils/                         # 工具层（依赖 Core）
│   ├── Define/                    # 类型定义（AxcEnum、AxcBlock、AxcMaker 等容器）
│   ├── Runtime/                   # ObjC Runtime 封装
│   ├── GCD/                       # 线程工具
│   ├── Regex/                     # 正则工具
│   └── ...
│
├── Extension/                     # 扩展层（依赖 Core + Utils + Enum）
│   ├── SwiftLib/                  # Swift 标准库扩展（String、Array、Int 等）
│   ├── Foundation/                # Foundation 框架扩展
│   ├── CoreGraphics/              # CG 类型扩展
│   ├── UIKit/                     # iOS 专属（仅 iOS target 编译）
│   ├── AppKit/                    # macOS 专属（仅 macOS target 编译）
│   ├── CrossPlatform/             # 跨平台共享扩展（#if canImport 切换）
│   └── {Framework}/               # 其他框架扩展
│       └── Linkage/               # 框架间桥接（如 UIColor → CGColor 转换）
│
└── Wrapper/                       # 属性包装器（依赖 Core）
    └── Axc{Name}Wrapper.swift
```

**依赖方向（单向，不可逆）：**
```
Core ← Enum ← Utils ← Extension
                 ↑         ↑
              Wrapper    Linkage（框架间桥接）
```

---

| 维度 | 当前得分 | 满分 | 达标要求 |
|------|---------|------|---------|
| 工程化基础设施 | 3/20 | 20 | SPM + CI + Lint + 文档生成全部就位 |
| 测试覆盖 | 1/20 | 20 | 核心模块 >90% 覆盖率，有效测试用例 |
| 类型安全与API设计 | 15/25 | 25 | 零 `as!`，编译期类型检查，清晰错误处理 |
| 代码质量 | 10/15 | 15 | 零重复，命名正确，访问控制合理 |
| 架构设计 | 8/10 | 10 | 模块独立，依赖清晰，设计文档完备 |
| 平台兼容性 | 6/10 | 10 | 支持 Swift 6，采用现代特性 |
| 安全性（附加） | 2/5 | 5 | 输入验证 + 线程安全 |
| 开发者体验（附加） | 2/5 | 5 | 示例 + 迁移指南 + 贡献指南 |
| **总计** | **47/110** → **归一化 7.5/10** | **110** | **完成以上全部项 → 95+/100** |
