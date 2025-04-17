// swift-tools-version: 6.0
import PackageDescription
import CompilerPluginSupport

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
let package = Package(
    name: "Screws",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Screws",
            targets: ["Screws"]
        ),
        .library(
            name: "ScrewsDynamic",
            type: .dynamic,
            targets: ["Screws"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/sjavora/swift-syntax-xcframeworks.git", from: "600.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Screws",
            dependencies: ["ScrewsMacros"]
        ),
        .testTarget(
            name: "ScrewsTests",
            dependencies: [
                "Screws",
                .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks")
            ]
        ),
        .macro(
          name: "ScrewsMacros",
          dependencies: [
            .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks")
          ]
        ),
    ]
)
#else
let package = Package(
    name: "Screws",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Screws",
            targets: ["Screws"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Screws",
            dependencies: ["ScrewsMacros"]
        ),
        .testTarget(
            name: "ScrewsTests",
            dependencies: [
                "Screws",
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
            ]
        ),
        .macro(
          name: "ScrewsMacros",
          dependencies: [
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
          ]
        ),
    ]
)
#endif
