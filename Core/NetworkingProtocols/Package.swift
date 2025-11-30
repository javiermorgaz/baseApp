// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkingProtocols",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "NetworkingProtocols",
            targets: ["NetworkingProtocols"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NetworkingProtocols"
        )
    ]
)
