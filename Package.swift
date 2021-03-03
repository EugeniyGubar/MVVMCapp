// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Eigen",
    defaultLocalization: "en",
    products: [
        .library(name: "MVVMCapp", type: .dynamic, targets: ["DangerDependencies"]),
    ],
    dependencies: [
        .package(name: "danger-swift", url: "https://github.com/danger/swift.git", from: "1.5.2")
    ],
    targets: [
        .target(
            name: "DangerDependencies",
            dependencies: [
                .product(name: "Danger", package: "danger-swift")
            ],
            path: "",
            sources: ["DangerRequiresThis.swift"]
        )]
)