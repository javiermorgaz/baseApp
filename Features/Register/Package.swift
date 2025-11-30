// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Register",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Register",
            targets: ["Register"]
        ),
    ],
    dependencies: [
        // Local packages
        .package(name: "DependenciesContainer", path: "../DependenciesContainer"),
        .package(name: "FeatureComposition", path: "../FeatureComposition"),
        .package(name: "SessionProtocols", path: "../SessionProtocols"),
        .package(name: "NetworkingProtocols", path: "../NetworkingProtocols"),
        .package(name: "Extensions", path: "../Extensions"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Strings", path: "../Strings"),
        .package(name: "ViewTesting", path: "../ViewTesting"),
        // Point-Free packages
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "Register",
            dependencies: [
                .product(name: "DependenciesContainer", package: "DependenciesContainer"),
                .product(name: "FeatureComposition", package: "FeatureComposition"),
                .product(name: "SessionProtocols", package: "SessionProtocols"),
                .product(name: "NetworkingProtocols", package: "NetworkingProtocols"),
                .product(name: "Extensions", package: "Extensions"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Strings", package: "Strings"),
                // Point-Free products
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .testTarget(
            name: "RegisterTests",
            dependencies: [
                "Register",
                .product(name: "ViewTesting", package: "ViewTesting")
            ]
        ),
    ]
)
