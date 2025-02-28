// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]),
    ],
    dependencies: [
        .package(name: "NetworkProtocols",
                 path: "../NetworkProtocols"),
        .package(name: "SessionProtocols",
                 path: "../SessionProtocols"),
        .package(name: "DependenciesContainer",
                 path: "../DependenciesContainer")
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [.product(name: "NetworkProtocols",
                                    package: "NetworkProtocols"),
                           .product(name: "SessionProtocols",
                                    package: "SessionProtocols"),
                           .product(name: "DependenciesContainer",
                                    package: "DependenciesContainer")]
        ),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]
        ),
    ]
)
