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
      checksum: "3e2a15df0d0e2678006729d495a4580289cf28f482f60ca7fcb0ec226ed1d0e1"
    ),
    .binaryTarget(
      name: "libavdevice",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavdevice.zip?raw=true",
      checksum: "99f04e5988b37e086b6afbec8a7e0dd8ac894d129e9349320527b755d79cc167"
    ),
    .binaryTarget(
      name: "libavfilter",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavfilter.zip?raw=true",
      checksum: "733360ffbc9905f51585550ff7e24fbb03d76ebf6801fd2752f81c69e36562ce"
    ),
    .binaryTarget(
      name: "libavformat",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavformat.zip?raw=true",
      checksum: "f5483cd50f27387b6a3be951e2c66d740141b27faa91cf2f15ddbcf6efe8f9d0"
    ),
    .binaryTarget(
      name: "libavutil",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavutil.zip?raw=true",
      checksum: "c2ad5fbbf92a03c6a18163ec4cd84698afe58b4b8e756a4a4df9d8985acba43d"
    ),
    .binaryTarget(
      name: "libswresample",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswresample.zip?raw=true",
      checksum: "878dffe1461327699d28ec4752c3a6aca808190b7e56f0e6f83a910cfd0cf2a7"
    ),
    .binaryTarget(
      name: "libswscale",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswscale.zip?raw=true",
      checksum: "f450d90215e66b629a0927b00bf0283c002981f2c0f534b9f23196634fb2334a"
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
