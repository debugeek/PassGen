// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "PassGen",
    products: [
        .library(
            name: "PassGen",
            targets: ["PassGen"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "PassGen",
            dependencies: []),
    ]
)
