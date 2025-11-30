// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DependenciesContainer",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "DependenciesContainer",
            targets: ["DependenciesTarget"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            exact: "1.10.0"
        )
    ],
    targets: [
        .target(
            name: "DependenciesTarget",
            dependencies: [.product(name: "Dependencies",
                                    package: "swift-dependencies")]
        )
    ]
)
