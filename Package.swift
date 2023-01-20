// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SwiftOBSConnect",
    platforms: [
        .macOS(.v13), .iOS(.v16), .tvOS(.v16)
    ], products: [
        .library(
            name: "SwiftOBSConnect",
            targets: ["SwiftOBSConnect"]),
    ],
    dependencies: [
        .package(
            name: "swift-web-connect",
            path: "~/Workspace/SwiftWebConnect"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "SwiftOBSConnectClient",
            dependencies: ["SwiftOBSConnect"]),
        .target(
            name: "SwiftOBSConnect",
            dependencies: [
                .product(name: "SwiftWebConnect", package: "swift-web-connect"),
                .product(name: "Crypto", package: "swift-crypto")
            ]),
        .testTarget(
            name: "SwiftOBSConnectTests",
            dependencies: ["SwiftOBSConnect"]),
    ]
)
