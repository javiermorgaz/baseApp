// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Register",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Register",
            targets: ["Register"]),
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
        .package(name: "Extensions",
                 path: "../Extensions"),
        .package(name: "DesignSystem",
                 path: "../DesignSystem"),
        .package(name: "Strings",
                 path: "../Strings"),
        .package(name: "ViewTesting",
                 path: "../ViewTesting")
    ],
    targets: [
        .target(
            name: "Register",
            dependencies: [.product(name: "DependenciesContainer",
                                    package: "DependenciesContainer"),
                           .product(name: "FeatureComposition",
                                    package: "FeatureComposition"),
                           .product(name: "SessionProtocols",
                                    package: "SessionProtocols"),
                           .product(name: "NetworkProtocols",
                                    package: "NetworkProtocols"),
                           .product(name: "Extensions",
                                    package: "Extensions"),
                           .product(name: "DesignSystem",
                                    package: "DesignSystem"),
                           .product(name: "Strings",
                                    package: "Strings")]),
        .testTarget(
            name: "RegisterTests",
            dependencies: ["Register",
                           .product(name: "ViewTesting",
                                    package: "ViewTesting")]
        ),
    ]
)
