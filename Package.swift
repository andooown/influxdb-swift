// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftInfluxDB",
    products: [
        .library(
            name: "SwiftInfluxDB",
            targets: ["SwiftInfluxDB"]),
    ],
    dependencies: [
        .package(url: "https://github.com/yaslab/CSV.swift.git", .upToNextMinor(from: "2.4.3"))
    ],
    targets: [
        .target(
            name: "SwiftInfluxDB",
            dependencies: [
                .product(name: "CSV", package: "CSV.swift")
            ]),
        .testTarget(
            name: "SwiftInfluxDBTests",
            dependencies: [
                "SwiftInfluxDB"
            ]),
    ]
)
