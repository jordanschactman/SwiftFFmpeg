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
        "libpostproc",
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
      checksum: "ef02bf99643717d4a5dfc65dc23f49e374ca98fb9ea9b1b4e8d89fc16f79b9e8"
    ),
    .binaryTarget(
      name: "libavdevice",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavdevice.zip?raw=true",
      checksum: "7bd46ad888751b6d7b861c9eb26d47127e75bca6de240f203e9bf5e2b81cb821"
    ),
    .binaryTarget(
      name: "libavfilter",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavfilter.zip?raw=true",
      checksum: "eb6f11fd5c582dcbb2b45c7c7c4a8269de5812d24a3628c1539ebe50dc4fad93"
    ),
    .binaryTarget(
      name: "libavformat",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavformat.zip?raw=true",
      checksum: "078d04f346bef3e02ee8c7f9c8ec95cb34791142cc30dc85805db3b461902b90"
    ),
    .binaryTarget(
      name: "libavutil",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavutil.zip?raw=true",
      checksum: "f4fba4f9d0c7f0e00c8bb9da2bc8b316b1b9d569e51655c27b69f10cf1266671"
    ),
    .binaryTarget(
      name: "libpostproc",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libpostproc.zip?raw=true",
      checksum: "6e626537436943289d862003de678eecb243bd15548658eb744045735ecc7ce6"
    ),
    .binaryTarget(
      name: "libswresample",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswresample.zip?raw=true",
      checksum: "04d59e6f8c8fd62932c8d56ac68fbe2ec59e70751b8fffcc6d9adfc60509c816"
    ),
    .binaryTarget(
      name: "libswscale",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswscale.zip?raw=true",
      checksum: "e2649f806845560eb98e8476a87e3444bd26ffbf30f44742d40aad2fe583ce8e"
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
