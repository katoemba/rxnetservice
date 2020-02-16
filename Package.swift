// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RxNetService",
    platforms: [.macOS(.v10_11), .iOS(.v9), .tvOS(.v9), .watchOS(.v3)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "RxNetService", targets: ["RxNetService"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RxNetService",
            dependencies: ["RxSwift", "RxCocoa"]),
        .testTarget(
            name: "RxNetServiceTests",
            dependencies: ["RxNetService"])
    ]
)
