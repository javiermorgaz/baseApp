// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewTesting",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ViewTesting",
            targets: ["ViewTesting"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/nalexn/ViewInspector",
            exact: "0.10.0"
        ),
    ],
    targets: [
        .target(
            name: "ViewTesting",
            dependencies: ["ViewInspector"])
    ]
)
