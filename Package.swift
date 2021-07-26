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
      checksum: "48b75120c752a0e077ce6e3c84ea7b373b9af973088c0b406b077d666db52b5a"
    ),
    .binaryTarget(
      name: "libavdevice",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavdevice.zip?raw=true",
      checksum: "5f7e780f4dbd01272ace2dd169809506f08ae2a229db5f3a5091579bf4959f42"
    ),
    .binaryTarget(
      name: "libavfilter",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavfilter.zip?raw=true",
      checksum: "55c51b6184f5560c0327a190078e92d30cba0e03448f26b32b43e55f281a9dc9"
    ),
    .binaryTarget(
      name: "libavformat",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavformat.zip?raw=true",
      checksum: "b9b365d8b2c2c757d297d3a0ebba3b9b1b9b8a9da5a7b1434fd63c367d7262b1"
    ),
    .binaryTarget(
      name: "libavutil",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libavutil.zip?raw=true",
      checksum: "088ead89b7ebfb8e25e4a70bbb795b668e3dd14fbe84f769b9d8d41ec6fca975"
    ),
    .binaryTarget(
      name: "libswresample",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswresample.zip?raw=true",
      checksum: "d474d0f8c059d9a10bd77aff09afad112009e6d06dc8659514fa947df4fdfe58"
    ),
    .binaryTarget(
      name: "libswscale",
      url: "https://github.com/jordanschactman/SwiftFFmpeg/blob/master/xcframework/libswscale.zip?raw=true",
      checksum: "a9f8b98753879280413ada694038bf74fc3e99097551ccdfdec5813d06491dfd"
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
