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
      url: "https://github.com/RondaHe/sing-box-lib/releases/download/karing-2102/Libbox.xcframework.zip",
      checksum: "dca0c5e76c1e1bd602d522f02cac6e1ececc643e778845f4105cee8f5a43de10"
    )
  ]
)
