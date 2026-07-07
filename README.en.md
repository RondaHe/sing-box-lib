<div align="right">

[简体中文](./README.md) | **English**

</div>

# Libbox for Apple

Automated build of [`Libbox.xcframework`](https://github.com/SagerNet/sing-box) — the Go core of
[sing-box](https://github.com/SagerNet/sing-box) compiled for Apple platforms via `gomobile`, so
you can `import Libbox` from Swift (NetworkExtension, main app, etc.) without touching the Go
toolchain yourself.

A GitHub Actions workflow clones sing-box at a ref you choose, builds the xcframework on a macOS
runner, and publishes it as a GitHub Release — which also makes this repo a ready-to-use Swift
Package.

> Fork of [EbrahimTahernejad/sing-box-lib](https://github.com/EbrahimTahernejad/sing-box-lib),
> updated to track sing-box's 1.14.0-alpha line.

## Building a release

1. Go to the **Actions** tab → **Release** → **Run workflow**.
2. Fill in the inputs:
   - **`version`** — the release tag to create. Use a valid **SemVer**, e.g. `1.14.0-alpha.39`, so
     Swift Package Manager can resolve it by version.
   - **`tag`** — the sing-box git tag to build. Defaults to `v1.14.0-alpha.39`; you can set any tag.
3. Run it. After a few minutes the workflow will:
   - build `Libbox.xcframework` (iOS device + simulator slices),
   - attach `Libbox.xcframework.zip` to a new Release,
   - rewrite and tag `Package.swift` to point at that asset with its checksum.

## Using the output

### As a Swift Package (for new projects)

```swift
.package(url: "https://github.com/RondaHe/sing-box-lib.git", exact: "1.14.0-alpha.39")
```

Or in Xcode: **File → Add Package Dependencies…** and paste the repo URL. Xcode downloads the
matching release zip automatically (checksum is baked into `Package.swift`).

### As a local xcframework (for sing-box-for-apple)

[sing-box-for-apple](https://github.com/SagerNet/sing-box-for-apple) references `Libbox.xcframework`
as a **local framework at the project root** (Embed & Sign), shared by both the app and the
NetworkExtension target — not via SPM. For that project:

1. Download `Libbox.xcframework.zip` from the Release.
2. Unzip it.
3. Copy `Libbox.xcframework` into the sing-box-for-apple project root.

## Version matching

`Libbox` is the Go-side API generated from sing-box's `experimental/libbox` package; your Swift code
can only call symbols that exist in the sing-box revision it was built from. Build the ref that
matches your client:

- **sing-box-for-apple `dev` branch** ↔ sing-box's **1.14.0-alpha line** (kept in lockstep by
  upstream).
- If a build against `Libbox` fails to compile with `cannot find 'LibboxXxx' in scope`, the core is
  older than your client — build a newer `tag`. The compiler is the source of truth.

The Go version in the workflow (`go-version`) must satisfy sing-box's `go.mod` (currently
`go 1.24.7`). Bump it when upstream raises the requirement.

## Credits

- [SagerNet/sing-box](https://github.com/SagerNet/sing-box) — the core.
- [EbrahimTahernejad/sing-box-lib](https://github.com/EbrahimTahernejad/sing-box-lib) — the
  original build workflow this fork is based on.

## License

The sing-box core is licensed under GPL-3.0-or-later; builds produced here inherit that license.
