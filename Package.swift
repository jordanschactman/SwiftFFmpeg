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
      checksum: "c15b0738c4ab1282a83fea88b7b2170b0fb95fb74db31a9e06c5c734150c316c"
    ),
    .binaryTarget(
      name: "libavdevice",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavdevice.zip?raw=true",
      checksum: "dd177148b681fa767c6b24c8843024dfd706d4bac00c9dcc15e03a958c47ce7a"
    ),
    .binaryTarget(
      name: "libavfilter",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavfilter.zip?raw=true",
      checksum: "f5ecf8799b2ccaca485413d7f447e2fb3c040dd22f7c17256bb9e2b100e68046"
    ),
    .binaryTarget(
      name: "libavformat",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavformat.zip?raw=true",
      checksum: "71c4f2f670e1e4765a90d944989b4f1dcb531be2a0b681c4691bfdee6383f8f1"
    ),
    .binaryTarget(
      name: "libavutil",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavutil.zip?raw=true",
      checksum: "86f6955e75ab655bfadbd93d300ef2a89ed7eb1bb8046e97a47362541be21930"
    ),
    .binaryTarget(
      name: "libpostproc",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libpostproc.zip?raw=true",
      checksum: "442e0111dc4fb00e62a807a668f333a5e07005774ffaaec44bba8498ff18f224"
    ),
    .binaryTarget(
      name: "libswresample",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswresample.zip?raw=true",
      checksum: "ba6c49405ae6eee46c4a1222b3fa34b5acbcc06cabb63146ba42960182f566a3"
    ),
    .binaryTarget(
      name: "libswscale",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswscale.zip?raw=true",
      checksum: "812eb3e354798e132fc3a3a2c1aa540cd7aa3150aec143ae9c063ab55718623e"
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
