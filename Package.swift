// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pharos",
    platforms: [
        .iOS(.v12),
        .macOS(.v12),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "Pharos",
            targets: ["Pharos"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.0")
    ],
    targets: [
        .target(
            name: "Pharos",
            dependencies: [],
            path: "Pharos/Classes"
        ),
        .testTarget(
            name: "PharosTests",
            dependencies: [
                "Pharos", "Quick", "Nimble"
            ],
            path: "Example/Tests",
            exclude: ["Info.plist"]
        )
    ]
)
