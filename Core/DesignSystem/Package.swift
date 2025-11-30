// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
    ],
    dependencies: [
        .package(name: "Strings", path: "../Strings"),
        // If DesignSystem doesn’t import ComposableArchitecture or Dependencies directly, you can omit these.
        // Keeping this minimal since the provided sources don’t import them.
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "Strings", package: "Strings")
            ],
            path: "Sources/DesignSystem",
            resources: [
                .process("Resources/Assets.xcassets"),
                .process("Resources/Colors.xcassets")
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"]
        ),
    ]
)
