// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Extensions",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Extensions",
            targets: ["Extensions"]),
    ],
    dependencies: [
        .package(name: "FeatureComposition",
                 path: "../FeatureComposition")
    ],
    targets: [
        .target(
            name: "Extensions",
            dependencies: [.product(name: "FeatureComposition",
                                    package: "FeatureComposition")]
        ),
        .testTarget(
            name: "ExtensionsTests",
            dependencies: ["Extensions"]
        ),
    ]
)
