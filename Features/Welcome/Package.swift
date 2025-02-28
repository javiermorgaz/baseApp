// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Welcome",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Welcome",
            targets: ["Welcome"]),
    ],
    dependencies: [
        .package(name: "DependenciesContainer",
                 path: "../DependenciesContainer"),
        .package(name: "FeatureComposition",
                 path: "../FeatureComposition"),
        .package(name: "NetworkProtocols",
                 path: "../NetworkProtocols"),
        .package(name: "SessionProtocols",
                 path: "../SessionProtocols"),
        .package(name: "Extensions",
                 path: "../Extensions"),
        .package(name: "DesignSystem",
                 path: "../DesignSystem"),
        .package(name: "Strings",
                 path: "../Strings"),
        .package(name: "Error",
                 path: "../Error"),
        .package(name: "ViewTesting",
                 path: "../ViewTesting")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Welcome",
            dependencies: [.product(name: "NetworkProtocols",
                                    package: "NetworkProtocols"),
                           .product(name: "SessionProtocols",
                                    package: "SessionProtocols"),
                           .product(name: "DesignSystem",
                                    package: "DesignSystem"),
                           .product(name: "DependenciesContainer",
                                    package: "DependenciesContainer"),
                           .product(name: "Extensions",
                                    package: "Extensions"),
                           .product(name: "Strings",
                                    package: "Strings"),
                           .product(name: "Error",
                                    package: "Error"),
                           .product(name: "FeatureComposition",
                                    package: "FeatureComposition")]
        ),
        .testTarget(
            name: "WelcomeTests",
            dependencies: ["Welcome",
                           .product(name: "ViewTesting",
                                    package: "ViewTesting")]
        ),
    ]
)
