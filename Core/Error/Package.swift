// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Error",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Error",
            targets: ["Error"]),
    ],
    dependencies: [
        .package(name: "FeatureComposition",
                 path: "../FeatureComposition"),
        .package(name: "DesignSystem",
                 path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "Error",
            dependencies: [.product(name: "FeatureComposition",
                                    package: "FeatureComposition"),
                           .product(name: "DesignSystem",
                                    package: "DesignSystem")]
        )
    ]
)
