// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Strings",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Strings",
            targets: ["Strings"]),
    ],
    targets: [
        .target(
            name: "Strings",
            path: "Sources/Strings",
            resources: [
                .process("Resources/Localizable.xcstrings")
            ]),

    ]
)
