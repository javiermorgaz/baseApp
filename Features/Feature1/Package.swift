// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature1",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Feature1",
            targets: ["Feature1"]),
    ],
    dependencies: [
        .package(name: "DependenciesContainer",
                 path: "../DependenciesContainer"),
        .package(name: "FeatureComposition",
                 path: "../FeatureComposition"),
        .package(name: "SessionProtocols",
                 path: "../SessionProtocols"),
        .package(name: "NetworkingProtocols",
                 path: "../NetworkingProtocols"),
        .package(name: "DesignSystem",
                 path: "../DesignSystem"),
        .package(name: "ViewTesting",
                 path: "../ViewTesting"),
    ],
    targets: [
        .target(
            name: "Feature1",
            dependencies: [.product(name: "DependenciesContainer",
                                    package: "DependenciesContainer"),
                           .product(name: "FeatureComposition",
                                    package: "FeatureComposition"),
                           .product(name: "SessionProtocols",
                                    package: "SessionProtocols"),
                           .product(name: "NetworkingProtocols",
                                    package: "NetworkingProtocols"),
                           .product(name: "DesignSystem",
                                    package: "DesignSystem")]
        ),
        .testTarget(
            name: "Feature1Tests",
            dependencies: ["Feature1",
                           .product(name: "ViewTesting",
                                    package: "ViewTesting")]
        ),
    ]
)
