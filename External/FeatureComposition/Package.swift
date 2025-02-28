// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeatureComposition",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "FeatureComposition",
            targets: ["FeatureComposition"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            exact: "1.17.1"
        )
    ],
    targets: [
        .target(
            name: "FeatureComposition",
            dependencies: [.product(name: "ComposableArchitecture",
                                    package: "swift-composable-architecture")])
    ]
)
