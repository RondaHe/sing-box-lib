<div align="right">

**简体中文** | [English](./README.en.md)

</div>

# Libbox for Apple

自动编译 [`Libbox.xcframework`](https://github.com/SagerNet/sing-box) —— 把
[sing-box](https://github.com/SagerNet/sing-box) 的 Go 内核通过 `gomobile` 编译成苹果平台可用的
framework，让你在 Swift 里(NetworkExtension、主 App 等)直接 `import Libbox`，无需自己碰 Go
工具链。

一个 GitHub Actions 工作流会按你指定的 ref 拉取 sing-box 源码，在 macOS runner 上编出
xcframework，并作为 GitHub Release 发布 —— 同时让本仓库成为一个开箱即用的 Swift Package。

> Fork 自 [EbrahimTahernejad/sing-box-lib](https://github.com/EbrahimTahernejad/sing-box-lib)，
> 已更新为跟随 sing-box 的 1.14.0-alpha 线。

## 编译一个 Release

1. 进 **Actions** 标签页 → **Release** → **Run workflow**。
2. 填写输入:
   - **`version`** —— 要创建的 release tag。请用**合法的 SemVer**(如 `1.14.0-alpha.39`),这样
     Swift Package Manager 才能按版本解析。
   - **`tag`** —— 要编译的 sing-box git tag,默认 `v1.14.0-alpha.39`,可自行改成其它 tag。
3. 运行。几分钟后工作流会:
   - 编出 `Libbox.xcframework`(含 iOS 真机 + 模拟器 slice);
   - 把 `Libbox.xcframework.zip` 挂到新建的 Release 上;
   - 重写并打 tag `Package.swift`,指向该产物及其 checksum。

## 使用产物

### 作为 Swift Package(用于新项目)

```swift
.package(url: "https://github.com/RondaHe/sing-box-lib.git", exact: "1.14.0-alpha.39")
```

或在 Xcode 里:**File → Add Package Dependencies…** 粘贴仓库 URL。Xcode 会自动下载对应 release 的
zip(checksum 已写进 `Package.swift`)。

### 作为本地 xcframework(用于 sing-box-for-apple)

[sing-box-for-apple](https://github.com/SagerNet/sing-box-for-apple) 是把 `Libbox.xcframework`
当作**工程根目录下的本地 framework**(Embed & Sign)来引用的,由主 App 和 NetworkExtension 两个
target 共享 —— 而不是走 SPM。对该工程:

1. 从 Release 下载 `Libbox.xcframework.zip`;
2. 解压;
3. 把 `Libbox.xcframework` 拷到 sing-box-for-apple 工程根目录。

## 版本匹配

`Libbox` 是从 sing-box 的 `experimental/libbox` 包生成的 Go 侧 API;你的 Swift 代码只能调用**它编译
自的那个 sing-box 版本里存在的符号**。请编译与你客户端匹配的 ref:

- **sing-box-for-apple 的 `dev` 分支** ↔ sing-box 的 **1.14.0-alpha 线**(上游锁步开发)。
- 如果用 `Libbox` 编译时报 `cannot find 'LibboxXxx' in scope`,说明内核比你的客户端旧 —— 编一个更新
  的 `tag`。**编译器是唯一裁判。**

工作流里的 Go 版本(`go-version`)必须满足 sing-box 的 `go.mod`(当前为 `go 1.24.7`)。上游提高要求
时记得同步提升。

## 致谢

- [SagerNet/sing-box](https://github.com/SagerNet/sing-box) —— 内核。
- [EbrahimTahernejad/sing-box-lib](https://github.com/EbrahimTahernejad/sing-box-lib) —— 本 fork
  所基于的原始编译工作流。

## 许可

sing-box 内核以 GPL-3.0-or-later 授权;此处产出的编译产物同样继承该许可。
