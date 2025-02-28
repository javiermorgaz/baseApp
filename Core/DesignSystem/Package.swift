// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]),
    ],
    dependencies: [
        .package(name: "Strings",
                 path: "../Strings"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [.product(name: "Strings",
                                    package: "Strings")],
            path: "Sources/DesignSystem",
            resources: [
                .process("Resources/Assets.xcassets"),
                .process("Resources/Colors.xcassets")
            ]),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"]
        ),
    ]
)
