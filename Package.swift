// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftFFmpeg",
  platforms: [.iOS(.v9), .macOS(.v10_10), .tvOS(.v10)],
  products: [
    .library(
      name: "SwiftFFmpeg",
      targets: ["SwiftFFmpeg"]
    )
  ],
  targets: [
    .target(
      name: "SwiftFFmpeg",
      dependencies: ["CFFmpeg"]
    ),
    .target(
      name: "CFFmpeg",
      dependencies: [
        "libavcodec",
        "libavdevice",
        "libavfilter",
        "libavformat",
        "libavutil",
        "libswresample",
        "libswscale",
      ],
      linkerSettings: [
        .linkedLibrary("z"),
        .linkedLibrary("bz2"),
        .linkedLibrary("iconv"),
        .linkedLibrary("lzma"),
        .linkedFramework("Security"),
        .linkedFramework("CoreMedia"),
        .linkedFramework("CoreVideo"),
        .linkedFramework("AudioToolbox"),
        .linkedFramework("VideoToolbox"),
        .linkedFramework("OpenGL"),
        .linkedFramework("CoreImage"),
        .linkedFramework("AppKit"),
      ]
    ),
    .binaryTarget(
      name: "libavcodec",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavcodec.zip?raw=true",
      checksum: "542c103a7633289f50e19c3e65fd64dc37a7bd44aec6b330d87ec905a323906b"
    ),
    .binaryTarget(
      name: "libavdevice",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavdevice.zip?raw=true",
      checksum: "1ff3b05d225ea4f638d2bec4938e027f36643e80081be8bba2dc3afbe658318d"
    ),
    .binaryTarget(
      name: "libavfilter",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavfilter.zip?raw=true",
      checksum: "52a59c1bce61544fd4fb86673e584a70161b59b7e20d1a8060b74244bccd0f66"
    ),
    .binaryTarget(
      name: "libavformat",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavformat.zip?raw=true",
      checksum: "e5d3f3aa23e49b8c73ddc7be614f5cbb37e74f29e3e812f453858bd64fa99e93"
    ),
    .binaryTarget(
      name: "libavutil",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavutil.zip?raw=true",
      checksum: "7366ca1cbf7dcff7d9c54fe7c653ceb7fe66c6f17a8af6b70a91b65a9c09d0fa"
    ),
    .binaryTarget(
      name: "libswresample",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswresample.zip?raw=true",
      checksum: "1e4b5dabcf33868484e7b7852d564d23116613749549d76ac3c21f0a59b646ea"
    ),
    .binaryTarget(
      name: "libswscale",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswscale.zip?raw=true",
      checksum: "1412f32007cfd88c91a822fa21232199b4442e3ce053ffd03ab284dd6840c789"
    ),
    .target(
      name: "SwiftFFmpegExamples",
      dependencies: ["SwiftFFmpeg"]
    ),
    .testTarget(
      name: "SwiftFFmpegTests",
      dependencies: ["SwiftFFmpeg"]
    ),
  ]
)
