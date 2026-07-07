// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "Libbox",
  platforms: [.iOS(.v12)],
  products: [
    .library(name: "Libbox", targets: ["Libbox"]),
  ],
  targets: [
    .binaryTarget(
      name: "Libbox",
      url: "https://github.com/RondaHe/sing-box-lib/releases/download/1.14.0-alpha.39/Libbox.xcframework.zip",
      checksum: "61a82d40be323bee2dde550f5e57765e216294f7ba75c43ce952628cef4ba9ea"
    )
  ]
)
