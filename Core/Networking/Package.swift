// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(name: "NetworkingProtocols",
                 path: "../NetworkingProtocols"),
        .package(name: "SessionProtocols",
                 path: "../SessionProtocols"),
        .package(name: "DependenciesContainer",
                 path: "../DependenciesContainer")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [.product(name: "NetworkingProtocols",
                                    package: "NetworkingProtocols"),
                           .product(name: "SessionProtocols",
                                    package: "SessionProtocols"),
                           .product(name: "DependenciesContainer",
                                    package: "DependenciesContainer")]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
    ]
)
