// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Welcome",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Welcome",
            targets: ["Welcome"]
        ),
    ],
    dependencies: [
        // Local packages
        .package(name: "DependenciesContainer", path: "../DependenciesContainer"),
        .package(name: "FeatureComposition", path: "../FeatureComposition"),
        .package(name: "NetworkingProtocols", path: "../NetworkingProtocols"),
        .package(name: "SessionProtocols", path: "../SessionProtocols"),
        .package(name: "Extensions", path: "../Extensions"),
        .package(name: "DesignSystem", path: "../DesignSystem"),
        .package(name: "Strings", path: "../Strings"),
        .package(name: "Error", path: "../Error"),
        .package(name: "ViewTesting", path: "../ViewTesting"),
        // Point-Free packages
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "Welcome",
            dependencies: [
                .product(name: "NetworkingProtocols", package: "NetworkingProtocols"),
                .product(name: "SessionProtocols", package: "SessionProtocols"),
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "DependenciesContainer", package: "DependenciesContainer"),
                .product(name: "Extensions", package: "Extensions"),
                .product(name: "Strings", package: "Strings"),
                .product(name: "Error", package: "Error"),
                .product(name: "FeatureComposition", package: "FeatureComposition"),
                // Point-Free products
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .testTarget(
            name: "WelcomeTests",
            dependencies: [
                "Welcome",
                .product(name: "ViewTesting", package: "ViewTesting")
            ]
        ),
    ]
)
