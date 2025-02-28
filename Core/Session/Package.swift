// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Session",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Session",
            targets: ["Session"]),
    ],
    dependencies: [
        .package(name: "SessionProtocols",
                 path: "../SessionProtocols")
    ],
    targets: [
        .target(
            name: "Session",
            dependencies: [.product(name: "SessionProtocols",
                                    package: "SessionProtocols")]
        ),
        .testTarget(
            name: "SessionTests",
            dependencies: ["Session"]
        ),
    ]
)