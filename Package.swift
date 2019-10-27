// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Imitate",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Imitate",
            targets: ["Imitate"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Imitate",
            dependencies: []),
        .testTarget(
            name: "ImitateTests",
            dependencies: ["Imitate"]),
    ]
)
