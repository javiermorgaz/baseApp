// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature2",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Feature2",
            targets: ["Feature2"]),
    ],
    dependencies: [
        .package(name: "DependenciesContainer",
                 path: "../DependenciesContainer"),
        .package(name: "FeatureComposition",
                 path: "../FeatureComposition"),
        .package(name: "SessionProtocols",
                 path: "../SessionProtocols"),
        .package(name: "NetworkProtocols",
                 path: "../NetworkProtocols"),
        .package(name: "DesignSystem",
                 path: "../DesignSystem"),
        .package(name: "ViewTesting",
                 path: "../ViewTesting"),
    ],
    targets: [
        .target(
            name: "Feature2",
            dependencies: [.product(name: "DependenciesContainer",
                                    package: "DependenciesContainer"),
                           .product(name: "FeatureComposition",
                                    package: "FeatureComposition"),
                           .product(name: "SessionProtocols",
                                    package: "SessionProtocols"),
                           .product(name: "NetworkProtocols",
                                    package: "NetworkProtocols"),
                           .product(name: "DesignSystem",
                                    package: "DesignSystem")]
        ),
        .testTarget(
            name: "Feature2Tests",
            dependencies: ["Feature2",
                           .product(name: "ViewTesting",
                                    package: "ViewTesting")]
        ),
    ]
)
